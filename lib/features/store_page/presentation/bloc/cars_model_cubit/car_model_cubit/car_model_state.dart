abstract class CarModelState {}

class CarModelInitial extends CarModelState {}

class CarModelAdded extends CarModelState {
  final List<String> cars;

  CarModelAdded(this.cars);
}

class CarModelAddingNew extends CarModelState {
  final List<String> cars;

  CarModelAddingNew(this.cars);
}

class SelectedCarState extends CarModelState {
  final String selectedCarName;

  SelectedCarState({this.selectedCarName = ''});
}
