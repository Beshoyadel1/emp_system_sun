import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:emp_system_sun/features/notifications/data/model/notification_payload.dart';
import 'package:emp_system_sun/features/notifications/data/model/receive_message_notification_model/receive_message_notification_model.dart';
import 'package:emp_system_sun/features/technical_support/data/datasource/employee_chat_repository.dart';
import 'package:emp_system_sun/features/technical_support/data/model/chat_events/chat_events.dart';
import 'package:emp_system_sun/features/technical_support/data/model/employee_chat_model.dart';
import 'employee_chat_state.dart';

class EmployeeChatCubit extends Cubit<EmployeeChatState> {
  final EmployeeChatRepository chatRepository;
  StreamSubscription<ReceiveMessageData>? _chatEventsSub;
  final Set<String> _historyLoaded = {}, _pendingChats = {};
  final Map<String, Object> _historyRequests = {};
  final Map<String, String> _chatAliases = {};
  final Set<String> _deletedSupportKeys = {};
  final Set<int> _deletedSupportMessageIds = {};
  Object? _sendToken;
  String? _sendingChatKey;
  Future<void>? _initialLoad;
  bool _messagesLoaded = false, _teamLoaded = false;
  int _cachedUserId = 0, _cachedUserType = UserType.employeeUser;
  int _session = 0, _messagesRequest = 0, _supportGeneration = 0;
  int _selectionVersion = 0, _nextLocalId = -1;

  EmployeeChatCubit({this.chatRepository = const EmployeeChatRepository()})
      : super(const EmployeeChatState()) {
    _chatEventsSub =
        ChatEvents.instance.stream.listen(_handleRealtimeChatEvent);
  }

  int get currentUserId => _cachedUserId;
  int get currentUserType => _cachedUserType;
  int get selectionVersion => _selectionVersion;
  int get totalUnreadCount =>
      state.calculateTotalUnread(currentUserId, currentUserType);
  String _chatKey(int? id, int? type) => '$id:$type';
  String _key(GetAllMessagesModel chat) =>
      _chatKey(chat.touser, chat.tousertype);
  String _resolve(String key) => _chatAliases[key] ?? key;
  bool _support(GetAllMessagesModel chat) =>
      chat.tousertype == UserType.adminUser;
  bool _selected(GetAllMessagesModel chat) =>
      state.selectedChat != null && _key(state.selectedChat!) == _key(chat);
  bool get _loadingSelected =>
      state.selectedChat != null &&
      _historyRequests.keys
          .any((key) => _resolve(key) == _key(state.selectedChat!));

  GetAllMessagesModel? _find(String key) {
    for (final chat in state.allMessages) {
      if (_key(chat) == _resolve(key)) return chat;
    }
    return null;
  }

  void _trackChat(GetAllMessagesModel chat) {
    if (state.isLoadingMessages) _pendingChats.add(_key(chat));
  }

  GetAllMessagesModel _copyChat(
    GetAllMessagesModel chat, {
    int? toUser,
    List<ChatMessageModel>? messages,
    bool? closed,
    bool? noOldMessages,
    int? unread,
  }) =>
      GetAllMessagesModel(
        touser: toUser ?? chat.touser,
        tousertype: chat.tousertype,
        userName: chat.userName,
        image: chat.image,
        messages: messages ?? chat.messages,
        closed: closed ?? chat.closed,
        noOldMessages: noOldMessages ?? chat.noOldMessages,
        unViewedMessagesCount: unread ?? chat.unViewedMessagesCount,
        directLastMessage: chat.directLastMessage,
      );

  void _replaceChat(GetAllMessagesModel chat,
      {Set<String> previousKeys = const {}}) {
    _trackChat(chat);
    final selected = _selected(chat) ||
        (state.selectedChat != null &&
            previousKeys.contains(_key(state.selectedChat!)));
    final list = [
      chat,
      ...state.allMessages.where(
          (c) => _key(c) != _key(chat) && !previousKeys.contains(_key(c)))
    ];
    if (selected) {
      ChatEvents.instance.activeChatUserId = chat.touser;
      ChatEvents.instance.activeChatUserType = chat.tousertype;
    }
    emit(state.copyWith(
      allMessages: list,
      filteredMessages: _applySearch(list, state.searchQuery),
      selectedChat: selected ? chat : state.selectedChat,
    ));
  }

