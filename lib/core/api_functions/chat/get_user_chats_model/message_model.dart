import 'dart:convert';
import 'dart:typed_data';
import '../../../../core/api_functions/chat/get_user_chats_model/last_message_model.dart';

class MessageModel {
  final int? userId;
  final int? userType;
  final String? userName;
  final int? unViewedMessagesCount;
  final LastMessageModel? lastMessage;
  final Uint8List? userImage;

  MessageModel({
    this.userId,
    this.userType,
    this.userName,
    this.unViewedMessagesCount,
    this.lastMessage,
    this.userImage,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      userId: json['userId']??0,
      userType: json['userType']??0,
      userName: json['userName'] ?? "",
      unViewedMessagesCount: json['unViewedMessagesCount'] ?? 0,
      lastMessage: json['lastMessage'] != null
          ? LastMessageModel.fromJson(json['lastMessage'])
          : null,
      userImage: json['userImage'] != null
          ? base64Decode(json["userImage"])
          : null,
    );
  }
}