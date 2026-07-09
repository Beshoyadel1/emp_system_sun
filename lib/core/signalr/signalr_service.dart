import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:signalr_core/signalr_core.dart';
import '../../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../../features/auth_page/data/datasource/login_datasource/login_repository.dart';
import '../../../../../../main.dart';

class SignalRService {
  SignalRService._();

  static final SignalRService instance = SignalRService._();

  HubConnection? _hubConnection;

  HubConnection? get connection => _hubConnection;

  bool get isConnected =>
      _hubConnection?.state == HubConnectionState.connected;

  Future<void> connect({
    required String hubUrl,
  }) async {
    if (isConnected) {
      print("✅ SignalR Already Connected");
      return;
    }

    await disconnect();

    try {
      _hubConnection = HubConnectionBuilder()
          .withAutomaticReconnect([
        10000,
        15000,
        20000,
        30000,
        60000,
        180000,
      ])
          .withUrl(
        hubUrl,
        HttpConnectionOptions(
          transport: HttpTransportType.longPolling,
          logging: (level, message) {
           // print("SIGNALR => $message");
          },
        ),
      )
          .build();


      /// ================= Connection Events =================
      _hubConnection!.onclose((error) async {
        print("SignalR Closed => $error");

        await Future.delayed(const Duration(seconds: 5));

        if (!isConnected) {
          await connect(hubUrl: hubUrl);
        }
      });

      _hubConnection!.onreconnected((connectionId) {
        print("🟢 SignalR Reconnected");
        print("ConnectionId => $connectionId");
      });

      /// ================= Notifications =================

      _hubConnection!.on("ReceiveNotification", (arguments) async {
        if (arguments == null || arguments.isEmpty) return;

        final currentUser = await AuthLocalStorage.getUser();
        if (currentUser == null) return;

        final root = Map<String, dynamic>.from(arguments.first);

        final int? userId = root["userId"];
        final int? userType = root["userType"];

        // يجب أن يكون نوع المستخدم مطابقًا
        if (userType != currentUser.type) {
          return;
        }

        // السماح إذا كان:
        // - إشعار للمستخدم الحالي
        // - أو إشعار عام (userId = 0)
        // - أو إشعار عام (userId = null)
        if (userId != null &&
            userId != 0 &&
            userId != currentUser.userid) {
          return;
        }

        final notification =
        Map<String, dynamic>.from(root["data"]);

        final data =
        Map<String, dynamic>.from(notification["data"]);

        final notificationJson = jsonDecode(
          data["notification"] as String,
        ) as Map<String, dynamic>;

        final model = NotificationModel.fromJson(notificationJson);

        AppSnackBar.showNotification(
          title: model.getTitle(scaffoldKey.currentContext!),
          description: model.getDescription(scaffoldKey.currentContext!),
        );
      });

      _hubConnection!.on("ReceiveMessage", (arguments) {
        print("========== RAW ==========");
        print(arguments);
        print("=========================");
        if (arguments == null || arguments.isEmpty) return;

        final root = Map<String, dynamic>.from(arguments.first);

        if (root["Data"] == null) {
          print("No Data received");
          return;
        }

        final notification = Map<String, dynamic>.from(root["Data"] as Map);

        print("UserId => ${root["UserId"]}");
        print("UserType => ${root["UserType"]}");
        print("Title => ${notification["title"]}");
        print("Body => ${notification["body"]}");

        final data =
        Map<String, dynamic>.from(notification["data"]);

        final notificationModel =
        NotificationModel.fromJson(data["notification"]);

        print(notificationModel.title);
        print(notificationModel.description);
      });

      _hubConnection!.on("NewOrder", (arguments) {
      });

      _hubConnection!.on("UpdateOrderStatus", (arguments) {
      });
      _hubConnection!.on("NewServiceRequest", (arguments) {
      });
      _hubConnection!.on("NewServiceOffer", (arguments) {
      });

      _hubConnection!.on("TransferCarOwnership", (arguments) {
      });
      _hubConnection!.on("OpenCloseChat", (arguments) {
      });

      await _hubConnection!.start();

    } catch (e, s) {

      rethrow;
    }
  }

  Future<void> disconnect() async {
    try {
      if (_hubConnection != null) {
        await _hubConnection!.stop();
      }
    } catch (_) {}

    _hubConnection = null;
  }

}

class NotificationModel {
  final int id;
  final String title;
  final String latinTitle;
  final String description;
  final String latinDesc;
  final int toUserId;
  final int toUserType;
  final int fromUserId;
  final int fromUserType;
  final bool isViewed;
  final DateTime date;

  NotificationModel({
    required this.id,
    required this.title,
    required this.latinTitle,
    required this.description,
    required this.latinDesc,
    required this.toUserId,
    required this.toUserType,
    required this.fromUserId,
    required this.fromUserType,
    required this.isViewed,
    required this.date,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
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
      "DATE": date.toIso8601String(),
    };
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
    final locale = Localizations.localeOf(context).languageCode;

    return DateFormat(
      "dd MMM yyyy • hh:mm a",
      locale,
    ).format(date);
  }
}