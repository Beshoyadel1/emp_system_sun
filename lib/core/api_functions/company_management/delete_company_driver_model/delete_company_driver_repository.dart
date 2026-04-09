import 'package:dio/dio.dart';
import '../../../../core/api_functions/company_management/delete_company_driver_model/delete_company_driver_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';


Future<void> deleteCompanyDriverFunction({
  required DeleteCompanyDriverRequest deleteCompanyDriverRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      deleteCompanyDriverRequest.toJson(), // params
      ApiLink.deleteCompanyDriver,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.deleteCompanyDriverSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}
