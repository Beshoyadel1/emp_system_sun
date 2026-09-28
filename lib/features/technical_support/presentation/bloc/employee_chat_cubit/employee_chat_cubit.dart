import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:emp_system_sun/features/notifications/data/model/receive_message_notification_model/receive_message_notification_model.dart';
import 'package:emp_system_sun/features/technical_support/data/datasource/employee_chat_repository.dart';
import 'package:emp_system_sun/features/technical_support/data/model/chat_events/chat_events.dart';
import 'package:emp_system_sun/features/technical_support/data/model/employee_chat_model.dart';
import 'employee_chat_state.dart';

class EmployeeChatCubit extends Cubit<EmployeeChatState> {
  final EmployeeChatRepository chatRepository;
  StreamSubscription<ReceiveMessageData>? _chatEventsSub;

  int _cachedUserId = 0;
  int _cachedUserType = UserType.employeeUser;

  EmployeeChatCubit({
    this.chatRepository = const EmployeeChatRepository(),
  }) : super(const EmployeeChatState()) {
    _chatEventsSub = ChatEvents.instance.stream.listen((event) {
      _handleRealtimeChatEvent(event);
    });
  }

  int get currentUserId => _cachedUserId;
  int get currentUserType => _cachedUserType;

  int get totalUnreadCount =>
      state.calculateTotalUnread(currentUserId, currentUserType);

  void clearSelectedChat() {
    if (isClosed) return;
    ChatEvents.instance.activeChatUserId = null;
    ChatEvents.instance.activeChatUserType = null;
    emit(state.copyWith(clearSelectedChat: true));
  }

  Future<void> init() async {
    final user = await AuthLocalStorage.getUser();
    if (user != null && user.userid != null) {
      _cachedUserId = user.userid!;
      _cachedUserType = user.type ?? UserType.employeeUser;
    }

    await Future.wait([
      getAllMessages(),
      getWorkTeam(),
    ]);
  }

