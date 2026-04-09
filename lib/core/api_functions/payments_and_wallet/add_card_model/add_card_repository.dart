import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/payments_and_wallet/add_card_model/add_card_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> addCardFunction({required AddCardRequest addCardRequest}) async {
  try {
    String jsonString = json.encode(addCardRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
        ApiLink.addCard
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.addCardSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}