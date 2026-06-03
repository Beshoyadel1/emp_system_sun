import 'package:dio/dio.dart';
import 'package:emp_system_sun/features/store_page/data/request/get_provider_work_time_request/get_provider_work_time_request.dart';
import 'package:emp_system_sun/features/store_page/data/model/upload_provider_work_times_model/work_time_model.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';
import '../../../../../core/language/language_constant.dart';

Future<List<WorkTimeModel>> getProviderWorkTimeFunction({
  required GetProviderWorkTimeRequest getProviderWorkTimeRequest,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      getProviderWorkTimeRequest.toJson(),
      ApiLink.getProviderWorkTime,
    );

    final responseData = response.data;

    final bool success = responseData["success"] ?? false;

    if (!success) {
      return [];
    }

    final List<dynamic> data = (responseData["data"] as List?) ?? [];

    return data.map((e) {
      return WorkTimeModel(
        worktimeid: e["worktimeid"],
        provid: e["provid"],
        sat: e["sat"],
        sun: e["sun"],
        mon: e["mon"],
        tue: e["tue"],
        wed: e["wed"],
        thr: e["thr"],
        fri: e["fri"],
        fromTime: e["fromtime"],
        toTime: e["totime"],
      );
    }).toList();
  } catch (e) {
    if (e is DioException) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
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
    }

    throw Exception(
      e.toString(),
    );
  }
}
