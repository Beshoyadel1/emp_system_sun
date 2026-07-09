import 'package:dio/dio.dart';
import '../../../../../features/notifications/data/model/get_user_new_notification_model/get_user_new_notification_model.dart';
import '../../../../../features/notifications/data/request/get_user_new_notification_request/get_user_new_notification_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';

Future<List<NotificationModel>> getUserNotificationFunction({
  required GetUserNewNotificationRequest request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.getUserNotification,
    );

    return (response.data as List)
        .map(
          (e) => NotificationModel.fromJson(e),
    )
        .toList();
  } catch (e) {
    throw Exception(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}