  void configureUser(int userId, int userType) {
    if (_cachedUserId != userId || _cachedUserType != userType) reset();
    _cachedUserId = userId;
    _cachedUserType = userType;
  }

  void openConversation(int userId, int userType, String name) {
    if (isClosed) return;
    if (userType == UserType.adminUser &&
        _deletedSupportKeys.contains(_resolve(_chatKey(userId, userType)))) {
      return;
    }
    selectChat(_find(_chatKey(userId, userType)) ??
        GetAllMessagesModel(
          touser: userId,
          tousertype: userType,
          userName: name,
          messages: [],
        ));
  }

  /// The support entry reuses an open assignment, or starts a fresh ticket at 0.
  void openSupportConversation({String name = 'الدعم الفني'}) {
    if (isClosed) return;
    final active = state.allMessages.where((c) => _support(c) && !c.isClosed);
    if (active.isNotEmpty) {
      selectChat(active.first);
      return;
    }
    _supportGeneration++;
    _deletedSupportKeys.remove(_chatKey(0, UserType.adminUser));
    _chatAliases.clear();
    _historyLoaded.removeWhere((key) => key.endsWith(':${UserType.adminUser}'));
    _historyRequests
        .removeWhere((key, _) => key.endsWith(':${UserType.adminUser}'));
    final list = state.allMessages.where((c) => !_support(c)).toList();
    emit(state.copyWith(
      allMessages: list,
      filteredMessages: _applySearch(list, state.searchQuery),
      clearSelectedChat:
          state.selectedChat != null && _support(state.selectedChat!),
    ));
    openConversation(0, UserType.adminUser, name);
  }

  void _adoptSupportAdmin(int adminId) {
    if (adminId <= 0) return;
    final zeroKey = _chatKey(0, UserType.adminUser);
    // Look up the actual unassigned entry, not its previous alias.
    final unassigned =
        state.allMessages.where((c) => _key(c) == zeroKey && !c.isClosed);
    if (unassigned.isEmpty) return;
    final newKey = _chatKey(adminId, UserType.adminUser);
    _deletedSupportKeys.remove(newKey);
    final old = unassigned.first;
    final existing = _find(newKey);
    _chatAliases[zeroKey] = newKey;
    if (_historyLoaded.remove(zeroKey)) _historyLoaded.add(newKey);
    final updated = _copyChat(
      old,
      toUser: adminId,
      messages: _mergeMessages(old.messages ?? [], existing?.messages ?? []),
      closed: existing?.closed ?? old.closed,
    );
    _replaceChat(updated, previousKeys: {zeroKey});
  }

  void updateChatStatus(NotificationPayload payload,
      {bool adoptUnassigned = true}) {
    if (isClosed || payload.kind != NotificationKind.chatStatus) return;
    final peer = payload.chatPeer(currentUserId, currentUserType);
    final closed = payload.chatClosed;
    if (peer == null ||
        peer.type != UserType.adminUser ||
        peer.id <= 0 ||
        closed == null ||
        (payload.integer('harageid') ?? 0) > 0 ||
        (payload.integer('orderid') ?? 0) > 0) {
      return;
    }
    if (closed) {
      _deleteSupportConversation(peer.id, includeUnassigned: adoptUnassigned);
      return;
    }
    _deletedSupportKeys.remove(_chatKey(peer.id, peer.type));
    if (adoptUnassigned) {
      _adoptSupportAdmin(peer.id);
    }
    final chat = _find(_chatKey(peer.id, peer.type)) ??
        GetAllMessagesModel(
          touser: peer.id,
          tousertype: peer.type,
          userName: 'الدعم الفني',
          messages: [],
        );
    _replaceChat(_copyChat(chat, closed: closed));
  }

