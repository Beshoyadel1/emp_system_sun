import 'package:dio/dio.dart';
import 'package:emp_system_sun/features/store_page/data/request/get_provider_branches_request/get_provider_branches_request.dart';
import 'package:emp_system_sun/features/store_page/data/model/get_provider_branches_model/provider_branch_model.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';


Future<List<ProviderBranchModel>>
getProviderBranchesFunction({
  required GetProviderBranchesRequest
  getProviderBranchesRequest,
}) async {

  try {

    final response =
    await Network.getDataWithBodyAndParams(

      {},

      getProviderBranchesRequest.toJson(),

      ApiLink.getProviderBranches,
    );

    final responseData =
        response.data;

    final bool success =
        responseData["success"] ?? false;

    if (!success) {

      throw Exception(

        responseData["message"] ??

            "Something went wrong",
      );
    }

    final List<dynamic> data =
        responseData["data"] ?? [];

    return data
        .map(
          (e) =>
          ProviderBranchModel
              .fromJson(e),
    )
        .toList();

  } catch (e) {

    if (e is DioException) {

      final data =
          e.response?.data;

      if (data
      is Map<String, dynamic>) {

        throw Exception(

          data["message"] ??

              responseOfStatusCode(
                e.response?.statusCode,
              ),
        );
      }

      throw Exception(

        responseOfStatusCode(
          e.response?.statusCode,
        ),
      );

    } else {

      throw Exception(
        e.toString(),
      );
    }
  }
}