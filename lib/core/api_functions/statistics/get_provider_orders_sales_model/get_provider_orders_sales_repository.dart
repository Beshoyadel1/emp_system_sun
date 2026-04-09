import 'package:dio/dio.dart';
import '../../../../core/api_functions/statistics/get_provider_orders_sales_model/get_provider_orders_sales_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getProviderOrdersSalesFunction({
  required GetProviderOrdersSalesRequest getProviderOrdersSalesRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getProviderOrdersSalesRequest.toJson(), // params
      ApiLink.getProviderOrdersSales,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getProviderOrdersSalesSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}
