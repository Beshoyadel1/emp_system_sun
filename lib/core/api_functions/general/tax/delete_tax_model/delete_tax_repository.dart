import 'package:dio/dio.dart';
import '../../../../../core/api_functions/general/tax/delete_tax_model/delete_tax_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/language/language_constant.dart';

Future<void> deleteTaxFunction({
  required DeleteTaxRequest deleteTaxRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      deleteTaxRequest.toJson(), // params
      ApiLink.deleteTax,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.deleteTaxSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}