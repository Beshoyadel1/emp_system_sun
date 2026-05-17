abstract class DeleteHarageState {}

class DeleteHarageInitial extends DeleteHarageState {}

class DeleteHarageLoading extends DeleteHarageState {}

class DeleteHarageSuccess extends DeleteHarageState {}

class DeleteHarageError extends DeleteHarageState {
  final String message;

  DeleteHarageError(this.message);
}