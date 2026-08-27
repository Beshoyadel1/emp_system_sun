import 'package:dio/dio.dart';
import '../../../../../../../../../features/cars_haraj_page/data/request/get_user_harages_request/get_user_harages_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../../features/cars_haraj_page/data/response/get_user_harages_response/get_user_harages_response.dart';


Future<GetUserHaragesResponse?> getUserHaragesFunction({
  required GetUserHaragesRequest getUserHaragesRequest,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      getUserHaragesRequest.toJson(),
      ApiLink.getUserHarages,
    );

    final responseData = response.data;

    final bool success = responseData['success'] ?? false;

    if (!success) {
      throw Exception(
        responseData['message'] ?? 'Something went wrong',
      );
    }

    return GetUserHaragesResponse.fromJson(
      responseData,
    );
  } catch (e) {
    if (e is DioException) {
      throw Exception(
        responseOfStatusCode(
          e.response?.statusCode,
        ),
      );
    }

    rethrow;
  }
}