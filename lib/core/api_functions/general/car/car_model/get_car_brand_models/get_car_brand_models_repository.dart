import 'package:dio/dio.dart';
import '../../../../../../core/api_functions/general/car/car_model/get_car_brand_models/car_model_data_model.dart';
import '../../../../../../core/api_functions/general/car/car_model/get_car_brand_models/get_car_brand_models_request.dart';
import '../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../../core/api/dio_function/failures.dart';


Future<List<CarModelDataModel>> getCarBrandModelsFunction({
  required GetCarBrandModelsRequest request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.getCarBrandModels,
    );

    final List data = response.data;

    return data.map((e) => CarModelDataModel.fromJson(e)).toList();
  } catch (e) {
    throw e is DioException
        ? responseOfStatusCode(e.response?.statusCode)
        : e.toString();
  }
}

