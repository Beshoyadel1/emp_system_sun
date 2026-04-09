import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../core/api_functions/general/tax/update_tax_model/update_tax_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/language/language_constant.dart';

Future<void> updateTaxFunction({required UpdateTaxRequest updateTaxRequest}) async {
  try {
    String jsonString = json.encode(updateTaxRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.updateTax,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.updateTaxSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}