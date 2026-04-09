import 'package:dio/dio.dart';
import '../../../../../core/api_functions/general/point/get_point_info_model/get_point_info_request.dart';
import '../../../../../core/api_functions/general/tax/get_available_taxes_model/get_available_taxes_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/language/language_constant.dart';

Future<void> getHarageFunction({
  required GetPointInfoRequest getPointInfoRequest,
}) async {
  try {
    await Network.getDataWithBodyAndParams(
      {},
      getPointInfoRequest.toJson(),
      ApiLink.getPointInfo,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.success);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}