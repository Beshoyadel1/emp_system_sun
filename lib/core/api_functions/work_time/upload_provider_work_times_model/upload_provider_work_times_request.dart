import '../../../../../../core/api_functions/work_time/upload_provider_work_times_model/work_time_model.dart';

class UploadProviderWorkTimesRequest {
  final List<WorkTimeModel> workTimes;

  UploadProviderWorkTimesRequest({required this.workTimes});

  List<Map<String, dynamic>> toJson() {
    return workTimes.map((e) => e.toJson()).toList();
  }
}