import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/language/language_constant.dart';
import '../../../../core/api_functions/product/create_product_model/create_product_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<void> createProductFunction({required CreateProductRequest createProductRequest}) async {
  try {
    String jsonString = json.encode(createProductRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
        ApiLink.createProduct
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.createProductSuccess);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}