import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

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