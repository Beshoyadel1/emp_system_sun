import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:emp_system_sun/features/store_page/data/request/upload_provider_work_times_request/upload_provider_work_times_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/language/language_constant.dart';

Future<void> uploadProviderWorkTimesFunction({
  required UploadProviderWorkTimesRequest uploadProviderWorkTimesRequest,
}) async {
  try {
    await Network.postDataWithBody(
      uploadProviderWorkTimesRequest.toJson(),
      ApiLink.uploadProviderWorkTimes,
    );
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}