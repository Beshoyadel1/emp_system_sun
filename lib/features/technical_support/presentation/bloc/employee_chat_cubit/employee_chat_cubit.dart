import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:emp_system_sun/features/notifications/data/model/receive_message_notification_model/receive_message_notification_model.dart';
import 'package:emp_system_sun/features/technical_support/data/datasource/employee_chat_repository.dart';
import 'package:emp_system_sun/features/technical_support/data/model/chat_events/chat_events.dart';
import 'package:emp_system_sun/features/technical_support/data/model/employee_chat_model.dart';
import 'employee_chat_state.dart';
import 'package:emp_system_sun/features/notifications/data/model/notification_payload.dart';

class EmployeeChatCubit extends Cubit<EmployeeChatState> {
  final EmployeeChatRepository chatRepository;
  StreamSubscription<ReceiveMessageData>? _chatEventsSub;
  StreamSubscription<void>? _resumeSub;
  final Set<String> _historyLoaded = {}, _historyLoading = {};
  Future<void>? _resumeSync;
  Future<void>? _initialLoad;
  bool _messagesLoaded = false, _teamLoaded = false;

  int _cachedUserId = 0;
  int _session = 0, _messagesRequest = 0;
  final Set<String> _pendingChats = {};
  String _chatKey(int? id, int? type) => '$id:$type';
  void _trackChat(int? id, int? type) {
    if (state.isLoadingMessages) _pendingChats.add(_chatKey(id, type));
  }

  int _cachedUserType = UserType.employeeUser;

  EmployeeChatCubit({
    this.chatRepository = const EmployeeChatRepository(),
  }) : super(const EmployeeChatState()) {
    _chatEventsSub = ChatEvents.instance.stream.listen((event) {
      _handleRealtimeChatEvent(event);
    });
    _resumeSub = ChatEvents.instance.syncRequests.listen((_) {
      unawaited(syncAfterResume());
    });
  }

  int get currentUserId => _cachedUserId;
  int get currentUserType => _cachedUserType;

  void configureUser(int userId, int userType) {
    if (_cachedUserId != userId || _cachedUserType != userType) reset();
    _cachedUserId = userId;
    _cachedUserType = userType;
  }

  void openConversation(int userId, int userType, String name) {
    final matching = state.allMessages
        .where((c) => c.touser == userId && c.tousertype == userType);
    selectChat(matching.isNotEmpty
        ? matching.first
        : GetAllMessagesModel(
            touser: userId,
            tousertype: userType,
            userName: name,
            messages: [],
            noOldMessages: false,
          ));
  }

  void updateChatStatus(NotificationPayload payload) {
    if (isClosed) return;
    final closed = payload.get('isclosed');
    if (closed == null) return;
    final isClosedChat = closed == true ||
        closed.toString().toLowerCase() == 'true' ||
        closed.toString() == '1';
    final otherId = payload.integer('fromuser');
    final otherType = payload.integer('fromusertype');
    _trackChat(otherId, otherType);
    final list = state.allMessages.map((chat) {
      if (chat.touser != otherId || chat.tousertype != otherType) return chat;
      ChatMessageModel patch(ChatMessageModel m) => ChatMessageModel(
            id: m.id,
            fromUser: m.fromUser,
            toUser: m.toUser,
            fromUserType: m.fromUserType,
            toUserType: m.toUserType,
            message: m.message,
            date: m.date,
            viewed: m.viewed,
            isClosed: isClosedChat,
            orderId: m.orderId,
            harageId: m.harageId,
            fromUserName: m.fromUserName,
          );
      return GetAllMessagesModel(
          touser: chat.touser,
          tousertype: chat.tousertype,
          userName: chat.userName,
          closed: isClosedChat,
          image: chat.image,
          noOldMessages: chat.noOldMessages,
          unViewedMessagesCount: chat.unViewedMessagesCount,
          messages: chat.messages?.map(patch).toList(),
          directLastMessage:
              chat.lastMessage == null ? null : patch(chat.lastMessage!));
    }).toList();
    final selected = state.selectedChat;
    final matches = list.where((c) =>
        c.touser == selected?.touser && c.tousertype == selected?.tousertype);
    emit(state.copyWith(
        allMessages: list,
        filteredMessages: _applySearch(list, state.searchQuery),
        selectedChat: matches.isEmpty ? selected : matches.first));
  }

  int get totalUnreadCount =>
      state.calculateTotalUnread(currentUserId, currentUserType);

