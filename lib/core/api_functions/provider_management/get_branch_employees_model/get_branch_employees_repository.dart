import 'package:dio/dio.dart';
import '../../../../core/api_functions/provider_management/get_branch_employees_model/get_branch_employees_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getBranchEmployeesFunction({
  required GetBranchEmployeesRequest getBranchEmployeesRequest,
}) async {
  try {
    await Network.getDataWithBodyAndParams(
      {},
      getBranchEmployeesRequest.toJson(), // params
      ApiLink.getBranchEmployees,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getBranchEmployeesSuccess);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}