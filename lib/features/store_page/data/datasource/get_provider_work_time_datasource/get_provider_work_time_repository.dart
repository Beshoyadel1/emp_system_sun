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

    final List data = response.data;

    return data.map((e) => WorkTimeModel(
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
    )).toList();

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );

    return [];
  }
}