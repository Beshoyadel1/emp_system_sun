import 'package:dio/dio.dart';
import '../../../../core/api_functions/harage/get_all_harage_model/get_all_harage_response.dart';
import '../../../../core/api_functions/harage/get_all_harage_model/get_all_harage_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<GetAllHarageResponse> getAllHarageFunction({
  required GetAllHarageRequest getAllHarageRequest,
}) async {
  try {
    final response = await Network.getDataWithBodyAndParams(
      {},
      getAllHarageRequest.toJson(),
      ApiLink.getAllHarage,
    );

    final data = GetAllHarageResponse.fromJson(response.data);

    return data;
  } catch (e) {
    throw Exception(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}