import 'package:dio/dio.dart';
import '../../../../core/api_functions/company_management/delete_car_group_model/delete_car_group_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> deleteCarGroupFunction({
  required DeleteCarGroupRequest deleteCarGroupRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      deleteCarGroupRequest.toJson(), // params
      ApiLink.deleteCarGroup,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.deleteCarGroupSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}
