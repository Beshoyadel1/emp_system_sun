import 'package:dio/dio.dart';
import '../../model/get_provider_service_statistics_model/provider_statistics_model.dart';
import '../../request/get_provider_service_statistics_request/get_provider_service_statistics_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';

Future<ProviderStatisticsModel?> getProviderServiceStatisticsFunction({
  required GetProviderServiceStatisticsRequest request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.getProviderServiceStatistics,
    );

    return ProviderStatisticsModel.fromJson(response.data);

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
    return null;
  }
}
