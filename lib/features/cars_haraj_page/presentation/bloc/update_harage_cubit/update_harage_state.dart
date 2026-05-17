abstract class UpdateHarageState {}

class UpdateHarageInitial extends UpdateHarageState {}

class UpdateHarageLoading extends UpdateHarageState {}

class UpdateHarageSuccess extends UpdateHarageState {}

class UpdateHarageError extends UpdateHarageState {
  final String message;

  UpdateHarageError(this.message);
}