import 'package:dio/dio.dart';
import '../../../../core/api_functions/provider_management/get_provider_branches_model/get_provider_branches_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getProviderBranchesFunction({
  required GetProviderBranchesRequest getProviderBranchesRequest,
}) async {
  try {
    await Network.getDataWithBodyAndParams(
      {},
      getProviderBranchesRequest.toJson(), // params
      ApiLink.getProviderBranches,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getProviderBranchesSuccess);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}