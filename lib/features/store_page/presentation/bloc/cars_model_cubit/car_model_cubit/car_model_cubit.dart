import 'package:flutter_bloc/flutter_bloc.dart';
import 'car_model_state.dart';

class CarModelCubit extends Cubit<CarModelState> {
  CarModelCubit() : super(CarModelInitial());

  List<String> cars = [];

  void addCar(String carName) {
    cars.add(carName);
    emit(CarModelAdded(List.from(cars)));
  }

  void startAddingNewCar() {
    emit(CarModelAddingNew(List.from(cars)));
  }

  void goBack() {
    if (state is CarModelAddingNew) {
      emit(CarModelAdded(List.from(cars)));
    } else if (state is CarModelAdded) {
      emit(CarModelInitial());
    }
  }

  void changeCar(String name) {
    emit(SelectedCarState(selectedCarName: name));
  }
}