  void _deleteSupportConversation(int adminId,
      {required bool includeUnassigned}) {
    final peerKey = _chatKey(adminId, UserType.adminUser);
    final zeroKey = _chatKey(0, UserType.adminUser);
    final keys = <String>{peerKey};
    for (final alias in _chatAliases.entries) {
      if (alias.value == peerKey) keys.add(alias.key);
    }
    if (includeUnassigned && state.allMessages.any((c) => _key(c) == zeroKey)) {
      keys.add(zeroKey);
    }
    final selected = state.selectedChat;
    final clearSelection = selected != null && keys.contains(_key(selected));
    final cancelSend =
        _sendingChatKey != null && keys.contains(_resolve(_sendingChatKey!));
    for (final chat in state.allMessages.where((c) => keys.contains(_key(c)))) {
      for (final message in [
        ...?chat.messages,
        if (chat.lastMessage != null) chat.lastMessage!
      ]) {
        if (message.id > 0) _deletedSupportMessageIds.add(message.id);
      }
    }
    while (_deletedSupportMessageIds.length > 1000) {
      _deletedSupportMessageIds.remove(_deletedSupportMessageIds.first);
    }
    _deletedSupportKeys.addAll(keys);
    _pendingChats.addAll(keys);
    _historyLoaded.removeWhere((key) => keys.contains(_resolve(key)));
    _historyRequests.removeWhere((key, _) => keys.contains(_resolve(key)));
    _chatAliases.removeWhere(
        (key, value) => keys.contains(key) || keys.contains(value));
    if (cancelSend) {
      _sendToken = null;
      _sendingChatKey = null;
    }
    if (clearSelection) {
      _selectionVersion++;
      ChatEvents.instance.activeChatUserId = null;
      ChatEvents.instance.activeChatUserType = null;
    }
    final list =
        state.allMessages.where((c) => !keys.contains(_key(c))).toList();
    emit(state.copyWith(
        allMessages: list,
        filteredMessages: _applySearch(list, state.searchQuery),
        clearSelectedChat: clearSelection,
        isLoadingOlder: clearSelection ? false : _loadingSelected,
        isSendingMessage: cancelSend ? false : state.isSendingMessage,
        clearErrorMessage: clearSelection));
  }

  /// A tap uses the same typed participants as receipt; status is never a message.
  bool openFromNotification(NotificationPayload payload) {
    if (isClosed || !payload.isFor(currentUserId, currentUserType)) {
      return false;
    }
    // A close notification must never recreate the deleted conversation.
    if (payload.kind == NotificationKind.chatStatus &&
        payload.chatClosed == true) {
      return false;
    }
    final peer = payload.chatPeer(currentUserId, currentUserType);
    if (peer == null) return false;
    if (peer.type == UserType.adminUser &&
        (payload.integer('orderid') ?? 0) > 0) {
      return false;
    }
    if (payload.kind == NotificationKind.chatStatus &&
        _find(_chatKey(peer.id, peer.type)) == null) {
      updateChatStatus(payload, adoptUnassigned: false);
    }
    openConversation(
        peer.id,
        peer.type,
        peer.type == UserType.adminUser
            ? 'الدعم الفني'
            : payload.get('fromusername')?.toString() ?? '');
    return true;
  }

  void clearSelectedChat() {
    if (isClosed) return;
    _selectionVersion++;
    ChatEvents.instance.activeChatUserId = null;
    ChatEvents.instance.activeChatUserType = null;
    final selected = state.selectedChat;
    final list = state.allMessages
        .where((c) =>
            selected == null ||
            !_support(selected) ||
            !selected.isClosed ||
            _key(c) != _key(selected))
        .toList();
    emit(state.copyWith(
        clearSelectedChat: true,
        isLoadingOlder: false,
        allMessages: list,
        filteredMessages: _applySearch(list, state.searchQuery)));
  }

