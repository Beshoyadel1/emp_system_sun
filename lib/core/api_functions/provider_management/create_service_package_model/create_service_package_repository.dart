import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/provider_management/create_service_package_model/create_service_package_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> createServicePackageFunction({
  required CreateServicePackageRequest request,
}) async {
  try {
    await Network.postDataWithBody(
      request.toJson(),
      ApiLink.createServicePackage,
    );

  } on DioException catch (e) {
    rethrow; // مهم جدًا
  }
}