import 'package:dio/dio.dart';
import '../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../../../core/api/dio_function/failures.dart';
import '../../../../../../../features/cars_haraj_page/data/model/get_car_details_model/get_car_details_model.dart';
import '../../../../../../../features/cars_haraj_page/data/request/get_car_details_request/get_car_details_request.dart';

Future<GetCarDetailsModel> getCarDetailsFunction({
  required GetCarDetailsRequest request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.getCarDetails,
    );

    final responseData = response.data;

    final bool success = responseData['success'] ?? false;

    if (!success) {
      throw Exception(
        responseData['message'] ?? 'Something went wrong',
      );
    }

    return GetCarDetailsModel.fromJson(
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