  Future<void> init() => ensureLoaded();
  Future<void> ensureLoaded() async {
    if (isClosed || (_messagesLoaded && _teamLoaded)) return;
    if (_initialLoad != null) return _initialLoad!;
    final session = _session;
    final pending = _loadInitial();
    _initialLoad = pending;
    try {
      await pending;
    } finally {
      if (session == _session) _initialLoad = null;
    }
  }

  Future<void> _loadInitial() async {
    final session = _session;
    if (currentUserId == 0) {
      final user = await AuthLocalStorage.getUser();
      if (isClosed || session != _session) return;
      if (user?.userid != null) {
        _cachedUserId = user!.userid!;
        _cachedUserType = user.type ?? UserType.employeeUser;
      }
    }
    if (currentUserId <= 0) return;
    await Future.wait([
      if (!_messagesLoaded) getAllMessages(),
      if (!_teamLoaded) getWorkTeam(),
    ]);
  }

  Future<void> getAllMessages() async {
    if (isClosed || currentUserId <= 0) return;
    final session = _session, request = ++_messagesRequest;
    final generation = _supportGeneration;
    _pendingChats.clear();
    emit(state.copyWith(isLoadingMessages: true, clearErrorMessage: true));
    try {
      final messages = List<GetAllMessagesModel>.of(await chatRepository
          .getAllMessages(userId: currentUserId, userType: currentUserType));
      if (isClosed || session != _session || request != _messagesRequest) {
        return;
      }
      // An in-flight summary must not resurrect 0 or a ticket already replaced locally.
      if (generation != _supportGeneration) {
        messages.removeWhere(_support);
      }
      messages.removeWhere((chat) =>
          _support(chat) &&
          (_deletedSupportKeys.contains(_key(chat)) ||
              (_chatAliases.containsKey(_key(chat)) &&
                  _pendingChats.contains(_resolve(_key(chat))))));
      for (final local in state.allMessages.reversed) {
        if (!_pendingChats.contains(_key(local)) &&
            !_historyLoaded.contains(_key(local)) &&
            !_selected(local)) {
          continue;
        }
        final index = messages.indexWhere((c) => _key(c) == _key(local));
        final server = index < 0 ? null : messages.removeAt(index);
        final changed = _pendingChats.contains(_key(local));
        final base = server ?? local;
        messages.insert(
            0,
            _copyChat(
              base,
              messages:
                  _mergeMessages(local.messages ?? [], server?.messages ?? []),
              closed: changed ? local.closed : server?.closed ?? local.closed,
              noOldMessages: _historyLoaded.contains(_key(local))
                  ? local.noOldMessages
                  : base.noOldMessages,
              unread: changed || _selected(local)
                  ? local.unViewedMessagesCount
                  : base.unViewedMessagesCount,
            ));
      }
      _pendingChats.clear();
      _messagesLoaded = true;
      final selected = state.selectedChat;
      final matching =
          messages.where((c) => selected != null && _key(c) == _key(selected));
      emit(state.copyWith(
          isLoadingMessages: false,
          allMessages: messages,
          filteredMessages: _applySearch(messages, state.searchQuery),
          selectedChat: matching.isEmpty ? selected : matching.first));
    } catch (e) {
      if (isClosed || session != _session || request != _messagesRequest) {
        return;
      }
      emit(state.copyWith(isLoadingMessages: false, errorMessage: _error(e)));
    }
  }

  Future<void> getWorkTeam() async {
    if (isClosed || currentUserId <= 0) return;
    final session = _session;
    emit(state.copyWith(isLoadingWorkTeam: true, clearErrorMessage: true));
    try {
      final team = await chatRepository.getWorkTeam(
          userId: currentUserId, userType: currentUserType);
      if (isClosed || session != _session) return;
      _teamLoaded = true;
      // This is the support entry point, not a choice of a specific admin.
      final updated = [
        WorkTeamMemberModel(
            userid: 0,
            usertype: UserType.adminUser,
            name: 'الدعم الفني',
            latinname: 'Technical Support',
            jobname: 'إدارة النظام',
            latinjobname: 'System Management'),
        ...team.where((member) => member.usertype != UserType.adminUser)
      ];
      emit(state.copyWith(isLoadingWorkTeam: false, workTeam: updated));
    } catch (e) {
      if (isClosed || session != _session) return;
      emit(state.copyWith(isLoadingWorkTeam: false, errorMessage: _error(e)));
    }
  }

