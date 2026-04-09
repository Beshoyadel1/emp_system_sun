import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/provider_management/update_service_package_model/update_service_package_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> updateServicePackageFunction({required UpdateServicePackageRequest updateServicePackageRequest}) async {
  try {
    String jsonString = json.encode(updateServicePackageRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.updateServicePackage,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.updateServicePackageSuccess);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}