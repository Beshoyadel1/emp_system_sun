import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/provider_management/update_expected_petrol_spend_model/update_expected_petrol_spend_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> updateExpectedPetrolSpendFunction({required UpdateExpectedPetrolSpendRequest updateExpectedPetrolSpendRequestRequest}) async {
  try {
    String jsonString = json.encode(updateExpectedPetrolSpendRequestRequest.toJson());

    await Network.putDataWithBody(
      jsonString,
      ApiLink.updateExpectedPetrolSpend,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.updateExpectedPetrolSpendSuccess);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}