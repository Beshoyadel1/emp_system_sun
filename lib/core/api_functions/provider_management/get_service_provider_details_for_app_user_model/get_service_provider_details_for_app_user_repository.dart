import 'package:dio/dio.dart';
import '../../../../core/api_functions/provider_management/get_service_provider_details_for_app_user_model/get_service_provider_details_for_app_user_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getServiceProviderDetailsForAppUserFunction({
  required GetServiceProviderDetailsForAppUserRequest getServiceProviderDetailsForAppUserRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getServiceProviderDetailsForAppUserRequest.toJson(), // params
      ApiLink.getServiceProviderDetailsForAppUser,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getServiceProviderDetailsForAppUserSuccess);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}