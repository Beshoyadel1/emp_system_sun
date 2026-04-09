import 'package:dio/dio.dart';
import '../../../../core/api_functions/provider_management/delete_expected_petrol_spend_model/delete_expected_petrol_spend_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> deleteExpectedPetrolSpendFunction({
  required DeleteExpectedPetrolSpendRequest deleteExpectedPetrolSpendRequest,
}) async {
  try {
    await Network.deleteDataWithBodyAndParams(
      {},
      deleteExpectedPetrolSpendRequest.toJson(), // params
      ApiLink.deleteExpectedPetrolSpend,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.deleteExpectedPetrolSpendSuccess);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}