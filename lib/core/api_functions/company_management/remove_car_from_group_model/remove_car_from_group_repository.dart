import 'package:dio/dio.dart';
import '../../../../core/language/language_constant.dart';
import '../../../../core/api_functions/company_management/remove_car_from_group_model/remove_car_from_group_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<void> removeCarFromGroupFunction({
  required RemoveCarFromGroupRequest removeCarFromGroupRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      removeCarFromGroupRequest.toJson(), // params
      ApiLink.removeCarFromGroup,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.removeCarFromGroupSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}