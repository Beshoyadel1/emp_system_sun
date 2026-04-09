import 'package:dio/dio.dart';
import '../../../../core/api_functions/employee_management/get_employee_services_model/get_employee_services_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getEmployeeServicesFunction({
  required GetEmployeeServicesRequest getEmployeeServicesRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getEmployeeServicesRequest.toJson(), // params
      ApiLink.getEmployeeServices,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getEmployeeServicesSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}