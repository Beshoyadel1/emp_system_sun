import 'package:emp_system_sun/features/store_page/data/model/upload_provider_work_times_model/work_time_model.dart';

class UploadProviderWorkTimesRequest {
  final List<WorkTimeModel> workTimes;

  UploadProviderWorkTimesRequest({required this.workTimes});

  List<Map<String, dynamic>> toJson() {
    return workTimes.map((e) => e.toJson()).toList();
  }
}