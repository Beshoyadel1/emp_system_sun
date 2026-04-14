import '../../../../core/api_functions/chat/get_chat_messages_model/chat_details_model.dart';

abstract class ChatDetailsState {}

class ChatDetailsInitial extends ChatDetailsState {}

class ChatDetailsLoading extends ChatDetailsState {}

class ChatDetailsSuccess extends ChatDetailsState {
  final List<ChatDetailsModel> chats;

  ChatDetailsSuccess(this.chats);
}

class ChatDetailsError extends ChatDetailsState {
  final String message;

  ChatDetailsError(this.message);
}