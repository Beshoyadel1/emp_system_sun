import 'package:dio/dio.dart';
import '../../../../../../core/api_functions/payments_and_wallet/get_provider_balance_details_model/get_provider_balance_details_request.dart';
import '../../../../../../core/api_functions/payments_and_wallet/get_provider_balance_details_model/provider_balance_details_model.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<ProviderBalanceDetailsModel?> getProviderBalanceDetailsFunction({
  required GetProviderBalanceDetailsRequest request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.getProviderBalanceDetails,
    );
    return ProviderBalanceDetailsModel.fromJson(response.data);

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
    return null;
  }
}