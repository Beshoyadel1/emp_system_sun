import 'package:dio/dio.dart';
import '../../response/get_provider_harage_sales_chart_response/get_provider_harage_data_points_response.dart';
import '../../request/get_provider_harage_sales_chart_request/get_provider_harage_sales_chart_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';

Future<GetProviderHarageDataPointsResponse?>
getProviderHarageSalesChartFunction({
  required GetProviderHarageSalesChartRequest
  getProviderHarageSalesChartRequest,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      getProviderHarageSalesChartRequest.toJson(),
      ApiLink.getProviderHarageSalesChart,
    );

    final responseData = response.data;

    final bool success =
        responseData['success'] ?? false;

    if (!success) {
      throw Exception(
        responseData['message'] ??
            'Something went wrong',
      );
    }

    return GetProviderHarageDataPointsResponse.fromJson(
      responseData,
    );
  } catch (e) {
    if (e is DioException) {
      throw Exception(
        responseOfStatusCode(
          e.response?.statusCode,
        ),
      );
    }

    rethrow;
  }
}