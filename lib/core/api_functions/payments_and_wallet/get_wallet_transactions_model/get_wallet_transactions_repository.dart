import 'package:dio/dio.dart';
import '../../../../core/api_functions/payments_and_wallet/get_wallet_transactions_model/get_wallet_transactions_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getWalletTransactionsFunction({
  required GetWalletTransactionsRequest getWalletTransactionsRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getWalletTransactionsRequest.toJson(), // params
      ApiLink.getWalletTransactions,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getWalletTransactionsSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}