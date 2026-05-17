import 'package:dio/dio.dart';
import 'package:emp_system_sun/features/store_page/data/model/get_provider_branches_model/get_provider_branches_request.dart';
import 'package:emp_system_sun/features/store_page/data/model/get_provider_branches_model/provider_branch_model.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';


Future<List<ProviderBranchModel>> getProviderBranchesFunction({
  required GetProviderBranchesRequest getProviderBranchesRequest,
}) async {
  try {
    final response = await Network.getDataWithBodyAndParams(
      {},
      getProviderBranchesRequest.toJson(),
      ApiLink.getProviderBranches,
    );

    final data = response.data;

    if (data is List) {
      return data
          .map((e) => ProviderBranchModel.fromJson(e))
          .toList();
    }

    return [];
  } catch (e) {
    if (e is DioException) {

      throw Exception(
        e.response?.data.toString() ??
            responseOfStatusCode(e.response?.statusCode),
      );
    } else {

      throw Exception(e.toString());
    }
  }
}
