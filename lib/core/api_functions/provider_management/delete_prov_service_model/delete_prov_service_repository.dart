import 'package:dio/dio.dart';
import '../../../../core/api_functions/provider_management/delete_prov_service_model/delete_prov_service_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> deleteProvServiceFunction({
  required DeleteProvServiceRequest deleteProvServiceRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      deleteProvServiceRequest.toJson(), // params
        ApiLink.deleteProvService
    );
    AppSnackBar.showSuccess(AppLanguageKeys.deleteProvServiceSuccess);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}