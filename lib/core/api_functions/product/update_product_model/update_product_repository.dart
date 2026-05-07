import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<void> updateProductApi({
  required Map<String, dynamic> body,
}) async {
  try {
    final jsonString = json.encode(body);

    await Network.postDataWithBody(
      jsonString,
      ApiLink.updateProduct,
    );
  } catch (e) {
    throw Exception(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}