import 'package:dio/dio.dart';
import '../../../../core/api_functions/statistics/get_provider_orders_sales_model/get_provider_orders_sales_model.dart';
import '../../../../core/api_functions/statistics/get_provider_orders_sales_model/get_provider_orders_sales_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<GetProviderOrdersSalesModel?> getProviderOrdersSalesFunction({
  required GetProviderOrdersSalesRequest request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.getProviderOrdersSales,
    );

    return GetProviderOrdersSalesModel.fromJson(response.data);

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
    return null;
  }
}