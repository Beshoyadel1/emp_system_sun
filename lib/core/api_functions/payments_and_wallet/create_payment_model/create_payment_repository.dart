import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/payments_and_wallet/create_payment_model/create_payment_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> createPaymentFunction({required CreatePaymentRequest createPaymentRequest}) async {
  try {
    String jsonString = json.encode(createPaymentRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.createPayment,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.createPaymentSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}