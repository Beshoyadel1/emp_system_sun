

import 'package:emp_system_sun/core/api_functions/general/car/car_brand/get_car_brand_models_model/car_brand_data_model.dart';
import 'package:emp_system_sun/core/api_functions/general/car/car_model/get_car_brand_models/car_model_data_model.dart';

class SelectCarModelSettingState {
  final List<CarBrandDataModel> brands;
  final List<CarModelDataModel> models;

  final int selectedBrandIndex;
  final int selectedModelIndex;

  final bool isLoadingBrands;
  final bool isLoadingModels;

  final bool isValid; // 🔥 ADD

  final String? error;

  SelectCarModelSettingState({
    this.brands = const [],
    this.models = const [],
    this.selectedBrandIndex = -1,
    this.selectedModelIndex = -1,
    this.isLoadingBrands = false,
    this.isLoadingModels = false,
    this.isValid = false, // 🔥 ADD
    this.error,
  });

  SelectCarModelSettingState copyWith({
    List<CarBrandDataModel>? brands,
    List<CarModelDataModel>? models,
    int? selectedBrandIndex,
    int? selectedModelIndex,
    bool? isLoadingBrands,
    bool? isLoadingModels,
    bool? isValid,
    String? error,
  }) {
    return SelectCarModelSettingState(
      brands: brands ?? this.brands,
      models: models ?? this.models,
      selectedBrandIndex:
      selectedBrandIndex ?? this.selectedBrandIndex,
      selectedModelIndex:
      selectedModelIndex ?? this.selectedModelIndex,
      isLoadingBrands:
      isLoadingBrands ?? this.isLoadingBrands,
      isLoadingModels:
      isLoadingModels ?? this.isLoadingModels,
      isValid: isValid ?? this.isValid, // 🔥
      error: error ?? this.error,
    );
  }
}