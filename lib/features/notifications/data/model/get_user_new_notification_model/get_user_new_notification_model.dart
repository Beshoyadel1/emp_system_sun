import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import '../notification_payload.dart';

class GetUserNotificationResponse {
  final List<NotificationModel> data;
  final int pageCount;
  final int totalCount;
  final int currentPage;

  GetUserNotificationResponse({
    required this.data,
    required this.pageCount,
    required this.totalCount,
    required this.currentPage,
  });

  factory GetUserNotificationResponse.fromJson(Map<String, dynamic> json) {
    final raw = json["data"] ?? {};
    final body = raw is Map ? raw : json;
    final items = raw is List ? raw : body['data'] as List? ?? [];

    return GetUserNotificationResponse(
      data: items
          .whereType<Map>()
          .map((e) => NotificationModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      pageCount: body["pageCount"] ?? (items.isEmpty ? 0 : 1),
      totalCount: body["totalCount"] ?? items.length,
      currentPage: body["currentPage"] ?? 1,
    );
  }
}

class NotificationModel {
  final int? id;
  final String? title;
  final String? latinTitle;
  final String? description;
  final String? latinDesc;
  final int? toUserId;
  final int? toUserType;
  final int? fromUserId;
  final int? fromUserType;
  final bool? isViewed;
  final DateTime? date;
  final NotificationPayload? payload;

  NotificationModel({
    this.id,
    this.title,
    this.latinTitle,
    this.description,
    this.latinDesc,
    this.toUserId,
    this.toUserType,
    this.fromUserId,
    this.fromUserType,
    this.isViewed,
    this.date,
    this.payload,
  });

  NotificationModel copyWith({
    int? id,
    String? title,
    String? latinTitle,
    String? description,
    String? latinDesc,
    int? toUserId,
    int? toUserType,
    int? fromUserId,
    int? fromUserType,
    bool? isViewed,
    DateTime? date,
    NotificationPayload? payload,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      latinTitle: latinTitle ?? this.latinTitle,
      description: description ?? this.description,
      latinDesc: latinDesc ?? this.latinDesc,
      toUserId: toUserId ?? this.toUserId,
      toUserType: toUserType ?? this.toUserType,
      fromUserId: fromUserId ?? this.fromUserId,
      fromUserType: fromUserType ?? this.fromUserType,
      isViewed: isViewed ?? this.isViewed,
      date: date ?? this.date,
      payload: payload ?? this.payload,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic v) {
      if (v == null) return null;
      if (v is DateTime) return v;
      final str = v.toString().trim();
      if (str.isEmpty) return null;
      final iso = DateTime.tryParse(str);
      if (iso != null) return iso;
      try {
        return DateFormat('MM/dd/yyyy HH:mm:ss').parse(str);
      } catch (_) {
        try {
          return DateFormat('yyyy-MM-dd HH:mm:ss').parse(str);
        } catch (_) {
          return null;
        }
      }
    }

    return NotificationModel(
      id: json["id"],
      title: json["title"],
      latinTitle: json["latintitle"],
      description: json["description"],
      latinDesc: json["latindesc"],
      toUserId: json["touserid"],
      toUserType: json["tousertype"],
      fromUserId: json["fromuserid"],
      fromUserType: json["fromusertype"],
      isViewed: json["isviewed"],
      date: parseDate(json["date"]),
      payload: NotificationPayload.value(json, 'type') == null
          ? null
          : NotificationPayload(json),
    );
  }

  bool _isEnglish(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'en';
  }

  String getTitle(BuildContext context) {
    return _isEnglish(context)
        ? (latinTitle?.isNotEmpty == true ? latinTitle! : (title ?? ""))
        : (title?.isNotEmpty == true ? title! : (latinTitle ?? ""));
  }

  String getDescription(BuildContext context) {
    return _isEnglish(context)
        ? (latinDesc?.isNotEmpty == true ? latinDesc! : (description ?? ""))
        : (description?.isNotEmpty == true ? description! : (latinDesc ?? ""));
  }

  String getFormattedDate(BuildContext context) {
    if (date == null) return "";
    try {
      final locale = Localizations.localeOf(context).languageCode;
      return DateFormat(
        "dd MMM yyyy • hh:mm a",
        locale,
      ).format(date!);
    } catch (_) {
      return date.toString();
    }
  }

  bool get isOrderRelated {
    final text =
        "${title ?? ''} ${latinTitle ?? ''} ${description ?? ''} ${latinDesc ?? ''}"
            .toLowerCase();
    return text.contains("order") ||
        text.contains("طلب") ||
        text.contains("خدمة") ||
        text.contains("service") ||
        text.contains("حالة");
  }

  bool get isChatRelated {
    if (payload?.type.isNotEmpty == true) {
      return payload!.kind == NotificationKind.chat ||
          payload!.kind == NotificationKind.chatStatus;
    }
    final text =
        "${title ?? ''} ${latinTitle ?? ''} ${description ?? ''} ${latinDesc ?? ''}"
            .toLowerCase();
    return text.contains("chat") ||
        text.contains("message") ||
        text.contains("محادثة") ||
        text.contains("رسالة") ||
        text.contains("شات");
  }
}
