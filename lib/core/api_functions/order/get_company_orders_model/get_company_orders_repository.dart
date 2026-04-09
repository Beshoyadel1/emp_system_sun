import 'package:dio/dio.dart';
import '../../../../core/api_functions/order/get_company_orders_model/get_company_orders_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getCompanyOrdersFunction({
  required GetCompanyOrdersRequest getCompanyOrdersRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getCompanyOrdersRequest.toJson(), // params
      ApiLink.getCompanyOrders,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getCompanyOrdersSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}