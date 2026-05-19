import 'package:dio/dio.dart';
import 'package:emp_system_sun/features/cars_haraj_page/data/response/get_provider_harage_monthly_sales_response/get_provider_harage_monthly_sales_response.dart';
import '../../request/get_provider_harage_monthly_sales_request/get_provider_harage_monthly_sales_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';

Future<GetProviderHarageMonthlySalesResponse?> getProviderHarageMonthlySalesFunction({
  required GetProviderHarageMonthlySalesRequest getProviderHarageMonthlySalesRequest,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      getProviderHarageMonthlySalesRequest.toJson(),
      ApiLink.getProviderHarageMonthlySales,
    );

    final data = GetProviderHarageMonthlySalesResponse.fromJson(response.data);

    // AppSnackBar.showSuccess(
    //   AppLanguageKeys.getProviderHarageMonthlySalesSuccessfully,
    // );

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
