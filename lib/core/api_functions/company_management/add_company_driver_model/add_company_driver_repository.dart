import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/company_management/add_company_driver_model/add_company_driver_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';


Future<void> addCompanyDriverFunction({required AddCompanyDriverRequest addCompanyDriverRequest}) async {
  try {
    String jsonString = json.encode(addCompanyDriverRequest.toJson());
    await Network.postDataWithBody(
      jsonString,
        ApiLink.addCompanyDriver
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.addCompanyDriverSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}