import 'package:dio/dio.dart';
import '../../../../core/api_functions/user/check_if_user_exist_model/check_if_user_exist_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<bool> checkIfUserExistFunction({
  required CheckIfUserExistRequest checkIfUserExistRequest,
}) async {
  try {
    final value = await Network.postDataWithBodyAndParams(
      {},
      checkIfUserExistRequest.toJson(), // params
      ApiLink.checkIfUserExist,
    );
    final body = value.data.toString().trim();
    if (body == "EmailExist") {
      AppSnackBar.showSuccess(AppLanguageKeys.emailExist);
      return true;
    }
    else{
      AppSnackBar.showError(AppLanguageKeys.emailNotExist);
      return false;
    }
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
    return false;
  }
}
