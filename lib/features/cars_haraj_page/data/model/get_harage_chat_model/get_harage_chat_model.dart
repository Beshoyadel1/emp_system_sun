import 'dart:convert';
import 'dart:typed_data';

class GetHarageChatResponse {
  final bool success;
  final GetHarageChatData? data;

  const GetHarageChatResponse({
    required this.success,
    this.data,
  });

  factory GetHarageChatResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return GetHarageChatResponse(
      success: json['success'] ?? false,
      data: json['data'] != null
          ? GetHarageChatData.fromJson(
        json['data'],
      )
          : null,
    );
  }
}

class GetHarageChatData {
  final List<GetHarageChatContributor> contributors;
  final List<GetHarageChatMessage> messages;

  const GetHarageChatData({
    this.contributors = const [],
    this.messages = const [],
  });

  factory GetHarageChatData.fromJson(
      Map<String, dynamic> json,
      ) {
    return GetHarageChatData(
      contributors: (json['contributors'] as List?)
          ?.map(
            (e) => GetHarageChatContributor.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList() ??
          [],
      messages: (json['messages'] as List?)
          ?.map(
            (e) => GetHarageChatMessage.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList() ??
          [],
    );
  }
}

class GetHarageChatContributor {
  final int? userId;
  final int? userType;
  final String? name;
  final Uint8List? image;

  const GetHarageChatContributor({
    this.userId,
    this.userType,
    this.name,
    this.image,
  });

  factory GetHarageChatContributor.fromJson(
      Map<String, dynamic> json,
      ) {
    return GetHarageChatContributor(
      userId: json['userid'],
      userType: json['usertype'],
      name: json['name'],
      image: json['image'] != null &&
          json['image'].toString().isNotEmpty
          ? base64Decode(
        json['image'].toString(),
      )
          : null,
    );
  }
}

class GetHarageChatMessage {
  final int? id;
  final int? fromUser;
  final int? toUser;
  final int? fromUserType;
  final int? toUserType;
  final String? message;
  final DateTime? date;
  final bool? viewed;
  final bool? isClosed;
  final int? harageId;
  final int? orderId;

  const GetHarageChatMessage({
    this.id,
    this.fromUser,
    this.toUser,
    this.fromUserType,
    this.toUserType,
    this.message,
    this.date,
    this.viewed,
    this.isClosed,
    this.harageId,
    this.orderId,
  });

  factory GetHarageChatMessage.fromJson(
      Map<String, dynamic> json,
      ) {
    return GetHarageChatMessage(
      id: json['id'],
      fromUser: json['fromuser'],
      toUser: json['touser'],
      fromUserType: json['fromusertype'],
      toUserType: json['tousertype'],
      message: json['message'],
      date: json['date'] != null
          ? DateTime.tryParse(
        json['date'].toString(),
      )
          : null,
      viewed: json['viewed'],
      isClosed: json['isclosed'],
      harageId: json['harageid'],
      orderId: json['orderid'],
    );
  }
}