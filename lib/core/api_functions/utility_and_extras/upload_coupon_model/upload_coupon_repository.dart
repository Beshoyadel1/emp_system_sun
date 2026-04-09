import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/utility_and_extras/upload_coupon_model/upload_coupon_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> uploadCouponFunction({required UploadCouponRequest uploadCouponRequest}) async {
  try {
    String jsonString = json.encode(uploadCouponRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
        ApiLink.uploadCoupon
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.uploadCouponSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}

