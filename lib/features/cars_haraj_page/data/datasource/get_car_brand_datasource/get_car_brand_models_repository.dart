import 'package:dio/dio.dart';
import '../../../../../../../../../features/cars_haraj_page/data/model/get_car_brand_models/car_model_data_model.dart';
import '../../../../../../../../../features/cars_haraj_page/data/request/get_car_brand_request/get_car_brand_models_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';


Future<List<CarModelDataModel>>
getCarBrandModelsFunction({
  required GetCarBrandModelsRequest request,
}) async {

  try {

    final response =
    await Network.postDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.getCarBrandModels,
    );

    final List data =
        response.data['data'] ?? [];

    return data
        .map((e) =>
        CarModelDataModel.fromJson(
            e as Map<String, dynamic>))
        .toList();

  } catch (e) {

    throw e is DioException
        ? responseOfStatusCode(
        e.response?.statusCode)
        : e.toString();
  }
}