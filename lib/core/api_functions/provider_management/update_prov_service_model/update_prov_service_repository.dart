import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/provider_management/update_prov_service_model/update_prov_service_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> updateProvServiceFunction({required UpdateProvServiceRequest updateProvServiceRequest}) async {
  try {
    String jsonString = json.encode(updateProvServiceRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.updateProvService,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.updateProvServiceSuccess);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}