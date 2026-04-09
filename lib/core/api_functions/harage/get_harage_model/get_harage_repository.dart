import 'package:dio/dio.dart';
import '../../../../core/api_functions/harage/get_harage_model/get_harage_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getHarageFunction({
  required GetHarageRequest getHarageRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getHarageRequest.toJson(), // params
      ApiLink.getHarage,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getHarageSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}