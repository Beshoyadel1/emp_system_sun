import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/provider_management/add_branch_model/add_branch_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> addBranchRequestSpendFunction({required AddBranchRequest addBranchRequest}) async {
  try {
    String jsonString = json.encode(addBranchRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
        ApiLink.addBranch
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.updateProductSuccess);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}