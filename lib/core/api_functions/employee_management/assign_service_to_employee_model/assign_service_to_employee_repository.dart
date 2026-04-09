import 'package:dio/dio.dart';
import '../../../../core/language/language_constant.dart';
import '../../../../core/api_functions/employee_management/assign_service_to_employee_model/assign_service_to_employee_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<void> assignServiceToEmployeeFunction({
  required AssignServiceToEmployeeRequest assignServiceToEmployeeRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      assignServiceToEmployeeRequest.toJson(), // params
      ApiLink.assignServiceToEmployee,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.assignServiceToEmployeeSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}