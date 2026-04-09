import 'package:dio/dio.dart';
import '../../../../core/api_functions/user/delete_user_model/delete_user_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> deleteUserFunction({
  required DeleteUserRequest deleteUserRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      deleteUserRequest.toJson(), // params
      ApiLink.deleteUser,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.deleteUserSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}