  void selectChat(GetAllMessagesModel chat) {
    if (isClosed) return;
    if (_support(chat) &&
        (chat.isClosed || _deletedSupportKeys.contains(_key(chat)))) {
      return;
    }
    _selectionVersion++;
    final read = _copyChat(chat,
        messages: chat.messages?.map((m) => m.copyWith(viewed: true)).toList(),
        unread: 0);
    ChatEvents.instance.activeChatUserId = read.touser;
    ChatEvents.instance.activeChatUserType = read.tousertype;
    _trackChat(read);
    final list = [
      read,
      ...state.allMessages.where((c) => _key(c) != _key(read))
    ];
    emit(state.copyWith(
        selectedChat: read,
        allMessages: list,
        filteredMessages: _applySearch(list, state.searchQuery),
        isLoadingOlder:
            _historyRequests.keys.any((key) => _resolve(key) == _key(read)),
        clearErrorMessage: true));
    if (read.touser != null && read.tousertype != null) {
      unawaited(markChatViewed(read.touser!, read.tousertype!));
      if (!_historyLoaded.contains(_key(read))) {
        unawaited(getOlderMessages(initialLoad: true));
      }
    }
  }

  void selectTab(int index) {
    if (!isClosed) emit(state.copyWith(selectedTab: index));
  }

  void searchMessages(String query) {
    if (!isClosed) {
      emit(state.copyWith(
          searchQuery: query,
          filteredMessages: _applySearch(state.allMessages, query)));
    }
  }

  List<GetAllMessagesModel> _applySearch(
      List<GetAllMessagesModel> list, String query) {
    final text = query.trim().toLowerCase();
    if (text.isEmpty) return list;
    return list
        .where((c) =>
            (c.userName ?? '').toLowerCase().contains(text) ||
            (c.lastMessage?.message ?? '').toLowerCase().contains(text))
        .toList();
  }

  String _error(Object error) =>
      error.toString().replaceFirst('Exception: ', '');

  bool _belongs(ChatMessageModel message, GetAllMessagesModel chat) {
    if ((message.harageId ?? 0) > 0) return false;
    final fromMe = message.isOutgoing(currentUserId, currentUserType);
    final toMe = message.toUser == currentUserId &&
        message.toUserType == currentUserType;
    if (!fromMe && !toMe) return false;
    final peerId = fromMe ? message.toUser : message.fromUser;
    final peerType = fromMe ? message.toUserType : message.fromUserType;
    if (_support(chat) && (message.orderId ?? 0) > 0) return false;
    return peerType == chat.tousertype &&
        (peerId == chat.touser || (fromMe && _support(chat) && peerId == 0));
  }

  List<ChatMessageModel> _mergeMessages(
      List<ChatMessageModel> current, List<ChatMessageModel> incoming) {
    final result = List<ChatMessageModel>.of(current);
    for (final message in incoming) {
      var index = result.indexWhere((m) =>
          (message.id > 0 && m.id == message.id) ||
          (message.localId != null && m.localId == message.localId));
      if (index < 0 &&
          message.id > 0 &&
          message.isOutgoing(currentUserId, currentUserType)) {
        // Never collapse two server messages just because their text/time matches.
        index = result.indexWhere((m) =>
            m.id < 0 &&
            m.isOutgoing(currentUserId, currentUserType) &&
            m.message == message.message &&
            m.toUserType == message.toUserType &&
            (m.toUser == message.toUser ||
                (m.toUserType == UserType.adminUser && m.toUser == 0)) &&
            (m.orderId ?? 0) == (message.orderId ?? 0) &&
            (m.harageId ?? 0) == (message.harageId ?? 0));
      }
      if (index < 0) {
        result.add(message);
      } else {
        final old = result[index];
        if (old.id > 0 && message.id < 0) continue;
        result[index] = message.copyWith(
            localId: old.localId, viewed: old.viewed || message.viewed);
        if (message.id > 0) {
          final keep = result[index];
          result.removeWhere((m) => !identical(m, keep) && m.id == message.id);
        }
      }
    }
    final positions = {for (var i = 0; i < result.length; i++) result[i]: i};
    result.sort((a, b) {
      final date =
          (a.date ?? DateTime(1970)).compareTo(b.date ?? DateTime(1970));
      return date != 0 ? date : positions[a]!.compareTo(positions[b]!);
    });
    return result;
  }

