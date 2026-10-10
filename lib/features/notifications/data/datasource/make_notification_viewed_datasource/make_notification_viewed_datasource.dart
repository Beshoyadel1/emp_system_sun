import 'package:dio/dio.dart';
import '../../../../../features/notifications/data/request/get_user_new_notification_request/get_user_new_notification_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';

Future<void> makeNotificationViewedFunction({
  required GetUserNewNotificationRequest request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.makeNotificationViewed,
    );
    final body = response.data;
    if ((response.statusCode ?? 500) >= 400 ||
        (body is Map && (body['success'] == false || body['status'] == false))) {
      throw Exception(body is Map ? body['message'] ?? 'Failed to mark notifications viewed' : 'Failed to mark notifications viewed');
    }
  } catch (e) {
    throw Exception(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}
