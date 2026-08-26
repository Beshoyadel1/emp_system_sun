import 'package:dio/dio.dart';
import '../../model/get_car_brand_models_model/car_brand_data_model.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';

Future<List<CarBrandDataModel>> getCarBrandFunction() async {
  try {
    final response = await Network.getData(ApiLink.getCarBrand);

    final List data = response.data['data'] ?? [];

    return data
        .map((e) => CarBrandDataModel.fromJson(e as Map<String, dynamic>))
        .toList();
  } catch (e) {
    throw e is DioException
        ? responseOfStatusCode(e.response?.statusCode)
        : e.toString();
  }
}
