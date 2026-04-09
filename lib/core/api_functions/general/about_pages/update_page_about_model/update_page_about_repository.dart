import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../core/api_functions/general/about_pages/update_page_about_model/update_page_about_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/language/language_constant.dart';

Future<void> updatePageAboutFunction({required UpdatePageAboutRequest updatePageAboutRequest}) async {
  try {
    String jsonString = json.encode(updatePageAboutRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.updatePageAbout,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.updatePageAboutSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}

