import 'package:dio/dio.dart';
import '../../../../../core/api_functions/general/services/get_services_model/service_setting_model.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';

Future<List<ServiceSettingModel>> getServicesFunction() async {
  try {
    final response = await Network.getData(ApiLink.getServices);

    List data = response.data;

    return data.map((e) => ServiceSettingModel.fromJson(e)).toList();
  } catch (e) {
    throw Exception(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}