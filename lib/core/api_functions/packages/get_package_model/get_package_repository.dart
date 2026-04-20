import 'package:dio/dio.dart';
import '../../../../../../core/api_functions/packages/get_package_model/get_package_request.dart';
import '../../../../../../core/api_functions/packages/get_package_model/package_model_get_package_repository.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<List<PackageModelGetPackageRepository>> getPackageFunction({
  required GetPackageRequest request,
}) async {
  try {
    final response = await Network.getDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.getPackage,
    );


    final responseData = response.data;

    final List data = responseData is List
        ? responseData
        : responseData['data'] ?? [];

    return data
        .map((e) => PackageModelGetPackageRepository.fromJson(e))
        .toList();

  } catch (e) {

    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
    return [];
  }
}