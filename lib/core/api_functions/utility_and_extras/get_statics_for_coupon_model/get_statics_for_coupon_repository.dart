import 'package:dio/dio.dart';
import '../../../../core/api_functions/utility_and_extras/get_statics_for_coupon_model/get_statics_for_coupon_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getStaticsForCouponFunction({
  required GetStaticsForCouponRequest getStaticsForCouponRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getStaticsForCouponRequest.toJson(), // params
        ApiLink.getStaticsForCoupon
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getStaticsForCouponSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}