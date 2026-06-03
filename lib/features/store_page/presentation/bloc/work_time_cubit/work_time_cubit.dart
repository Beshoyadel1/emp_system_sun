import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/features/auth_page/data/datasource/login_datasource/login_repository.dart';
import 'package:emp_system_sun/features/store_page/data/datasource/delete_provider_work_time_datasource/delete_provider_work_time_repository.dart';
import 'package:emp_system_sun/features/store_page/data/request/delete_provider_work_time_request/delete_provider_work_time_request.dart';
import 'package:emp_system_sun/features/store_page/data/datasource/get_provider_work_time_datasource/get_provider_work_time_repository.dart';
import 'package:emp_system_sun/features/store_page/data/request/get_provider_work_time_request/get_provider_work_time_request.dart';
import 'package:emp_system_sun/features/store_page/data/datasource/upload_provider_work_times_datasource/upload_provider_work_times_repository.dart';
import 'package:emp_system_sun/features/store_page/data/request/upload_provider_work_times_request/upload_provider_work_times_request.dart';
import 'package:emp_system_sun/features/store_page/data/model/upload_provider_work_times_model/work_time_model.dart';
import 'package:emp_system_sun/features/store_page/presentation/bloc/work_time_cubit/work_time_state.dart';


class UpdateWorkTimeCubit extends Cubit<WorkTimeState> {
  UpdateWorkTimeCubit() : super(WorkTimeInitial());

  static UpdateWorkTimeCubit get(context) => BlocProvider.of(context);

  /// ================= DATA =================
  Set<int> selectedDays = {};
  String? fromTime;
  String? toTime;
  int? providerId;

  /// ================= INIT USER =================
  Future<void> _initUser() async {
    if (providerId != null) return;

    final user = await AuthLocalStorage.getUser();
    providerId = user!.userid!;
  }

  /// ================= SELECT DAYS =================
  void toggleDay(int index) {
    if (selectedDays.contains(index)) {
      selectedDays.remove(index);
    } else {
      selectedDays.add(index);
    }

    emit(WorkTimeDaysChanged(Set.from(selectedDays)));
  }

  /// ================= TIME =================
  void setFromTime(String time) {
    fromTime = time;
    emit(WorkTimeTimeChanged());
  }

  void setToTime(String time) {
    toTime = time;
    emit(WorkTimeTimeChanged());
  }

  /// ================= BUILD MODEL =================
  WorkTimeModel _buildModel(int worktimeId) {
    return WorkTimeModel(
      worktimeid: worktimeId,
      provid: providerId!,

      sat: selectedDays.contains(0),
      sun: selectedDays.contains(1),
      mon: selectedDays.contains(2),
      tue: selectedDays.contains(3),
      wed: selectedDays.contains(4),
      thr: selectedDays.contains(5),
      fri: selectedDays.contains(6),

      fromTime: fromTime ?? "",
      toTime: toTime ?? "",
    );
  }

  /// ================= CREATE =================
  Future<void> createWorkTime() async {
    await _initUser();

    if (selectedDays.isEmpty) {
      emit(WorkTimeError("Select at least one day"));
      return;
    }

    if (fromTime == null || toTime == null) {
      emit(WorkTimeError("Select time"));
      return;
    }

    try {
      emit(WorkTimeLoading());

      final request = UploadProviderWorkTimesRequest(
        workTimes: [
          _buildModel(0),
        ],
      );

      print("========== CREATE REQUEST ==========");
      print(request.toJson());

      await uploadProviderWorkTimesFunction(
        uploadProviderWorkTimesRequest: request,
      );

      await getWorkTimes();

      print("========== WORK TIMES AFTER CREATE ==========");
      print(workTimes.length);

      emit(WorkTimeSuccess());
    } catch (e, s) {
      print("CREATE ERROR => $e");
      print(s);
      emit(WorkTimeError(e.toString()));
    }
  }

  Future<void> updateWorkTime(int worktimeId) async {
    await _initUser();

    if (selectedDays.isEmpty) {
      emit(WorkTimeError("Select at least one day"));
      return;
    }

    if (fromTime == null || toTime == null) {
      emit(WorkTimeError("Select time"));
      return;
    }

    try {
      emit(WorkTimeLoading());

      final request = UploadProviderWorkTimesRequest(
        workTimes: [
          _buildModel(worktimeId),
        ],
      );

      await uploadProviderWorkTimesFunction(
        uploadProviderWorkTimesRequest: request,
      );
      await getWorkTimes();
      clearSelection();
      emit(WorkTimeSuccess());
    } catch (e) {
      emit(WorkTimeError(e.toString()));
    }
  }


  Future<void> deleteWorkTime(int workTimeId) async {
    await _initUser();

    try {
      emit(WorkTimeLoading());

      final request = DeleteProviderWorkTimeRequest(
        providerId: providerId!,
        workTimeId: workTimeId,
      );

      await deleteProviderWorkTimeFunction(
        deleteProviderWorkTimeRequest: request,
      );
      await getWorkTimes();
      emit(WorkTimeDeleteSuccess());
    } catch (e) {
      emit(WorkTimeError(e.toString()));
    }
  }
  List<WorkTimeModel> workTimes = [];
  Future<void> getWorkTimes() async {
    await _initUser();

    try {
      emit(WorkTimeLoading());

      final result = await getProviderWorkTimeFunction(
        getProviderWorkTimeRequest: GetProviderWorkTimeRequest(
          providerId: providerId!,
        ),
      );

      workTimes = result;

      emit(WorkTimeLoaded(result));
    } catch (e) {
      emit(WorkTimeError(e.toString()));
    }
  }
  /// ================= RESET =================
  void reset() {
    selectedDays.clear();
    fromTime = null;
    toTime = null;
    emit(WorkTimeInitial());
  }
  int? selectedWorkTimeId;
  bool isEditMode = false;

  /// fill data when selecting item
  void selectWorkTime(WorkTimeModel item) {
    selectedWorkTimeId = item.worktimeid;
    isEditMode = true;

    selectedDays.clear();

    if (item.sat == true) selectedDays.add(0);
    if (item.sun == true) selectedDays.add(1);
    if (item.mon == true) selectedDays.add(2);
    if (item.tue == true) selectedDays.add(3);
    if (item.wed == true) selectedDays.add(4);
    if (item.thr == true) selectedDays.add(5);
    if (item.fri == true) selectedDays.add(6);

    fromTime = item.fromTime;
    toTime = item.toTime;

    emit(WorkTimeLoaded(workTimes));
  }

  /// clear form (back to create)
  void clearSelection() {
    selectedWorkTimeId = null;
    isEditMode = false;

    selectedDays.clear();
    fromTime = null;
    toTime = null;

    emit(WorkTimeInitial());
  }
}