  Future<void> sendMessage(String text, {int? orderId}) async {
    final trimmed = text.trim(), chat = state.selectedChat;
    if (isClosed ||
        currentUserId <= 0 ||
        trimmed.isEmpty ||
        chat == null ||
        chat.isClosed ||
        state.isSendingMessage) {
      return;
    }
    final session = _session, generation = _supportGeneration;
    final key = _key(chat), localId = _nextLocalId--;
    final sendToken = Object();
    _sendToken = sendToken;
    _sendingChatKey = key;
    final outgoing = ChatMessageModel(
        id: localId,
        localId: localId,
        fromUser: currentUserId,
        fromUserType: currentUserType,
        toUser: chat.touser ?? 0,
        toUserType: chat.tousertype ?? 0,
        message: trimmed,
        date: DateTime.now(),
        viewed: true,
        orderId: orderId);
    _replaceChat(_copyChat(chat,
        messages: _mergeMessages(chat.messages ?? [], [outgoing])));
    emit(state.copyWith(isSendingMessage: true, clearErrorMessage: true));
    try {
      final response = await chatRepository.sendChatMessage(
          message: SendChatMessageModel(
              fromUser: currentUserId,
              fromUserType: currentUserType,
              toUser: outgoing.toUser,
              toUserType: outgoing.toUserType,
              orderId: orderId ?? 0,
              message: trimmed));
      if (isClosed ||
          session != _session ||
          !identical(_sendToken, sendToken)) {
        return;
      }
      final current = _find(key);
      if ((!_support(chat) || generation == _supportGeneration) &&
          current != null) {
        final confirmed = _sentMessage(response, outgoing);
        if (confirmed != null) {
          _replaceChat(_copyChat(current,
              messages: _mergeMessages(current.messages ?? [], [confirmed])));
        }
      }
      _sendToken = null;
      _sendingChatKey = null;
      emit(state.copyWith(isSendingMessage: false));
    } catch (e) {
      if (isClosed ||
          session != _session ||
          !identical(_sendToken, sendToken)) {
        return;
      }
      final current = _find(key);
      if ((!_support(chat) || generation == _supportGeneration) &&
          current != null) {
        // An echo may have confirmed this message before an HTTP failure.
        _replaceChat(_copyChat(current,
            messages: (current.messages ?? [])
                .where((m) => m.localId != localId || m.id > 0)
                .toList()));
      }
      _sendToken = null;
      _sendingChatKey = null;
      emit(state.copyWith(isSendingMessage: false, errorMessage: _error(e)));
    }
  }

  ChatMessageModel? _sentMessage(dynamic raw, ChatMessageModel outgoing) {
    // Only consume a complete response in the existing message schema.
    // A success flag or unrelated ID is not a message.
    final root = NotificationPayload.object(raw);
    for (final data in [
      root,
      NotificationPayload.object(NotificationPayload.value(root, 'data'))
    ]) {
      final fields = NotificationPayload(data);
      if ((fields.integer('id') ?? 0) <= 0 ||
          fields.chatPeer(currentUserId, currentUserType) == null ||
          fields.get('message') == null ||
          DateTime.tryParse('${fields.get('date')}') == null) {
        continue;
      }
      final message = ChatMessageModel.fromJson(data);
      if (message.isOutgoing(currentUserId, currentUserType) &&
          message.message == outgoing.message &&
          message.toUserType == outgoing.toUserType &&
          (message.toUser == outgoing.toUser ||
              (outgoing.toUser == 0 &&
                  outgoing.toUserType == UserType.adminUser)) &&
          (message.orderId ?? 0) == (outgoing.orderId ?? 0) &&
          (message.harageId ?? 0) == (outgoing.harageId ?? 0)) {
        return message.copyWith(localId: outgoing.localId, viewed: true);
      }
    }
    return null;
  }

