import 'package:dio/dio.dart';
import '../../../../core/api_functions/user/check_if_user_exist_or_not_model/check_if_user_exist_or_not_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> checkIfUserExistOrNotFunction({
  required CheckIfUserExistOrNotRequest checkIfUserExistOrNotRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      checkIfUserExistOrNotRequest.toJson(), // params
      ApiLink.checkIfUserExistOrNot,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.checkIfUserExistOrNotSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}
