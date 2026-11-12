import '../../../../../../core/theming/auth_local_storage.dart';
import '../../../../../../features/notifications/data/model/new_order_notifications_model/new_order_notifications_model.dart';
import '../../../../../../features/auth_page/data/datasource/login_datasource/login_repository.dart';

class UpdateOrderStatusModelNotification {
  final int? userId;
  final int? userType;
  final UpdateOrderStatusNotificationData? data;

  UpdateOrderStatusModelNotification({
    this.userId,
    this.userType,
    this.data,
  });

  factory UpdateOrderStatusModelNotification.fromJson(
      Map<String, dynamic> json,
      ) {
    return UpdateOrderStatusModelNotification(
      userId: json["userId"],
      userType: json["userType"],
      data: json["data"] == null
          ? null
          : UpdateOrderStatusNotificationData.fromJson(json["data"]),
    );
  }

  Future<bool> canView() async {
    final currentUser = await AuthLocalStorage.getUser();

    if (currentUser == null) {
      return false;
    }

    if (userType != currentUser.type) {
      return false;
    }

    if (userId != null &&
        userId != 0 &&
        userId != currentUser.userid) {
      return false;
    }

    return true;
  }
}

class UpdateOrderStatusNotificationData {
  final String? title;
  final String? body;
  final UpdateOrderStatusData? data;

  UpdateOrderStatusNotificationData({
    this.title,
    this.body,
    this.data,
  });

  factory UpdateOrderStatusNotificationData.fromJson(
      Map<String, dynamic> json,
      ) {
    return UpdateOrderStatusNotificationData(
      title: json["title"],
      body: json["body"],
      data: json["data"] == null
          ? null
          : UpdateOrderStatusData.fromJson(json["data"]),
    );
  }
}

class UpdateOrderStatusData {
  final String? type;
  final String? orderId;
  final String? status;
  final OrderInfo? orderInfo;

  UpdateOrderStatusData({
    this.type,
    this.orderId,
    this.status,
    this.orderInfo,
  });

  factory UpdateOrderStatusData.fromJson(
      Map<String, dynamic> json,
      ) {
    return UpdateOrderStatusData(
      type: json["type"]?.toString(),
      orderId: json["orderId"]?.toString(),
      status: json["status"]?.toString(),
      orderInfo: json["orderInfo"] == null
          ? null
          : OrderInfo.fromJson(json["orderInfo"]),
    );
  }
}
