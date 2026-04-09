import 'package:dio/dio.dart';
import '../../../../core/api_functions/provider_management/get_service_providers_by_service_id_for_app_user_model/get_service_providers_by_service_id_for_app_user_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getServiceProvidersByServiceIdForAppUserFunction({
  required GetServiceProvidersByServiceIdForAppUserRequest getServiceProvidersByServiceIdForAppUserRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getServiceProvidersByServiceIdForAppUserRequest.toJson(), // params
      ApiLink.getServiceProvidersByServiceIdForAppUser,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getServiceProvidersByServiceIdForAppUserSuccess);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}