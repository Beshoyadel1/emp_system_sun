import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../core/api_functions/general/banner/upload_banners_model/upload_banners_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/language/language_constant.dart';


Future<void> uploadBannersFunction({required UploadBannersRequest uploadBannersRequest}) async {
  try {
    String jsonString = json.encode(uploadBannersRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.uploadBanners,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.uploadBannersSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}