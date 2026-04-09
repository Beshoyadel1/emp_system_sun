import 'package:dio/dio.dart';
import '../../../../core/api_functions/utility_and_extras/change_coupon_status_model/change_coupon_status_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> changeCouponStatusFunction({
  required ChangeCouponStatusRequest changeCouponStatusRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      changeCouponStatusRequest.toJson(), // params
        ApiLink.changeCouponStatus
    );
    AppSnackBar.showSuccess(AppLanguageKeys.changeCouponStatusSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}