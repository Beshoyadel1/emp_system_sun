import 'package:dio/dio.dart';
import '../../../../core/api_functions/product/get_product_model/get_product_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getProductFunction({
  required GetProductRequest getProductRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getProductRequest.toJson(), // params
        ApiLink.getProduct
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getProductSuccess);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}