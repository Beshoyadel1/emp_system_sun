abstract class FacilityTabState {}

class FacilityDataState extends FacilityTabState {}

class IdentityState extends FacilityTabState {}

class IdentityUploadedState extends FacilityTabState {}

class WorkingHoursState extends FacilityTabState {}

class WorkingHoursDaySelectedState extends FacilityTabState {
  final int selectedIndex;

  WorkingHoursDaySelectedState(this.selectedIndex);
}

class BranchesState extends FacilityTabState {}

class AddBranchState extends FacilityTabState {}

class BankAccountState extends FacilityTabState {}

class TimerCompleteState extends FacilityTabState {}

class ChangeIndexState extends FacilityTabState {}

class GetImageFromDeviceState extends FacilityTabState {}

class ChangeGetImageFromDeviceState extends FacilityTabState {}

class IdentityDeletedState extends FacilityTabState {}
