import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class ReceiveNotificationModel {
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

  ReceiveNotificationModel({
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

  factory ReceiveNotificationModel.fromJson(Map<String, dynamic> json) {
    return ReceiveNotificationModel(
      id: json["ID"] ?? 0,
      title: json["TITLE"] ?? "",
      latinTitle: json["LATINTITLE"] ?? "",
      description: json["DESCRIPTION"] ?? "",
      latinDesc: json["LATINDESC"] ?? "",
      toUserId: json["TOUSERID"] ?? 0,
      toUserType: json["TOUSERTYPE"] ?? 0,
      fromUserId: json["FROMUSERID"] ?? 0,
      fromUserType: json["FROMUSERTYPE"] ?? 0,
      isViewed: json["ISVIEWED"] ?? false,
      date: DateTime.tryParse(json["DATE"] ?? "") ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      "TITLE": title,
      "LATINTITLE": latinTitle,
      "DESCRIPTION": description,
      "LATINDESC": latinDesc,
      "TOUSERID": toUserId,
      "TOUSERTYPE": toUserType,
      "FROMUSERID": fromUserId,
      "FROMUSERTYPE": fromUserType,
      "ISVIEWED": isViewed,
      "DATE": date?.toIso8601String(),
    };
  }

  bool _isEnglish(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'en';
  }

  String getTitle(BuildContext context) {
    return _isEnglish(context) ? (latinTitle ?? "") : (title ?? "");
  }

  String getDescription(BuildContext context) {
    return _isEnglish(context) ? (latinDesc ?? "") : (description ?? "");
  }

  String getFormattedDate(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

    return DateFormat(
      "dd MMM yyyy • hh:mm a",
      locale,
    ).format(date!);
  }
}
