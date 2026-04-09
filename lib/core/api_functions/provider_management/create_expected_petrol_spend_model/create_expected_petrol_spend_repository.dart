import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/provider_management/create_expected_petrol_spend_model/create_expected_petrol_spend_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> createExpectedPetrolSpendFunction({required CreateExpectedPetrolSpendRequest createExpectedPetrolSpendRequest}) async {
  try {
    String jsonString = json.encode(createExpectedPetrolSpendRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.createExpectedPetrolSpend,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.createExpectedPetrolSpendSuccess);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}