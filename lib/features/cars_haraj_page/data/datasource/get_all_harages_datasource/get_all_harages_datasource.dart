import 'package:dio/dio.dart';
import '../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../../../core/api/dio_function/failures.dart';
import '../../../../../../../features/cars_haraj_page/data/request/get_all_harages_request/get_all_harages_request.dart';
import '../../../../../../../features/cars_haraj_page/data/response/get_all_harage_response/get_all_harage_response.dart';

Future<GetAllHarageResponse> getAllHaragesFunction({
  required GetAllHaragesRequest request,
}) async {
  try {
    final response = await Network.getData(
      ApiLink.getAllHarages,
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

    return GetAllHarageResponse.fromJson(
      responseData['data'],
    );
  } on DioException catch (e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      throw Exception(
        data['message'] ??
            responseOfStatusCode(
              e.response?.statusCode,
            ),
      );
    }

    throw Exception(
      responseOfStatusCode(
        e.response?.statusCode,
      ),
    );
  } catch (e) {
    throw Exception(
      e.toString(),
    );
  }
}