import 'package:dio/dio.dart';
import '../../../../core/api_functions/company_management/get_company_drivers_model/get_company_drivers_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getCompanyDriversFunction({
  required GetCompanyDriversRequest getCompanyDriversRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getCompanyDriversRequest.toJson(), // params
      ApiLink.getCompanyDrivers,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getCompanyDriversSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}