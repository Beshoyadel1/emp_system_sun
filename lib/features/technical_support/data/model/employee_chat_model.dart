import 'dart:convert';
import 'dart:typed_data';

/// Represents an active or historical conversation item with another entity.
class GetAllMessagesModel {
  int? touser;
  int? tousertype;
  String? userName;
  List<ChatMessageModel>? messages;
  bool noOldMessages;
  Uint8List? image;
  int unViewedMessagesCount;
  ChatMessageModel? directLastMessage;

  GetAllMessagesModel({
    this.touser,
    this.tousertype,
    this.userName,
    this.messages,
    this.noOldMessages = false,
    this.image,
    this.unViewedMessagesCount = 0,
    this.directLastMessage,
  });

  factory GetAllMessagesModel.fromJson(Map<String, dynamic> json) {
    final rawImage = json['userImage'] ??
        json['userimage'] ??
        json['USERIMAGE'] ??
        json['image'] ??
        json['IMAGE'] ??
        json['Image'];
    Uint8List? decodedImage;
    if (rawImage is String && rawImage.isNotEmpty) {
      try {
        decodedImage = base64Decode(rawImage);
      } catch (_) {}
    } else if (rawImage is List) {
      decodedImage = Uint8List.fromList(rawImage.cast<int>());
    } else if (rawImage is Uint8List) {
      decodedImage = rawImage;
    }

    ChatMessageModel? directLastMsg;
    if (json['lastMessage'] is Map) {
      try {
        directLastMsg = ChatMessageModel.fromJson(
            Map<String, dynamic>.from(json['lastMessage']));
      } catch (_) {}
    }

    List<ChatMessageModel>? messagesList;
    final rawMessages =
        json['messages'] ?? json['Messages'] ?? json['MESSAGES'];
    if (rawMessages is List) {
      messagesList = rawMessages
          .whereType<Map>()
          .map((v) => ChatMessageModel.fromJson(Map<String, dynamic>.from(v)))
          .toList();
    } else if (directLastMsg != null) {
      messagesList = [directLastMsg];
    }

    final toUserVal = json['userId'] ??
        json['userid'] ??
        json['USERID'] ??
        json['touser'] ??
        json['toUser'] ??
        json['TOUSER'];

    final toUserTypeVal = json['userType'] ??
        json['usertype'] ??
        json['USERTYPE'] ??
        json['tousertype'] ??
        json['toUserType'] ??
        json['TOUSERTYPE'];

    final unviewedCount = json['unViewedMessagesCount'] ??
        json['unviewedmessagescount'] ??
        json['unViewedCount'] ??
        0;

    return GetAllMessagesModel(
      touser: toUserVal is num ? toUserVal.toInt() : int.tryParse('$toUserVal'),
      tousertype: toUserTypeVal is num
          ? toUserTypeVal.toInt()
          : int.tryParse('$toUserTypeVal'),
      userName: json['userName'] ??
          json['username'] ??
          json['USERNAME'] ??
          json['name'] ??
          json['NAME'],
      messages: messagesList ?? [],
      noOldMessages: json['noOldMessages'] ?? json['NoOldMessages'] ?? false,
      image: decodedImage,
      unViewedMessagesCount: unviewedCount is num
          ? unviewedCount.toInt()
          : (int.tryParse('$unviewedCount') ?? 0),
      directLastMessage: directLastMsg,
    );
  }

  int unreadCount(int currentUserId, int currentUserType) {
    if (messages != null && messages!.isNotEmpty) {
      return messages!
          .where((m) =>
              !m.viewed &&
              (m.fromUser != currentUserId ||
                  m.fromUserType != currentUserType))
          .length;
    }
    return unViewedMessagesCount;
  }

  ChatMessageModel? get lastMessage {
    if (messages != null && messages!.isNotEmpty) {
      return messages!.last;
    }
    return directLastMessage;
  }
}

