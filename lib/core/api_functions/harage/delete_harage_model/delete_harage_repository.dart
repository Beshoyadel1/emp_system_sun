import 'package:dio/dio.dart';
import '../../../../core/api_functions/harage/delete_harage_model/delete_harage_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> deleteHarageFunction({
  required DeleteHarageRequest deleteHarageRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      deleteHarageRequest.toJson(), // params
      ApiLink.deleteHarage,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.deleteHarageSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}