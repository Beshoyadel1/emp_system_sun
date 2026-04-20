import 'package:dio/dio.dart';
import '../../../../core/api_functions/statistics/get_provider_harage_sales_chart_model/get_provider_harage_data_points_response.dart';
import '../../../../core/api_functions/statistics/get_provider_harage_sales_chart_model/get_provider_harage_sales_chart_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<GetProviderHarageDataPointsResponse?> getProviderHarageSalesChartFunction({
  required GetProviderHarageSalesChartRequest getProviderHarageSalesChartRequest,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      getProviderHarageSalesChartRequest.toJson(),
        ApiLink.getProviderHarageSalesChart
    );
    final data = GetProviderHarageDataPointsResponse.fromJson(response.data);
   // AppSnackBar.showSuccess(AppLanguageKeys.getProviderHarageSalesChartSuccessfully);
    return data;
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
    return null;
  }
}
