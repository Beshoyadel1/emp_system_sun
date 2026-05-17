import 'package:emp_system_sun/features/cars_haraj_page/data/datasource/get_car_brand_models_datasource/get_car_brand_repository.dart';
import 'package:emp_system_sun/features/cars_haraj_page/presentation/bloc/car_brand_cubit/car_brand_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarBrandCubit extends Cubit<CarBrandState> {
  CarBrandCubit() : super(CarBrandInitial());

  Future<void> fetchBrands() async {
    emit(CarBrandLoading());

    try {
      final brands = await getCarBrandFunction();

      emit(CarBrandSuccess(brands));
    } catch (e) {
      emit(CarBrandError(e.toString()));
    }
  }
}