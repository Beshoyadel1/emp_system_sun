import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../core/api_functions/general/services/create_service_model/create_service_request.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';


Future<void> createServiceFunction({
  required CreateServiceRequest createServiceRequest,
}) async {
  try {
    String jsonString = json.encode(createServiceRequest.toJson());
    await Network.postDataWithBody(
      jsonString,
        ApiLink.createService
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.createServiceSuccessfully);
    });
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}
