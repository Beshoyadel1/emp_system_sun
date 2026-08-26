import 'package:dio/dio.dart';
import '../../../../../../features/cars_haraj_page/data/request/get_harage_details_request/get_harage_details_request.dart';
import '../../../../../../features/cars_haraj_page/data/response/get_harage_details_response/get_harage_details_response.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';

Future<GetHarageDetailsResponse?>
getHarageDetailsFunction({
  required GetHarageDetailsRequest
  getHarageDetailsRequest,
}) async {
  try {
    final response =
    await Network.postDataWithBodyAndParams(
      {},
      getHarageDetailsRequest.toJson(),
      ApiLink.getHarageDetails,
    );

    final responseData = response.data;

    final bool success =
        responseData['success'] ?? false;

    if (!success) {
      throw Exception(
        responseData['message'] ??
            'Something went wrong',
      );
    }

    return GetHarageDetailsResponse.fromJson(
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