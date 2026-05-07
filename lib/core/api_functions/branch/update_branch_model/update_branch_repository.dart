import 'package:dio/dio.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<Response> updateBranchFunction({
  required Map<String, dynamic> body,
}) async {
  try {
    final response = await Network.postDataWithBody(
      body,
      ApiLink.updateBranch,
    );

    return response;
  } catch (e) {
    throw Exception(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}