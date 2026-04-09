import 'package:dio/dio.dart';
import '../../../../core/api_functions/order/cancel_order_model/cancel_order_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> cancelOrderFunction({
  required CancelOrderRequest cancelOrderRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      cancelOrderRequest.toJson(), // params
        ApiLink.cancelOrder
    );
    AppSnackBar.showSuccess(AppLanguageKeys.cancelOrderSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}