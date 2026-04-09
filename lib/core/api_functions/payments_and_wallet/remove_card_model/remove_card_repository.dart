import 'package:dio/dio.dart';
import '../../../../core/api_functions/payments_and_wallet/remove_card_model/remove_card_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> removeCardFunction({
  required RemoveCardRequest removeCardRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      removeCardRequest.toJson(), // params
      ApiLink.removeCard,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.removeCardSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}