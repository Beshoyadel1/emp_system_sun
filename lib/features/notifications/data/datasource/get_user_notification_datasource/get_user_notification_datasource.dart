import 'package:dio/dio.dart';
import '../../../../../features/notifications/data/model/get_user_new_notification_model/get_user_new_notification_model.dart';
import '../../../../../features/notifications/data/request/get_user_new_notification_request/get_user_new_notification_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';

Future<GetUserNotificationResponse> getUserNotificationFunction({
  required GetUserNewNotificationRequest request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.getUserNotification,
    );

    final body = response.data;
    if (body is Map && (body['success'] == false || body['status'] == false)) {
      throw Exception(body['message'] ?? 'Failed to load notifications');
    }
    return GetUserNotificationResponse.fromJson(body is List ? {'data': body} : Map<String, dynamic>.from(body));
  } catch (e) {
    throw Exception(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}
