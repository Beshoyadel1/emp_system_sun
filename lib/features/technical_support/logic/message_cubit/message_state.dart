import '../../../../core/api_functions/chat/get_user_chats_model/message_model.dart';

abstract class MessageState {}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageSuccess extends MessageState {
  final List<MessageModel> messages;

  MessageSuccess(this.messages);
}

class MessageError extends MessageState {
  final String message;

  MessageError(this.message);
}