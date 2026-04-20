import 'package:dio/dio.dart';
import '../../../../../../core/api_functions/provider_management/get_prov_services_model/get_prov_services_request.dart';
import '../../../../../../core/api_functions/provider_management/get_prov_services_model/get_prov_services_response.dart';
import '../../../../core/api_functions/provider_management/get_branch_employees_model/get_branch_employees_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<List<GetProvServicesResponse>> getProvServicesFunction({
  required GetProvServicesRequest getProvServicesRequest,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      getProvServicesRequest.toJson(),
      ApiLink.getProvServices,
    );

    final res = response.data;

    /// ✅ لو null
    if (res == null) {
      return [];
    }

    if (res is List) {
      if (res.isEmpty) return [];
      return res
          .map((e) => GetProvServicesResponse.fromJson(
        e as Map<String, dynamic>,
      ))
          .toList();
    }

    if (res is Map<String, dynamic>) {
      if (res.isEmpty) return [];
      return [GetProvServicesResponse.fromJson(res)];
    }

    return [];
  } catch (e) {
    throw Exception(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}