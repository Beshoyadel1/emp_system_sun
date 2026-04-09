import 'package:dio/dio.dart';
import '../../../../core/api_functions/utility_and_extras/get_coupon_by_code_model/get_coupon_by_code_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getCouponByCodeFunction({
  required GetCouponByCodeRequest getCouponByCodeRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getCouponByCodeRequest.toJson(), // params
      ApiLink.getCouponByCode,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getCouponByCodeSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}