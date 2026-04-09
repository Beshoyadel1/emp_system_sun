import 'package:dio/dio.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/api_functions/general/banner/get_banners_model/get_banners_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';


Future<void> getBannersFunction({
  required GetBannersRequest getBannersRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getBannersRequest.toJson(), // params
      ApiLink.getBanners,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getBannersSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}
