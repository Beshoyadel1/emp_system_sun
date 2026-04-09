import 'package:dio/dio.dart';
import '../../../../core/api_functions/user/get_app_user_info_model/get_app_user_info_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getAppUserInfoFunction({
  required GetAppUserInfoRequest getAppUserInfoRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getAppUserInfoRequest.toJson(), // params
      ApiLink.getAppUserInfo,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getAppUserInfoSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}
