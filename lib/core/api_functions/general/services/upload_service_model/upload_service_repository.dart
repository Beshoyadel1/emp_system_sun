import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../core/api_functions/general/services/upload_service_model/upload_service_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/language/language_constant.dart';

Future<void> uploadServiceFunction({
  required UploadServiceRequest uploadServiceRequest,
}) async {
  try {
    String jsonString = json.encode(uploadServiceRequest.toJson());
    await Network.postDataWithBody(
      jsonString,
      ApiLink.uploadService,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.uploadServiceSuccessfully);
    }
    );
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}
