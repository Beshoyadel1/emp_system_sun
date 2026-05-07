import 'package:dio/dio.dart';
import '../../../../../../core/api_functions/work_time/get_provider_work_time_model/get_provider_work_time_request.dart';
import '../../../../../../core/api_functions/work_time/upload_provider_work_times_model/work_time_model.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

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