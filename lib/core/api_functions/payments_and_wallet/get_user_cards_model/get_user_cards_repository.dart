import 'package:dio/dio.dart';
import '../../../../core/api_functions/payments_and_wallet/get_user_cards_model/get_user_cards_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getUserCardsFunction({
  required GetUserCardsRequest getUserCardsRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getUserCardsRequest.toJson(),
      ApiLink.getUserCards,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getUserCardsSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}