import 'package:dio/dio.dart';
import 'package:emp_system_sun/core/api_functions/rates/get_provider_details_rates_model/get_provider_details_rates_response.dart';
import '../../../../core/api_functions/rates/get_provider_details_rates_model/get_provider_details_rates_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<ProviderDetailsRatesResponse> getProviderDetailsRatesFunction({
  required GetProviderDetailsRatesRequest request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.getProviderDetailsRates,
    );

    return ProviderDetailsRatesResponse.fromJson(response.data);
  } on DioException catch (e) {
    throw responseOfStatusCode(e.response?.statusCode);
  }
}