  void clearSelectedChat() {
    if (isClosed) return;
    ChatEvents.instance.activeChatUserId = null;
    ChatEvents.instance.activeChatUserType = null;
    emit(state.copyWith(clearSelectedChat: true, isLoadingOlder: false));
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
    final user = await AuthLocalStorage.getUser();
    if (isClosed || session != _session) return;
    if (user != null && user.userid != null) {
      _cachedUserId = user.userid!;
      _cachedUserType = user.type ?? UserType.employeeUser;
    }

    await Future.wait([
      if (!_messagesLoaded) getAllMessages(),
      if (!_teamLoaded) getWorkTeam(),
    ]);
  }

  Future<void> getAllMessages() async {
    if (isClosed) return;
    final session = _session;
    final request = ++_messagesRequest;
    _pendingChats.clear();
    emit(state.copyWith(isLoadingMessages: true, clearErrorMessage: true));

    try {
      if (_cachedUserId == 0) {
        final user = await AuthLocalStorage.getUser();
        if (isClosed || session != _session || request != _messagesRequest) {
          return;
        }
        if (user != null && user.userid != null) {
          _cachedUserId = user.userid!;
          _cachedUserType = user.type ?? UserType.employeeUser;
        }
      }

      if (isClosed || session != _session || request != _messagesRequest) {
        return;
      }
      final messages = await chatRepository.getAllMessages(
        userId: currentUserId,
        userType: currentUserType,
      );

      if (isClosed || session != _session || request != _messagesRequest) {
        return;
      }

      // Conversation summaries must not discard already loaded history.
      final changed = state.allMessages
          .where((c) =>
              _pendingChats.contains(_chatKey(c.touser, c.tousertype)) ||
              _historyLoaded.contains(_chatKey(c.touser, c.tousertype)))
          .toList();
      for (final local in changed.reversed) {
        final index = messages.indexWhere((c) =>
            c.touser == local.touser && c.tousertype == local.tousertype);
        final server = index < 0 ? null : messages.removeAt(index);
        final history = <ChatMessageModel>[...?server?.messages];
        for (final msg in local.messages ?? <ChatMessageModel>[]) {
          final existing =
              history.indexWhere((m) => msg.id > 0 && m.id == msg.id);
          if (existing < 0) {
            history.add(msg);
          } else {
            history[existing] = msg;
          }
        }
        history.sort((a, b) =>
            (a.date ?? DateTime(1970)).compareTo(b.date ?? DateTime(1970)));
        messages.insert(
            0,
            GetAllMessagesModel(
              touser: local.touser,
              tousertype: local.tousertype,
              userName: local.userName?.isNotEmpty == true
                  ? local.userName
                  : server?.userName,
              image: local.image ?? server?.image,
              messages: history,
              closed: _pendingChats
                      .contains(_chatKey(local.touser, local.tousertype))
                  ? local.closed
                  : server?.closed ?? local.closed,
              noOldMessages: _historyLoaded
                      .contains(_chatKey(local.touser, local.tousertype))
                  ? local.noOldMessages
                  : server?.noOldMessages ?? local.noOldMessages,
              unViewedMessagesCount: _pendingChats
                      .contains(_chatKey(local.touser, local.tousertype))
                  ? local.unViewedMessagesCount
                  : server?.unViewedMessagesCount ??
                      local.unViewedMessagesCount,
              directLastMessage: _pendingChats
                      .contains(_chatKey(local.touser, local.tousertype))
                  ? local.lastMessage
                  : server?.lastMessage ?? local.lastMessage,
            ));
      }
      _pendingChats.clear();

      final filtered = _applySearch(messages, state.searchQuery);
      _messagesLoaded = true;
      GetAllMessagesModel? updatedSelectedChat;
      if (state.selectedChat != null) {
        updatedSelectedChat = messages.firstWhere(
          (c) =>
              c.touser == state.selectedChat!.touser &&
              c.tousertype == state.selectedChat!.tousertype,
          orElse: () => state.selectedChat!,
        );
      }

      emit(state.copyWith(
        isLoadingMessages: false,
        allMessages: messages,
        filteredMessages: filtered,
        selectedChat: updatedSelectedChat,
      ));

      if (updatedSelectedChat != null &&
          !_historyLoaded.contains(_chatKey(
              updatedSelectedChat.touser, updatedSelectedChat.tousertype))) {
        getOlderMessages(initialLoad: true);
      }
    } catch (e) {
      if (isClosed || session != _session || request != _messagesRequest) {
        return;
      }
      emit(state.copyWith(
        isLoadingMessages: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  Future<void> getWorkTeam() async {
    final session = _session;
    if (isClosed || session != _session) return;
    emit(state.copyWith(isLoadingWorkTeam: true, clearErrorMessage: true));

    try {
      if (_cachedUserId == 0) {
        final user = await AuthLocalStorage.getUser();
        if (isClosed || session != _session) return;
        if (user != null && user.userid != null) {
          _cachedUserId = user.userid!;
          _cachedUserType = user.type ?? UserType.employeeUser;
        }
      }

      final team = await chatRepository.getWorkTeam(
        userId: currentUserId,
        userType: currentUserType,
      );

      if (isClosed || session != _session) return;

      final updatedTeam = List<WorkTeamMemberModel>.from(team);
      _teamLoaded = true;
      final hasAdmin = updatedTeam.any((m) => m.usertype == UserType.adminUser);
      if (!hasAdmin) {
        updatedTeam.insert(
          0,
          WorkTeamMemberModel(
            userid: 1,
            usertype: UserType.adminUser,
            name: 'إدارة النظام',
            latinname: 'System Management',
            jobname: 'الدعم الفني',
            latinjobname: 'Technical Support',
          ),
        );
      }

      emit(state.copyWith(
        isLoadingWorkTeam: false,
        workTeam: updatedTeam,
      ));
    } catch (e) {
      if (isClosed || session != _session) return;
      emit(state.copyWith(
        isLoadingWorkTeam: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  void selectChat(GetAllMessagesModel chat) {
    if (isClosed) return;

    ChatEvents.instance.activeChatUserId = chat.touser;
    ChatEvents.instance.activeChatUserType = chat.tousertype;

    final updatedMessages = chat.messages?.map((m) {
      return ChatMessageModel(
        id: m.id,
        fromUser: m.fromUser,
        toUser: m.toUser,
        fromUserType: m.fromUserType,
        toUserType: m.toUserType,
        message: m.message,
        date: m.date,
        viewed: true,
        isClosed: m.isClosed,
        orderId: m.orderId,
        harageId: m.harageId,
        fromUserName: m.fromUserName,
      );
    }).toList();

    final readChat = GetAllMessagesModel(
      closed: chat.closed,
      touser: chat.touser,
      tousertype: chat.tousertype,
      userName: chat.userName,
      messages: updatedMessages,
      noOldMessages: chat.noOldMessages,
      image: chat.image,
      unViewedMessagesCount: 0,
      directLastMessage: chat.directLastMessage,
    );

    final allList = state.allMessages.map((c) {
      if (c.touser == chat.touser && c.tousertype == chat.tousertype) {
        return readChat;
      }
      return c;
    }).toList();

    if (!allList.any((c) =>
        c.touser == readChat.touser && c.tousertype == readChat.tousertype)) {
      allList.insert(0, readChat);
    }
    _trackChat(readChat.touser, readChat.tousertype);

    emit(state.copyWith(
      selectedChat: readChat,
      isLoadingOlder:
          _historyLoading.contains(_chatKey(chat.touser, chat.tousertype)),
      allMessages: allList,
      filteredMessages: _applySearch(allList, state.searchQuery),
    ));

    if (chat.touser != null && chat.tousertype != null) {
      markChatViewed(chat.touser!, chat.tousertype!);
      if (!_historyLoaded.contains(_chatKey(chat.touser, chat.tousertype))) {
        getOlderMessages(initialLoad: true);
      }
    }
  }

  void selectTab(int index) {
    if (isClosed) return;
    emit(state.copyWith(selectedTab: index));
  }

  void searchMessages(String query) {
    if (isClosed) return;
    final filtered = _applySearch(state.allMessages, query);
    emit(state.copyWith(
      searchQuery: query,
      filteredMessages: filtered,
    ));
  }

  List<GetAllMessagesModel> _applySearch(
      List<GetAllMessagesModel> list, String query) {
    if (query.trim().isEmpty) return list;
    final lower = query.toLowerCase().trim();
    return list.where((item) {
      final name = item.userName?.toLowerCase() ?? '';
      final lastMsg = item.lastMessage?.message.toLowerCase() ?? '';
      return name.contains(lower) || lastMsg.contains(lower);
    }).toList();
  }

  Future<void> sendMessage(String text, {int? orderId}) async {
    final session = _session;
    final trimmed = text.trim();
    if (trimmed.isEmpty ||
        state.selectedChat == null ||
        isClosed ||
        state.selectedChat!.isClosed) {
      return;
    }

    final targetChat = state.selectedChat!;
    final toUser = targetChat.touser ?? 0;
    final toUserType = targetChat.tousertype ?? 0;
    _trackChat(toUser, toUserType);

    final outgoingMessage = ChatMessageModel(
      id: 0,
      fromUser: currentUserId,
      fromUserType: currentUserType,
      toUser: toUser,
      toUserType: toUserType,
      message: trimmed,
      date: DateTime.now(),
      viewed: true,
      orderId: orderId,
    );

    // Optimistically update local message list
    final updatedMessages =
        List<ChatMessageModel>.from(targetChat.messages ?? [])
          ..add(outgoingMessage);

    final updatedChat = GetAllMessagesModel(
      touser: targetChat.touser,
      tousertype: targetChat.tousertype,
      userName: targetChat.userName,
      messages: updatedMessages,
      noOldMessages: targetChat.noOldMessages,
      closed: targetChat.closed,
      image: targetChat.image,
    );

    final allList = List<GetAllMessagesModel>.from(state.allMessages);
    final index = allList.indexWhere(
      (c) => c.touser == toUser && c.tousertype == toUserType,
    );

    if (index >= 0) {
      allList.removeAt(index);
      allList.insert(0, updatedChat);
    } else {
      allList.insert(0, updatedChat);
    }

    emit(state.copyWith(
      isSendingMessage: true,
      selectedChat: updatedChat,
      allMessages: allList,
      filteredMessages: _applySearch(allList, state.searchQuery),
    ));

    final sendModel = SendChatMessageModel(
      fromUser: currentUserId,
      fromUserType: currentUserType,
      toUser: toUser,
      toUserType: toUserType,
      orderId: orderId ?? 0,
      message: trimmed,
    );

    try {
      await chatRepository.sendChatMessage(message: sendModel);
      if (isClosed || session != _session) return;
      emit(state.copyWith(isSendingMessage: false));
    } catch (e) {
      if (isClosed || session != _session) return;
      emit(state.copyWith(
        isSendingMessage: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  Future<void> getOlderMessages({bool initialLoad = false}) async {
    final session = _session;
    final chat = state.selectedChat;
    if (chat == null || (chat.noOldMessages && !initialLoad) || isClosed) {
      return;
    }
    final key = _chatKey(chat.touser, chat.tousertype);
    if (!_historyLoading.add(key)) return;

    final oldestDate =
        (initialLoad || chat.messages == null || chat.messages!.isEmpty)
            ? DateTime.now().add(const Duration(days: 1)).toIso8601String()
            : (chat.messages!.first.date?.toIso8601String() ??
                DateTime.now().add(const Duration(days: 1)).toIso8601String());

    emit(state.copyWith(isLoadingOlder: true, clearErrorMessage: true));

    try {
      List<ChatMessageModel> fetched;
      if (initialLoad) {
        fetched = await chatRepository.getChatMessages(
          fromUserId: currentUserId,
          fromUserType: currentUserType,
          toUserId: chat.touser ?? 0,
          toUserType: chat.tousertype ?? 0,
        );
      } else {
        fetched = await chatRepository.getOlderMessages(
          fromUser: currentUserId,
          fromUserType: currentUserType,
          toUser: chat.touser ?? 0,
          toUserType: chat.tousertype ?? 0,
          date: oldestDate,
        );
      }

      if (isClosed || session != _session) return;

      if (initialLoad) _historyLoaded.add(key);
      final cached = state.allMessages
          .where((c) => _chatKey(c.touser, c.tousertype) == key);
      final currentChat = (state.selectedChat?.touser == chat.touser &&
              state.selectedChat?.tousertype == chat.tousertype)
          ? state.selectedChat!
          : cached.isEmpty
              ? chat
              : cached.first;
      final currentMsgs =
          List<ChatMessageModel>.from(currentChat.messages ?? []);
      bool noMore = false;
      if (fetched.isEmpty || fetched.length < 10) {
        noMore = true;
      }

      final isStillSelected =
          state.selectedChat?.touser == currentChat.touser &&
              state.selectedChat?.tousertype == currentChat.tousertype;

      if (initialLoad) {
        for (final msg in fetched) {
          final idx = currentMsgs.indexWhere((m) =>
              (msg.id != 0 && m.id == msg.id) ||
              (m.message == msg.message && m.date == msg.date));
          if (idx < 0) {
            currentMsgs.add(isStillSelected
                ? ChatMessageModel(
                    id: msg.id,
                    fromUser: msg.fromUser,
                    toUser: msg.toUser,
                    fromUserType: msg.fromUserType,
                    toUserType: msg.toUserType,
                    message: msg.message,
                    date: msg.date,
                    viewed: true,
                    isClosed: msg.isClosed,
                    orderId: msg.orderId,
                    harageId: msg.harageId,
                    fromUserName: msg.fromUserName,
                  )
                : msg);
          }
        }
        currentMsgs.sort((a, b) =>
            (a.date ?? DateTime.now()).compareTo(b.date ?? DateTime.now()));
      } else {
        for (final msg in fetched.reversed) {
          final alreadyExists = currentMsgs.any((m) =>
              (msg.id != 0 && m.id == msg.id) ||
              (m.message == msg.message && m.date == msg.date));
          if (!alreadyExists) {
            final effectiveMsg = isStillSelected
                ? ChatMessageModel(
                    id: msg.id,
                    fromUser: msg.fromUser,
                    toUser: msg.toUser,
                    fromUserType: msg.fromUserType,
                    toUserType: msg.toUserType,
                    message: msg.message,
                    date: msg.date,
                    viewed: true,
                    isClosed: msg.isClosed,
                    orderId: msg.orderId,
                    harageId: msg.harageId,
                    fromUserName: msg.fromUserName,
                  )
                : msg;
            currentMsgs.insert(0, effectiveMsg);
          }
        }
      }

      final updatedChat = GetAllMessagesModel(
        touser: currentChat.touser,
        tousertype: currentChat.tousertype,
        userName: currentChat.userName,
        messages: currentMsgs,
        noOldMessages: noMore,
        closed: currentChat.closed,
        image: currentChat.image,
        unViewedMessagesCount:
            isStillSelected ? 0 : currentChat.unViewedMessagesCount,
        directLastMessage: currentChat.directLastMessage,
      );

      final allList = state.allMessages.map((c) {
        if (c.touser == currentChat.touser &&
            c.tousertype == currentChat.tousertype) {
          return updatedChat;
        }
        return c;
      }).toList();

      emit(state.copyWith(
        isLoadingOlder: !isStillSelected &&
            _historyLoading.contains(_chatKey(
                state.selectedChat?.touser, state.selectedChat?.tousertype)),
        selectedChat: isStillSelected ? updatedChat : state.selectedChat,
        allMessages: allList,
        filteredMessages: _applySearch(allList, state.searchQuery),
      ));
    } catch (e) {
      if (isClosed || session != _session) return;
      emit(state.copyWith(
        isLoadingOlder: key !=
                _chatKey(state.selectedChat?.touser,
                    state.selectedChat?.tousertype) &&
            _historyLoading.contains(_chatKey(
                state.selectedChat?.touser, state.selectedChat?.tousertype)),
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    } finally {
      if (session == _session) _historyLoading.remove(key);
    }
  }

  /// Recover messages missed while the OS/browser suspended FCM delivery.
  Future<void> syncAfterResume() async {
    if (isClosed || currentUserId <= 0) return;
    if (_resumeSync != null) return _resumeSync!;
    final session = _session;
    final work =
        Future.wait([getAllMessages(), getOlderMessages(initialLoad: true)]);
    _resumeSync = work.then((_) {});
    try {
      await _resumeSync;
    } finally {
      if (session == _session) _resumeSync = null;
    }
  }

  Future<void> markChatViewed(int toUser, int toUserType) async {
    // Selection and receipt already update local read flags. A late response
    // must not mark messages that arrived after leaving this conversation.
    await chatRepository.makeChatViewed(
      fromUser: currentUserId,
      fromUserType: currentUserType,
      toUser: toUser,
      toUserType: toUserType,
    );
  }

  void onIncomingMessage(ChatMessageModel message) {
    if (isClosed) return;
    final fromMe = message.fromUser == currentUserId &&
        message.fromUserType == currentUserType;
    final toMe = message.toUser == currentUserId &&
        message.toUserType == currentUserType;
    if ((!fromMe && !toMe) || (message.harageId ?? 0) > 0) return;
    final otherId = fromMe ? message.toUser : message.fromUser;
    final otherType = fromMe ? message.toUserType : message.fromUserType;
    _trackChat(otherId, otherType);

    final isForSelectedChat = state.selectedChat != null &&
        (state.selectedChat!.touser == otherId &&
            state.selectedChat!.tousertype == otherType);

    final allList = List<GetAllMessagesModel>.from(state.allMessages);
    final bool isFromMe = message.fromUser == currentUserId &&
        message.fromUserType == currentUserType;

    final chatIndex = allList.indexWhere(
      (c) => c.touser == otherId && c.tousertype == otherType,
    );

    GetAllMessagesModel targetChat;
    if (chatIndex >= 0) {
      targetChat = allList.removeAt(chatIndex);
      if (message.id > 0 &&
          (targetChat.messages?.any((m) => m.id == message.id) ?? false)) {
        return;
      }
      final msgs = List<ChatMessageModel>.from(targetChat.messages ?? []);
      final incoming = isForSelectedChat || isFromMe
          ? ChatMessageModel(
              id: message.id,
              fromUser: message.fromUser,
              toUser: message.toUser,
              fromUserType: message.fromUserType,
              toUserType: message.toUserType,
              message: message.message,
              date: message.date,
              viewed: true,
              isClosed: message.isClosed,
              orderId: message.orderId,
              harageId: message.harageId,
              fromUserName: message.fromUserName,
            )
          : message;
      final optimistic = msgs.indexWhere((m) =>
          m.id == 0 &&
          isFromMe &&
          m.fromUser == message.fromUser &&
          m.toUser == message.toUser &&
          m.fromUserType == message.fromUserType &&
          m.toUserType == message.toUserType &&
          m.message == message.message &&
          m.date != null &&
          message.date != null &&
          m.date!.difference(message.date!).inSeconds.abs() <= 30);
      if (optimistic < 0) {
        msgs.add(incoming);
      } else {
        msgs[optimistic] = incoming;
      }

      targetChat = GetAllMessagesModel(
        touser: targetChat.touser,
        tousertype: targetChat.tousertype,
        userName: targetChat.userName,
        messages: msgs,
        noOldMessages: targetChat.noOldMessages,
        closed: targetChat.closed,
        image: targetChat.image,
        unViewedMessagesCount: (isForSelectedChat || isFromMe)
            ? 0
            : targetChat.unViewedMessagesCount + 1,
        directLastMessage: message,
      );
    } else {
      targetChat = GetAllMessagesModel(
        touser: otherId,
        tousertype: otherType,
        userName: message.fromUserName ?? '',
        messages: [message],
        noOldMessages: true,
        unViewedMessagesCount: (isForSelectedChat || isFromMe) ? 0 : 1,
        directLastMessage: message,
      );
    }

    allList.insert(0, targetChat);

    GetAllMessagesModel? updatedSelectedChat = state.selectedChat;
    if (isForSelectedChat) {
      updatedSelectedChat = targetChat;
      markChatViewed(otherId, otherType);
    }

    emit(state.copyWith(
      allMessages: allList,
      filteredMessages: _applySearch(allList, state.searchQuery),
      selectedChat: updatedSelectedChat,
    ));
  }

  void _handleRealtimeChatEvent(ReceiveMessageData event) {
    final fromId = int.tryParse(event.fromUser ?? '') ?? 0;
    final fromType = int.tryParse(event.fromUserType ?? '') ?? 0;
    final toId = int.tryParse(event.toUser ?? '') ?? 0;
    final toType = int.tryParse(event.toUserType ?? '') ?? 0;

    final model = ChatMessageModel(
      id: int.tryParse(event.id ?? '') ?? 0,
      fromUser: fromId,
      toUser: toId,
      fromUserType: fromType,
      toUserType: toType,
      message: event.message ?? '',
      date:
          event.date != null ? DateTime.tryParse(event.date!) : DateTime.now(),
      viewed: event.viewed == 'true' || event.viewed == '1',
      isClosed: event.isClosed == 'true' || event.isClosed == '1',
      orderId: int.tryParse(event.orderId ?? ''),
      harageId: int.tryParse(event.harageId ?? ''),
      fromUserName: event.fromUserName,
    );

    onIncomingMessage(model);
  }

  void reset() {
    _session++;
    _messagesRequest++;
    _pendingChats.clear();
    _historyLoaded.clear();
    _historyLoading.clear();
    _resumeSync = null;
    _initialLoad = null;
    _messagesLoaded = _teamLoaded = false;
    _cachedUserId = 0;
    _cachedUserType = UserType.employeeUser;
    ChatEvents.instance.activeChatUserId = null;
    ChatEvents.instance.activeChatUserType = null;
    if (!isClosed) {
      emit(const EmployeeChatState());
    }
  }

  @override
  Future<void> close() {
    _session++;
    _chatEventsSub?.cancel();
    _resumeSub?.cancel();
    return super.close();
  }
}
