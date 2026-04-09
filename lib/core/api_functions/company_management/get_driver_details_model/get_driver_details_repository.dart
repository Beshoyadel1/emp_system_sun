import 'package:dio/dio.dart';
import '../../../../core/api_functions/company_management/get_driver_details_model/get_driver_details_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getDriverDetailsFunction({
  required GetDriverDetailsRequest getDriverDetailsRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getDriverDetailsRequest.toJson(), // params
      ApiLink.getDriverDetails,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getDriverDetailsSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}
