import 'package:dio/dio.dart';
import '../../../../core/language/language_constant.dart';
import '../../../../core/api_functions/statistics/get_admin_most_requested_services_model/get_admin_most_requested_services_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<void> getAdminMostRequestedServicesFunction({
  required GetAdminMostRequestedServicesRequest getAdminMostRequestedServicesRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getAdminMostRequestedServicesRequest.toJson(), // params
        ApiLink.getAdminMostRequestedServices
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getAdminMostRequestedServicesSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}