import 'package:dio/dio.dart';
import '../../../../../core/api_functions/general/about_pages/get_all_pages_about_model/get_all_pages_about_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/language/language_constant.dart';

Future<void> getAllPagesAboutFunction({
  required GetAllPagesAboutRequest getAllPagesAboutRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getAllPagesAboutRequest.toJson(), // params
      ApiLink.getAllPagesAbout,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getAllPagesAboutSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}
