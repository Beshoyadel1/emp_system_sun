import 'package:dio/dio.dart';
import '../../../../../../features/notifications/data/model/get_user_new_notification_model/get_user_new_notification_model.dart';
import '../../../../../../features/notifications/data/request/get_user_new_notification_request/get_user_new_notification_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';

Future<List<NotificationModel>> getUserNewNotificationFunction({
  required GetUserNewNotificationRequest request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.getUserNewNotification,
    );

    dynamic raw = response.data;
    if (raw is Map && (raw['success'] == false || raw['status'] == false)) {
      throw Exception('Failed to load unread notifications');
    }
    if (raw is Map && raw.containsKey('data')) raw = raw['data'];
    if (raw is Map && raw.containsKey('data')) raw = raw['data'];
    final items = raw is List
        ? raw
        : raw is Map && raw['id'] != null
            ? [raw]
            : [];
    return items
        .whereType<Map>()
        .map((item) =>
            NotificationModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  } catch (e) {
    throw Exception(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}
