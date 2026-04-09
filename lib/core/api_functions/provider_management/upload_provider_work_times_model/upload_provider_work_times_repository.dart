import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/provider_management/upload_provider_work_times_model/upload_provider_work_times_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> uploadProviderWorkTimesFunction({required UploadProviderWorkTimesRequest uploadProviderWorkTimesRequest}) async {
  try {
    String jsonString = json.encode(uploadProviderWorkTimesRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.uploadProviderWorkTimes,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.uploadProviderWorkTimesSuccess);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}