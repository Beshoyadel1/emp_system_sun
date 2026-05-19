import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:emp_system_sun/features/cars_haraj_page/data/request/update_harage_request/update_harage_request.dart';
import '../../request/create_harage_request/create_harage_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/language/language_constant.dart';


Future<void> createHarageFunction({required UpdateHarageRequest updateHarageRequest}) async {
  try {
    String jsonString = json.encode(updateHarageRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
        ApiLink.createHarage
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.createHarageSuccessfully);
    });

  } catch (e) {
    throw e;
  }
}