  Future<void> getOlderMessages({bool initialLoad = false}) async {
    final chat = state.selectedChat;
    if (isClosed ||
        currentUserId <= 0 ||
        chat == null ||
        (!initialLoad && chat.noOldMessages)) {
      return;
    }
    final key = _key(chat), session = _session, generation = _supportGeneration;
    if (_historyRequests.keys.any((k) => _resolve(k) == key)) return;
    final token = Object();
    _historyRequests[key] = token;
    emit(state.copyWith(isLoadingOlder: true, clearErrorMessage: true));
    try {
      final fetched = initialLoad
          ? await chatRepository.getChatMessages(
              fromUserId: currentUserId,
              fromUserType: currentUserType,
              toUserId: chat.touser ?? 0,
              toUserType: chat.tousertype ?? 0)
          : await chatRepository.getOlderMessages(
              fromUser: currentUserId,
              fromUserType: currentUserType,
              toUser: chat.touser ?? 0,
              toUserType: chat.tousertype ?? 0,
              date: chat.messages?.firstOrNull?.date?.toIso8601String() ??
                  DateTime.now()
                      .add(const Duration(days: 1))
                      .toIso8601String());
      if (isClosed ||
          session != _session ||
          !identical(_historyRequests[key], token) ||
          (_support(chat) && generation != _supportGeneration)) {
        return;
      }
      if (_support(chat) && chat.touser == 0) {
        final replies = fetched.where((m) =>
            m.fromUserType == UserType.adminUser &&
            m.fromUser > 0 &&
            m.toUser == currentUserId &&
            m.toUserType == currentUserType &&
            (m.harageId ?? 0) == 0 &&
            (m.orderId ?? 0) == 0);
        if (replies.isNotEmpty) _adoptSupportAdmin(replies.first.fromUser);
      }
      final current = _find(key);
      if (current == null) return;
      if (initialLoad) _historyLoaded.add(_key(current));
      final selected = _selected(current);
      final valid = fetched
          .where((m) => _belongs(m, current))
          .map((m) => selected ? m.copyWith(viewed: true) : m)
          .toList();
      _replaceChat(_copyChat(current,
          messages: _mergeMessages(current.messages ?? [], valid),
          noOldMessages: fetched.length < 10,
          unread: selected ? 0 : null));
    } catch (e) {
      if (isClosed ||
          session != _session ||
          !identical(_historyRequests[key], token)) {
        return;
      }
      emit(state.copyWith(errorMessage: _error(e)));
    } finally {
      if (!isClosed &&
          session == _session &&
          identical(_historyRequests[key], token)) {
        _historyRequests.remove(key);
        emit(state.copyWith(isLoadingOlder: _loadingSelected));
      }
    }
  }

  Future<void> markChatViewed(int toUser, int toUserType) async {
    await chatRepository.makeChatViewed(
        fromUser: currentUserId,
        fromUserType: currentUserType,
        toUser: toUser,
        toUserType: toUserType);
  }

