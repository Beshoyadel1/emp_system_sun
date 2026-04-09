import 'package:dio/dio.dart';
import '../../../../core/api_functions/order/update_order_offer_status_model/update_order_offer_status_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> updateOrderOfferStatusFunction({
  required UpdateOrderOfferStatusRequest updateOrderOfferStatusRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      updateOrderOfferStatusRequest.toJson(), // params
      ApiLink.updateOrderOfferStatus,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.updateOrderOfferStatusSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}