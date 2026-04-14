import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/api_functions/chat/get_chat_messages_model/chat_details_model.dart';
import '../../../../core/api_functions/chat/get_chat_messages_model/message_item_model.dart';
import '../../../../core/api_functions/chat/send_message_model/send_message_repository.dart';
import '../../../../core/api_functions/chat/send_message_model/send_message_request.dart';
import '../../../../core/api_functions/chat/get_chat_messages_model/get_chat_messages_repository.dart';
import '../../../../core/api_functions/chat/get_chat_messages_model/get_chat_messages_request.dart';
import '../../../../core/api_functions/user/login_model/login_repository.dart';
import 'chat_details_state.dart';

class ChatDetailsCubit extends Cubit<ChatDetailsState> {
  ChatDetailsCubit() : super(ChatDetailsInitial());

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

      final updatedMessages = <MessageItemModel>[
        ...(currentChat!.messages ?? []),
        tempMessage,
      ];

      currentChat = ChatDetailsModel(
        toUser: currentChat!.toUser,
        toUserType: currentChat!.toUserType,
        userName: currentChat!.userName,
        image: currentChat!.image,
        messages: updatedMessages,
      );

      emit(ChatDetailsSuccess([currentChat!]));
      await sendMessageFunction(sendMessageRequest: request);
      await loadChat(
        toUserId: selectedToUserId!,
        toUserType: selectedToUserType!,
      );

    } catch (e) {
      await loadChat(
        toUserId: selectedToUserId!,
        toUserType: selectedToUserType!,
      );

      emit(ChatDetailsError(e.toString()));
    }
  }
  bool isMyMessage(int fromUserId) {
    return myUserId != null && fromUserId == myUserId;
  }
}
