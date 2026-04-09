import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../core/api_functions/general/point/upload_point_info_model/upload_point_info_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/language/language_constant.dart';

Future<void> uploadPointInfoFunction({required UploadPointInfoRequest uploadPointInfoRequest}) async {
  try {
    String jsonString = json.encode(uploadPointInfoRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.uploadPointInfo,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.uploadPointInfoSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}