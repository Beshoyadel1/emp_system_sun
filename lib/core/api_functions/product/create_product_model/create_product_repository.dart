import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/product/create_product_model/create_product_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<void> createProductApi({
  required CreateProductRequest request,
}) async {
  try {
    final jsonString = json.encode(request.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.createProduct,
    );
  } catch (e) {
    throw Exception(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}