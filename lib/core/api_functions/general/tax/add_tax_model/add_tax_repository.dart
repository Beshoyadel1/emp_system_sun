import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../core/api_functions/general/tax/add_tax_model/add_tax_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/language/language_constant.dart';

Future<void> addTaxFunction({required AddTaxRequest addTaxRequest}) async {
  try {
    String jsonString = json.encode(addTaxRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
        ApiLink.addTax
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.addTaxSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}