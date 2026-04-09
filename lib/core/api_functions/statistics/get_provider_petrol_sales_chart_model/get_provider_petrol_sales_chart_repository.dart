import 'package:dio/dio.dart';
import '../../../../core/api_functions/statistics/get_provider_petrol_sales_chart_model/get_provider_petrol_sales_chart_response.dart';
import '../../../../core/api_functions/statistics/get_provider_petrol_sales_chart_model/get_provider_petrol_sales_chart_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<GetProviderPetrolSalesChartResponse?>
getProviderPetrolSalesChartFunction({
  required GetProviderPetrolSalesChartRequest
  getProviderPetrolSalesChartRequest,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      getProviderPetrolSalesChartRequest.toJson(),
      ApiLink.getProviderPetrolSalesChart,
    );

    final model =
    GetProviderPetrolSalesChartResponse.fromJson(response.data);

    return model;
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
    return null;
  }
}
