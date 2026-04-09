import 'package:dio/dio.dart';
import '../../../../core/api_functions/payments_and_wallet/set_default_card_model/set_default_card_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> setDefaultCardFunction({
  required SetDefaultCardRequest setDefaultCardRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      setDefaultCardRequest.toJson(), // params
        ApiLink.setDefaultCard
    );
    AppSnackBar.showSuccess(AppLanguageKeys.setDefaultCardSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}