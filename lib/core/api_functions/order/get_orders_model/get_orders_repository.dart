import 'package:dio/dio.dart';
import '../../../../core/api_functions/order/get_orders_model/get_orders_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getOrdersFunction({
  required GetOrdersRequest getOrdersRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getOrdersRequest.toJson(), // params
      ApiLink.getOrders,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getOrdersSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}