/// Represents an individual chat message entity.
class ChatMessageModel {
  final int id;
  final int fromUser;
  final int toUser;
  final int fromUserType;
  final int toUserType;
  final String message;
  final DateTime? date;
  final bool viewed;
  final bool isClosed;
  final int? orderId;
  final int? harageId;
  final String? fromUserName;

  ChatMessageModel({
    required this.id,
    required this.fromUser,
    required this.toUser,
    required this.fromUserType,
    required this.toUserType,
    required this.message,
    this.date,
    this.viewed = false,
    this.isClosed = false,
    this.orderId,
    this.harageId,
    this.fromUserName,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    DateTime? parsedDate;
    var rawDate = json['date'] ?? json['DATE'] ?? json['Date'];
    if (rawDate is String && rawDate.isNotEmpty) {
      parsedDate = DateTime.tryParse(rawDate);
    } else if (rawDate is DateTime) {
      parsedDate = rawDate;
    }
    parsedDate ??= DateTime.now();

    int parseNum(dynamic val) {
      if (val is num) return val.toInt();
      if (val is String) return int.tryParse(val) ?? 0;
      return 0;
    }

    final rawFromUser = json['fromuser'] ??
        json['FROMUSER'] ??
        json['fromUser'] ??
        json['fromUserId'] ??
        json['from_user_id'] ??
        json['senderId'] ??
        json['sender_id'] ??
        json['userId'] ??
        json['userid'] ??
        0;

    final rawToUser = json['touser'] ??
        json['TOUSER'] ??
        json['toUser'] ??
        json['toUserId'] ??
        json['to_user_id'] ??
        json['recipientId'] ??
        0;

    final rawFromUserType = json['fromusertype'] ??
        json['FROMUSERTYPE'] ??
        json['fromUserType'] ??
        json['from_user_type'] ??
        json['senderType'] ??
        json['sender_type'] ??
        json['usertype'] ??
        json['userType'] ??
        0;

    final rawToUserType = json['tousertype'] ??
        json['TOUSERTYPE'] ??
        json['toUserType'] ??
        json['to_user_type'] ??
        json['recipientType'] ??
        0;

    final rawMessage = json['message'] ??
        json['MESSAGE'] ??
        json['Message'] ??
        json['body'] ??
        json['BODY'] ??
        json['Body'] ??
        json['text'] ??
        json['TEXT'] ??
        json['content'] ??
        json['description'] ??
        json['latindesc'] ??
        '';

    final rawOrderId = json['orderid'] ?? json['ORDERID'] ?? json['orderId'];
    final rawHarageId =
        json['harageid'] ?? json['HARAGEID'] ?? json['harageId'];

    return ChatMessageModel(
      id: parseNum(json['id'] ?? json['ID'] ?? 0),
      fromUser: parseNum(rawFromUser),
      toUser: parseNum(rawToUser),
      fromUserType: parseNum(rawFromUserType),
      toUserType: parseNum(rawToUserType),
      message: rawMessage.toString(),
      date: parsedDate,
      viewed: json['viewed'] == true ||
          json['VIEWED'] == true ||
          json['viewed'] == 1 ||
          json['isviewed'] == true ||
          json['isViewed'] == true,
      isClosed: json['isclosed'] == true ||
          json['ISCLOSED'] == true ||
          json['isclosed'] == 1,
      orderId: rawOrderId != null ? parseNum(rawOrderId) : null,
      harageId: rawHarageId != null ? parseNum(rawHarageId) : null,
      fromUserName: json['fromusername'] ??
          json['FROMUSERNAME'] ??
          json['fromUserName'] ??
          json['userName'] ??
          json['username'] ??
          json['sender'] ??
          json['senderName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromuser': fromUser,
      'touser': toUser,
      'fromusertype': fromUserType,
      'tousertype': toUserType,
      'message': message,
      'date': date?.toIso8601String(),
      'viewed': viewed,
      'isclosed': isClosed,
      'orderid': orderId,
      'harageid': harageId,
      'fromusername': fromUserName,
    };
  }

  bool isOutgoing(int myUserId, int myUserType) {
    return fromUser == myUserId && fromUserType == myUserType;
  }
}

/// Payload sent to the backend when sending a chat message.
class SendChatMessageModel {
  final int fromUser;
  final int fromUserType;
  final int? toUser;
  final int? toUserType;
  final int orderId;
  final String message;

  SendChatMessageModel({
    required this.fromUser,
    required this.fromUserType,
    this.toUser,
    this.toUserType,
    required this.orderId,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    final nowIso = DateTime.now().toIso8601String();
    return {
      'ID': 0,
      'id': 0,
      'FROMUSER': fromUser,
      'fromuser': fromUser,
      'FROMUSERTYPE': fromUserType,
      'fromusertype': fromUserType,
      'TOUSER': (toUser != null && toUser! > 0) ? toUser : 0,
      'touser': (toUser != null && toUser! > 0) ? toUser : 0,
      'TOUSERTYPE': (toUserType != null && toUserType! > 0) ? toUserType : 0,
      'tousertype': (toUserType != null && toUserType! > 0) ? toUserType : 0,
      'MESSAGE': message,
      'message': message,
      'ORDERID': orderId,
      'orderid': orderId,
      'HARAGEID': 0,
      'harageid': 0,
      'VIEWED': false,
      'viewed': false,
      'ISCLOSED': false,
      'isclosed': false,
      'DATE': nowIso,
      'date': nowIso,
    };
  }
}

/// Team member representation for the Work Team panel (employees, supervisor/provider, and system admin).
class WorkTeamMemberModel {
  final int? userid;
  final int? usertype;
  final String? name;
  final String? latinname;
  final String? jobname;
  final String? latinjobname;
  final Uint8List? image;

  WorkTeamMemberModel({
    this.userid,
    this.usertype,
    this.name,
    this.latinname,
    this.jobname,
    this.latinjobname,
    this.image,
  });

  factory WorkTeamMemberModel.fromJson(Map<String, dynamic> json) {
    final rawImage = json['image'] ?? json['IMAGE'] ?? json['userImage'];
    Uint8List? decodedImage;
    if (rawImage is String && rawImage.isNotEmpty) {
      try {
        decodedImage = base64Decode(rawImage);
      } catch (_) {}
    } else if (rawImage is List) {
      decodedImage = Uint8List.fromList(rawImage.cast<int>());
    } else if (rawImage is Uint8List) {
      decodedImage = rawImage;
    }

    final idVal = json['userid'] ?? json['USERID'] ?? json['userId'] ?? json['id'];
    final typeVal = json['usertype'] ?? json['USERTYPE'] ?? json['userType'] ?? json['type'];

    return WorkTeamMemberModel(
      userid: idVal is num ? idVal.toInt() : int.tryParse('$idVal'),
      usertype: typeVal is num ? typeVal.toInt() : int.tryParse('$typeVal'),
      name: json['name'] ?? json['NAME'] ?? json['username'],
      latinname: json['latinname'] ?? json['LATINNAME'] ?? json['name'],
      jobname: json['jobname'] ?? json['JOBNAME'],
      latinjobname: json['latinjobname'] ?? json['LATINJOBNAME'] ?? json['jobname'],
      image: decodedImage,
    );
  }

  String getLocalizedName(String languageCode) {
    if (languageCode == 'ar') {
      return (name?.isNotEmpty == true) ? name! : (latinname ?? '');
    }
    return (latinname?.isNotEmpty == true) ? latinname! : (name ?? '');
  }

  String getLocalizedJobName(String languageCode) {
    if (languageCode == 'ar') {
      return (jobname?.isNotEmpty == true) ? jobname! : (latinjobname ?? '');
    }
    return (latinjobname?.isNotEmpty == true) ? latinjobname! : (jobname ?? '');
  }
}
