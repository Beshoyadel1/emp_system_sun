import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/company_management/update_company_driver_model/update_company_driver_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> updateCompanyDriverFunction({required UpdateCompanyDriverRequest updateCompanyDriverRequest}) async {
  try {
    String jsonString = json.encode(updateCompanyDriverRequest.toJson());
    await Network.postDataWithBody(
      jsonString,
      ApiLink.updateCompanyDriver,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.updateCompanyDriverSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}