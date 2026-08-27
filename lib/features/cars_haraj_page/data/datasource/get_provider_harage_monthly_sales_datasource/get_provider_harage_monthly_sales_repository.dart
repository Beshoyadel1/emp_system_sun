import 'package:dio/dio.dart';
import '../../../../../../../../../features/cars_haraj_page/data/response/get_provider_harage_monthly_sales_response/get_provider_harage_monthly_sales_response.dart';
import '../../request/get_provider_harage_monthly_sales_request/get_provider_harage_monthly_sales_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';

Future<GetProviderHarageMonthlySalesResponse?>
getProviderHarageMonthlySalesFunction({
  required GetProviderHarageMonthlySalesRequest
  getProviderHarageMonthlySalesRequest,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      getProviderHarageMonthlySalesRequest.toJson(),
      ApiLink.getProviderHarageMonthlySales,
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

    return GetProviderHarageMonthlySalesResponse.fromJson(
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