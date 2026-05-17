import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:emp_system_sun/features/cars_haraj_page/data/model/update_harage_model/update_harage_request.dart';
import '../../model/create_harage_model/create_harage_request.dart';
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

