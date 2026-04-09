import 'package:dio/dio.dart';
import '../../../../core/api_functions/product/delete_product_model/delete_product_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> deleteProductFunction({
  required DeleteProductRequest deleteProductRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      deleteProductRequest.toJson(), // params
        ApiLink.deleteProduct
    );
    AppSnackBar.showSuccess(AppLanguageKeys.deleteProductSuccess);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}