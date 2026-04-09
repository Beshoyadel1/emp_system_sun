import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/payments_and_wallet/recharge_wallet_model/recharge_wallet_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> rechargeWalletFunction({required RechargeWalletRequest rechargeWalletRequest}) async {
  try {
    String jsonString = json.encode(rechargeWalletRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.rechargeWallet,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.rechargeWalletSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}