  Future<void> getAllMessages() async {
    if (isClosed) return;
    emit(state.copyWith(isLoadingMessages: true, clearErrorMessage: true));

    try {
      if (_cachedUserId == 0) {
        final user = await AuthLocalStorage.getUser();
        if (user != null && user.userid != null) {
          _cachedUserId = user.userid!;
          _cachedUserType = user.type ?? UserType.employeeUser;
        }
      }

      final messages = await chatRepository.getAllMessages(
        userId: currentUserId,
        userType: currentUserType,
      );

      if (isClosed) return;

      final filtered = _applySearch(messages, state.searchQuery);
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
          (updatedSelectedChat.messages == null ||
              updatedSelectedChat.messages!.length <= 1)) {
        getOlderMessages(initialLoad: true);
      }
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        isLoadingMessages: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  Future<void> getWorkTeam() async {
    if (isClosed) return;
    emit(state.copyWith(isLoadingWorkTeam: true, clearErrorMessage: true));

    try {
      if (_cachedUserId == 0) {
        final user = await AuthLocalStorage.getUser();
        if (user != null && user.userid != null) {
          _cachedUserId = user.userid!;
          _cachedUserType = user.type ?? UserType.employeeUser;
        }
      }

      final team = await chatRepository.getWorkTeam(
        userId: currentUserId,
        userType: currentUserType,
      );

      if (isClosed) return;

      final updatedTeam = List<WorkTeamMemberModel>.from(team);
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
      if (isClosed) return;
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

    emit(state.copyWith(
      selectedChat: readChat,
      allMessages: allList,
      filteredMessages: _applySearch(allList, state.searchQuery),
    ));

    if (chat.touser != null && chat.tousertype != null) {
      markChatViewed(chat.touser!, chat.tousertype!);
      if (chat.messages == null || chat.messages!.length <= 1) {
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
    final trimmed = text.trim();
    if (trimmed.isEmpty || state.selectedChat == null || isClosed) return;

    final targetChat = state.selectedChat!;
    final toUser = targetChat.touser ?? 0;
    final toUserType = targetChat.tousertype ?? 0;

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
      if (isClosed) return;
      emit(state.copyWith(isSendingMessage: false));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        isSendingMessage: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  Future<void> getOlderMessages({bool initialLoad = false}) async {
    final chat = state.selectedChat;
    if (chat == null ||
        (chat.noOldMessages && !initialLoad) ||
        state.isLoadingOlder ||
        isClosed) {
      return;
    }

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

      if (isClosed) return;

      final currentChat = (state.selectedChat?.touser == chat.touser &&
              state.selectedChat?.tousertype == chat.tousertype)
          ? state.selectedChat!
          : chat;
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
        currentMsgs.sort((a, b) => (a.date ?? DateTime.now())
            .compareTo(b.date ?? DateTime.now()));
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
        isLoadingOlder: false,
        selectedChat: isStillSelected ? updatedChat : state.selectedChat,
        allMessages: allList,
        filteredMessages: _applySearch(allList, state.searchQuery),
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        isLoadingOlder: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  Future<void> markChatViewed(int toUser, int toUserType) async {
    try {
      await chatRepository.makeChatViewed(
        fromUser: currentUserId,
        fromUserType: currentUserType,
        toUser: toUser,
        toUserType: toUserType,
      );

      if (isClosed) return;

      final allList = state.allMessages.map((chat) {
        if (chat.touser == toUser && chat.tousertype == toUserType) {
          final updatedMsgs = chat.messages?.map((m) {
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

          return GetAllMessagesModel(
            touser: chat.touser,
            tousertype: chat.tousertype,
            userName: chat.userName,
            messages: updatedMsgs,
            noOldMessages: chat.noOldMessages,
            image: chat.image,
            unViewedMessagesCount: 0,
            directLastMessage: chat.directLastMessage,
          );
        }
        return chat;
      }).toList();

      GetAllMessagesModel? updatedSelectedChat = state.selectedChat;
      if (state.selectedChat != null &&
          state.selectedChat!.touser == toUser &&
          state.selectedChat!.tousertype == toUserType) {
        updatedSelectedChat = allList.firstWhere(
          (c) => c.touser == toUser && c.tousertype == toUserType,
          orElse: () => state.selectedChat!,
        );
      }

      emit(state.copyWith(
        allMessages: allList,
        filteredMessages: _applySearch(allList, state.searchQuery),
        selectedChat: updatedSelectedChat,
      ));
    } catch (_) {}
  }

  void onIncomingMessage(ChatMessageModel message) {
    if (isClosed) return;

    final isForSelectedChat = state.selectedChat != null &&
        (state.selectedChat!.touser == message.fromUser &&
            state.selectedChat!.tousertype == message.fromUserType);

    final allList = List<GetAllMessagesModel>.from(state.allMessages);
    final bool isFromMe = message.fromUser == currentUserId &&
        message.fromUserType == currentUserType;

    final chatIndex = allList.indexWhere(
      (c) =>
          c.touser == message.fromUser && c.tousertype == message.fromUserType,
    );

    GetAllMessagesModel targetChat;
    if (chatIndex >= 0) {
      targetChat = allList.removeAt(chatIndex);
      final msgs = List<ChatMessageModel>.from(targetChat.messages ?? [])
        ..add(isForSelectedChat || isFromMe
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
            : message);

      targetChat = GetAllMessagesModel(
        touser: targetChat.touser,
        tousertype: targetChat.tousertype,
        userName: targetChat.userName,
        messages: msgs,
        noOldMessages: targetChat.noOldMessages,
        image: targetChat.image,
        unViewedMessagesCount: (isForSelectedChat || isFromMe)
            ? 0
            : targetChat.unViewedMessagesCount + 1,
        directLastMessage: message,
      );
    } else {
      targetChat = GetAllMessagesModel(
        touser: message.fromUser,
        tousertype: message.fromUserType,
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
      markChatViewed(message.fromUser, message.fromUserType);
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
      date: event.date != null ? DateTime.tryParse(event.date!) : DateTime.now(),
      viewed: event.viewed == 'true' || event.viewed == '1',
      isClosed: event.isClosed == 'true' || event.isClosed == '1',
      orderId: int.tryParse(event.orderId ?? ''),
      harageId: int.tryParse(event.harageId ?? ''),
      fromUserName: event.fromUserName,
    );

    onIncomingMessage(model);
  }

  void reset() {
    if (!isClosed) {
      emit(const EmployeeChatState());
    }
  }

  @override
  Future<void> close() {
    _chatEventsSub?.cancel();
    return super.close();
  }
}
