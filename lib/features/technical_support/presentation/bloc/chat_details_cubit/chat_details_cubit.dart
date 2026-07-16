import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/notifications/data/model/receive_message_notification_model/receive_message_notification_model.dart';
import '../../../../../features/technical_support/data/model/chat_events/chat_events.dart';
import '../../../../../core/theming/auth_local_storage.dart';
import '../../../../../features/technical_support/data/model/get_chat_messages_model/chat_details_model.dart';
import '../../../../../features/technical_support/data/datasource/get_chat_messages_datasource/get_chat_messages_repository.dart';
import '../../../../../features/technical_support/data/request/get_chat_messages_request/get_chat_messages_request.dart';
import '../../../../../features/technical_support/data/datasource/send_message_datasource/send_message_repository.dart';
import '../../../../../features/technical_support/data/model/get_chat_messages_model/message_item_model.dart';
import '../../../../../features/technical_support/data/request/send_message_request/send_message_request.dart';
import 'chat_details_state.dart';

class ChatDetailsCubit extends Cubit<ChatDetailsState> {
  late final StreamSubscription _subscription;

  ChatDetailsCubit() : super(ChatDetailsInitial()) {

    _subscription = ChatEvents.instance.stream.listen((message) {

      receiveMessage(message);

    });

  }
  void _appendMessage(MessageItemModel message) {
    if (currentChat == null) return;

    final exists = (currentChat!.messages ?? [])
        .any((e) => e.id == message.id);

    if (exists) return;

    currentChat = ChatDetailsModel(
      toUser: currentChat!.toUser,
      toUserType: currentChat!.toUserType,
      userName: currentChat!.userName,
      image: currentChat!.image,
      messages: [
        ...(currentChat!.messages ?? []),
        message,
      ],
    );

    emit(ChatDetailsSuccess([currentChat!]));
  }
  void receiveMessage(ReceiveMessageData data) {
    if (currentChat == null) return;

    final fromUser = int.parse(data.fromUser!);
    final toUser = int.parse(data.toUser!);

    if (!((fromUser == selectedToUserId && toUser == myUserId) ||
        (fromUser == myUserId && toUser == selectedToUserId))) {
      return;
    }

    final message = MessageItemModel(
      id: int.parse(data.id ?? "0"),
      fromUser: int.parse(data.fromUser!),
      toUser: int.parse(data.toUser!),
      message: data.message ?? "",
      date: DateFormat("MM/dd/yyyy HH:mm:ss").parse(data.date!),
      viewed: data.viewed == "true",
    );

    _appendMessage(message);
  }

  int? selectedToUserId;
  int? selectedToUserType;
  int? myUserId;

  ChatDetailsModel? currentChat;

  Future<void> loadChat({
    required int toUserId,
    required int toUserType,
  }) async {
    selectedToUserId = toUserId;
    selectedToUserType = toUserType;

    emit(ChatDetailsLoading());

    try {
      final user = await AuthLocalStorage.getUser();
      myUserId = user!.userid!;

      final chats = await getChatMessagesFunction(
        request: GetChatMessagesRequest(
          fromUserId: user.userid!,
          fromUserType: user.type!,
          toUserId: toUserId,
          toUserType: toUserType,
        ),
      );
      currentChat = chats.isNotEmpty ? chats.first : null;

      emit(ChatDetailsSuccess(chats));
    } catch (e) {
      emit(ChatDetailsError(e.toString()));
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    if (selectedToUserId == null || selectedToUserType == null) return;
    if (currentChat == null) return;

    try {
      final user = await AuthLocalStorage.getUser();

      final request = SendMessageRequest(
        fromuser: user!.userid!,
        fromusertype: user.type!,
        touser: selectedToUserId,
        tousertype: selectedToUserType,
        message: text,
        date: DateTime.now().toIso8601String(),
      );

      final tempMessage = MessageItemModel(
        id: DateTime.now().millisecondsSinceEpoch,
        fromUser: user.userid!,
        toUser: selectedToUserId!,
        message: text,
        date: DateTime.now(),
        viewed: false,
      );

      _appendMessage(tempMessage);
      await sendMessageFunction(sendMessageRequest: request);


    } catch (e) {
      emit(ChatDetailsError(e.toString()));
    }
  }

  bool isMyMessage(int fromUserId) {
    return myUserId != null && fromUserId == myUserId;
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}