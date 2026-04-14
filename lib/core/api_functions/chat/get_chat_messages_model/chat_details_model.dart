import 'dart:convert';
import 'dart:typed_data';
import '../../../../core/api_functions/chat/get_chat_messages_model/message_item_model.dart';

class ChatDetailsModel {
  final int? toUser;
  final int? toUserType;
  final String? userName;
  final Uint8List? image;
  final List<MessageItemModel>? messages;

  ChatDetailsModel({
    this.toUser,
    this.toUserType,
    this.userName,
    this.image,
    this.messages,
  });

  factory ChatDetailsModel.fromJson(Map<String, dynamic> json) {
    return ChatDetailsModel(
      toUser: json['touser'],
      toUserType: json['tousertype'],
      userName: json['userName'] ?? "",
      image: json['image'] != null
          ? base64Decode(json['image'])
          : null,
      messages: json['messages'] != null
          ? List.from(json['messages'])
          .map((e) => MessageItemModel.fromJson(e))
          .toList()
          : [],
    );
  }
}