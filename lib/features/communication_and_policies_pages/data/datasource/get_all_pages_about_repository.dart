import 'package:dio/dio.dart';
import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:emp_system_sun/core/api/dio_function/dio_controller.dart';
import 'package:emp_system_sun/core/api/dio_function/failures.dart';
import 'package:emp_system_sun/features/communication_and_policies_pages/data/model/about_page_model.dart';

Future<List<AboutPageModel>> getAllPagesAboutFunction() async {
  try {
    final response = await Network.getData(ApiLink.getAllPagesAbout);
    return parsePagesAboutResponse(response.data);
  } on DioException catch (error) {
    final responseData = error.response?.data;
    final serverMessage =
        responseData is Map ? responseData['message']?.toString() : null;

    throw Exception(
      serverMessage ?? responseOfStatusCode(error.response?.statusCode),
    );
  }
}

List<AboutPageModel> parsePagesAboutResponse(dynamic responseData) {
  if (responseData is! Map<String, dynamic>) {
    throw const FormatException('Invalid pages response');
  }

  final success = responseData['success'] == true;
  if (!success) {
    throw Exception(
      responseData['message']?.toString() ?? 'Something went wrong',
    );
  }

  final rawPages = responseData['data'];
  if (rawPages is! List) return const [];

  return rawPages
      .whereType<Map>()
      .map(
        (page) => AboutPageModel.fromJson(
          Map<String, dynamic>.from(page),
        ),
      )
      .toList(growable: false);
}
