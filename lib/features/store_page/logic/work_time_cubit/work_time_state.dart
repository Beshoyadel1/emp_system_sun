import '../../../../../../core/api_functions/work_time/upload_provider_work_times_model/work_time_model.dart';

abstract class WorkTimeState {}

class WorkTimeInitial extends WorkTimeState {}

class WorkTimeLoading extends WorkTimeState {}

class WorkTimeSuccess extends WorkTimeState {}

class WorkTimeError extends WorkTimeState {
  final String message;
  WorkTimeError(this.message);
}

class WorkTimeDaysChanged extends WorkTimeState {
  final Set<int> selectedDays;
  WorkTimeDaysChanged(this.selectedDays);
}

class WorkTimeTimeChanged extends WorkTimeState {}
class WorkTimeDeleteSuccess extends WorkTimeState {}
class WorkTimeLoaded extends WorkTimeState {
  final List<WorkTimeModel> workTimes;

  WorkTimeLoaded(this.workTimes);
}
