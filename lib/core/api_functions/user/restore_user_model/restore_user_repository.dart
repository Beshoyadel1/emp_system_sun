import 'package:dio/dio.dart';
import '../../../../core/api_functions/user/restore_user_model/restore_user_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> restoreUserFunction({
  required RestoreUserRequest restoreUserRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      restoreUserRequest.toJson(), // params
      ApiLink.restoreUser,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.restoreUserSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}