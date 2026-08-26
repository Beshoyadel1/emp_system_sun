import 'dart:convert';
import 'dart:typed_data';

class ChatHaragModel {
  final int? id;
  final int? fromUser;
  final int? fromUserType;
  final Uint8List? fromUserImage;
  final String? fromUserName;

  final int? toUser;
  final int? toUserType;
  final Uint8List? toUserImage;
  final String? toUserName;

  final String? lastMessage;
  final DateTime? lastMessageDate;
  final int? notViewedCount;
  final int? harageId;

  ChatHaragModel({
    this.id,
    this.fromUser,
    this.fromUserType,
    this.fromUserImage,
    this.fromUserName,
    this.toUser,
    this.toUserType,
    this.toUserImage,
    this.toUserName,
    this.lastMessage,
    this.lastMessageDate,
    this.notViewedCount,
    this.harageId,
  });

  factory ChatHaragModel.fromJson(Map<String, dynamic> json) {
    return ChatHaragModel(
      id: json['id'],
      fromUser: json['fromuser'],
      fromUserType: json['fromusertype'],
      fromUserImage: _decodeImage(json['fromuserimage']),
      fromUserName: json['fromusername'],

      toUser: json['touser'],
      toUserType: json['tousertype'],
      toUserImage: _decodeImage(json['touserimage']),
      toUserName: json['tousername'],

      lastMessage: json['lastmessage'],
      lastMessageDate: json['lastmessagedate'] != null
          ? DateTime.tryParse(json['lastmessagedate'].toString())
          : null,

      notViewedCount: json['notviewedcount'],
      harageId: json['harageid'],
    );
  }

  static Uint8List? _decodeImage(dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return null;
    }

    try {
      return base64Decode(value.toString());
    } catch (_) {
      return null;
    }
  }
}