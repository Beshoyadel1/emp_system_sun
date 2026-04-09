import 'package:dio/dio.dart';
import 'package:emp_system_sun/core/api_functions/provider_management/get_provider_service_packages_model/provider_service_packages_model.dart';
import '../../../../core/api_functions/provider_management/get_provider_service_packages_model/get_provider_service_packages_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<List<ProviderServicePackagesModel>>
getProviderServicePackagesFunction({
  required GetProviderServicePackagesRequest request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.getProviderServicePackages,
    );

    final data = response.data as List;

    return data
        .map((e) => ProviderServicePackagesModel.fromJson(e))
        .toList();
  } catch (e) {
    throw e;
  }
}