  void onIncomingMessage(ChatMessageModel message) {
    if (isClosed ||
        currentUserId <= 0 ||
        message.id <= 0 ||
        message.fromUser <= 0 ||
        message.fromUserType <= 0 ||
        message.toUserType <= 0 ||
        (message.harageId ?? 0) > 0) {
      return;
    }
    final fromMe = message.isOutgoing(currentUserId, currentUserType);
    final toMe = message.toUser == currentUserId &&
        message.toUserType == currentUserType;
    if (!fromMe && !toMe) return;
    final peerId = fromMe ? message.toUser : message.fromUser;
    final peerType = fromMe ? message.toUserType : message.fromUserType;
    if (peerType == UserType.adminUser && (message.orderId ?? 0) > 0) return;
    if (peerType == UserType.adminUser) {
      if (_deletedSupportMessageIds.contains(message.id)) return;
      if (_deletedSupportKeys.contains(_resolve(_chatKey(peerId, peerType)))) {
        // A new request at 0 may be picked up again by the same admin.
        final freshSupport = state.allMessages.any((chat) =>
            chat.touser == 0 &&
            _support(chat) &&
            !chat.isClosed &&
            !_deletedSupportKeys.contains(_chatKey(0, UserType.adminUser)));
        if (!toMe || !freshSupport) return;
      }
    }
    if (toMe && peerType == UserType.adminUser) _adoptSupportAdmin(peerId);
    var old = _find(_chatKey(peerId, peerType));
    if (old == null && fromMe && peerType == UserType.adminUser) {
      // The backend may already name the recipient in our own echo. Correlate
      // it with the unassigned local copy without assigning on another chat's echo.
      final unassigned = _find(_chatKey(0, UserType.adminUser));
      final matchesLocal = unassigned?.messages?.any((m) =>
              m.isOutgoing(currentUserId, currentUserType) &&
              (m.id == message.id ||
                  (m.id < 0 &&
                      m.message == message.message &&
                      (m.orderId ?? 0) == (message.orderId ?? 0) &&
                      (m.harageId ?? 0) == (message.harageId ?? 0)))) ??
          false;
      if (matchesLocal) old = unassigned;
    }
    final chat = old ??
        GetAllMessagesModel(
            touser: peerId,
            tousertype: peerType,
            userName: peerType == UserType.adminUser
                ? 'الدعم الفني'
                : message.fromUserName,
            messages: []);
    final duplicate = chat.messages?.any((m) => m.id == message.id) ?? false;
    final selected = _selected(chat);
    final incoming =
        message.copyWith(viewed: selected || fromMe || message.viewed);
    _replaceChat(_copyChat(chat,
        messages: _mergeMessages(chat.messages ?? [], [incoming]),
        unread: selected || fromMe
            ? 0
            : chat.unViewedMessagesCount + (duplicate ? 0 : 1)));
    if (selected && !fromMe && !duplicate) {
      unawaited(markChatViewed(chat.touser!, chat.tousertype!));
    }
  }

  void _handleRealtimeChatEvent(ReceiveMessageData event) {
    onIncomingMessage(ChatMessageModel(
        id: int.tryParse(event.id ?? '') ?? 0,
        fromUser: int.tryParse(event.fromUser ?? '') ?? 0,
        toUser: int.tryParse(event.toUser ?? '') ?? 0,
        fromUserType: int.tryParse(event.fromUserType ?? '') ?? 0,
        toUserType: int.tryParse(event.toUserType ?? '') ?? 0,
        message: event.message ?? '',
        date: DateTime.tryParse(event.date ?? ''),
        viewed: NotificationPayload.boolean(event.viewed) ?? false,
        isClosed: NotificationPayload.boolean(event.isClosed) ?? false,
        orderId: int.tryParse(event.orderId ?? ''),
        harageId: int.tryParse(event.harageId ?? ''),
        fromUserName: event.fromUserName));
  }

  void reset() {
    _session++;
    _messagesRequest++;
    _supportGeneration++;
    _selectionVersion++;
    _historyLoaded.clear();
    _historyRequests.clear();
    _pendingChats.clear();
    _chatAliases.clear();
    _deletedSupportKeys.clear();
    _deletedSupportMessageIds.clear();
    _sendToken = null;
    _sendingChatKey = null;
    _initialLoad = null;
    _messagesLoaded = _teamLoaded = false;
    _cachedUserId = 0;
    _cachedUserType = UserType.employeeUser;
    ChatEvents.instance.activeChatUserId = null;
    ChatEvents.instance.activeChatUserType = null;
    if (!isClosed) emit(const EmployeeChatState());
  }

  @override
  Future<void> close() {
    _session++;
    _chatEventsSub?.cancel();
    return super.close();
  }
}
