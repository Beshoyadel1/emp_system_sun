import 'package:dio/dio.dart';
import '../../../../core/api_functions/provider_management/delete_service_package_model/delete_service_package_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> deleteServicePackageFunction({
  required DeleteServicePackageRequest deleteServicePackageRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      deleteServicePackageRequest.toJson(), // params
      ApiLink.deleteServicePackage,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.deleteServicePackageSuccess);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}