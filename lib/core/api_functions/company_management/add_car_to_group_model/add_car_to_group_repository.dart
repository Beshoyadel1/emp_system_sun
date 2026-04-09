import 'package:dio/dio.dart';
import '../../../../core/api_functions/company_management/add_car_to_group_model/add_car_to_group_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';


Future<void> addCarToGroupFunction({
  required AddCarToGroupRequest addCarToGroupRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      addCarToGroupRequest.toJson(), // params
        ApiLink.addCarToGroup
    );
    AppSnackBar.showSuccess(AppLanguageKeys.addCarToGroupSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}