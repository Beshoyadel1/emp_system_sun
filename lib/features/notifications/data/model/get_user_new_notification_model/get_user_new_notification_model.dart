import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

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

  factory GetUserNotificationResponse.fromJson(
      Map<String, dynamic> json) {
    final body = json["data"] ?? {};

    return GetUserNotificationResponse(
      data: (body["data"] as List? ?? [])
          .map((e) => NotificationModel.fromJson(e))
          .toList(),
      pageCount: body["pageCount"] ?? 0,
      totalCount: body["totalCount"] ?? 0,
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
  });

  factory NotificationModel.fromJson(
      Map<String, dynamic> json) {
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
      date:
      json["date"] == null ? null : DateTime.parse(json["date"]),
    );
  }
  bool _isEnglish(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'en';
  }

  String getTitle(BuildContext context) {
    return _isEnglish(context)
        ? (latinTitle ?? "")
        : (title ?? "");
  }

  String getDescription(BuildContext context) {
    return _isEnglish(context)
        ? (latinDesc ?? "")
        : (description ?? "");
  }

  String getFormattedDate(BuildContext context) {
    if (date == null) return "";

    final locale = Localizations.localeOf(context).languageCode;

    return DateFormat(
      "dd MMM yyyy • hh:mm a",
      locale,
    ).format(date!);
  }
}