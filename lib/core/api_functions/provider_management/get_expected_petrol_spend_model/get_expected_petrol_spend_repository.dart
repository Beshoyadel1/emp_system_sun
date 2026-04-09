import 'package:dio/dio.dart';
import '../../../../core/api_functions/provider_management/get_expected_petrol_spend_model/get_expected_petrol_spend_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getExpectedPetrolSpendFunction({
  required GetExpectedPetrolSpendRequest getExpectedPetrolSpendRequestRequest,
}) async {
  try {
    await Network.getDataWithBodyAndParams(
      {},
      getExpectedPetrolSpendRequestRequest.toJson(), // params
      ApiLink.getExpectedPetrolSpend,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getExpectedPetrolSpendSuccess);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}