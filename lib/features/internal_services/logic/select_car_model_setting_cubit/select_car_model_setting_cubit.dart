import 'package:emp_system_sun/core/api_functions/general/car/car_brand/get_car_brand_models_model/get_car_brand_repository.dart';
import 'package:emp_system_sun/core/api_functions/general/car/car_model/get_car_brand_models/car_model_data_model.dart';
import 'package:emp_system_sun/core/api_functions/general/car/car_model/get_car_brand_models/get_car_brand_models_repository.dart';
import 'package:emp_system_sun/core/api_functions/general/car/car_model/get_car_brand_models/get_car_brand_models_request.dart';
import 'package:emp_system_sun/features/internal_services/logic/brand_input_data/brand_input_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'select_car_model_setting_state.dart';

class SelectCarModelSettingCubit
    extends Cubit<SelectCarModelSettingState> {
  SelectCarModelSettingCubit()
      : super(SelectCarModelSettingState());

  final Map<int, List<CarModelDataModel>> _modelsCache = {};

  /// 🔥 KEY = brandId (NOT index)
  final Map<int, BrandInputData> brandInputs = {};

  /// =========================
  /// SETTERS
  /// =========================

  void setSelectedOption(int brandId, int option) {
    final existing = brandInputs[brandId] ?? BrandInputData();

    existing.selectedOption = option;
    brandInputs[brandId] = existing;

    checkValidation();
  }

  void setUnifiedPrice(int brandId, String value) {
    final existing = brandInputs[brandId] ?? BrandInputData();

    existing.unifiedPrice = value;
    brandInputs[brandId] = existing;

    checkValidation();
  }

  void setModelPrice(int brandId, int modelId, String value) {
    final existing = brandInputs[brandId] ?? BrandInputData();

    existing.modelPrices[modelId] = value;
    brandInputs[brandId] = existing;

    checkValidation();
  }

  /// =========================
  /// VALIDATION
  /// =========================

  void checkValidation() {
    final message = validateAllWithMessage();

    emit(state.copyWith(
      isValid: message == null,
    ));
  }

  String? validateAllWithMessage() {
    final brands = state.brands;

    if (brands.isEmpty) return "No brands";

    bool hasAny = false;

    for (final brand in brands) {
      final brandId = brand.id;
      if (brandId == null) continue;

      final input = brandInputs[brandId];

      if (input == null) continue;

      hasAny = true;

      if (input.selectedOption == null) {
        return "Choose option for ${brand.name}";
      }

      if (input.selectedOption == 0) {
        if (input.unifiedPrice == null ||
            input.unifiedPrice!.trim().isEmpty) {
          return "Enter price for ${brand.name}";
        }
      }

      if (input.selectedOption == 1) {
        final models = getModelsForBrand(brandId);

        if (models.isEmpty) {
          return "Models not loaded for ${brand.name}";
        }

        for (final model in models) {
          final price = input.modelPrices[model.id];

          if (price == null || price.trim().isEmpty) {
            return "Enter price for ${model.name}";
          }
        }
      }
    }

    if (!hasAny) return "Select at least one brand";

    return null;
  }

  /// =========================
  /// MODELS
  /// =========================

  List<CarModelDataModel> getModelsForBrand(int? brandId) {
    if (brandId == null) return [];
    return _modelsCache[brandId] ?? [];
  }
  Future<void> fetchBrands() async {
    emit(state.copyWith(
      isLoadingBrands: true,
      error: null,
    ));

    try {
      final data = await getCarBrandFunction();

      if (data.isEmpty) {
        emit(state.copyWith(
          isLoadingBrands: false,
          brands: [],
        ));
        return;
      }

      emit(state.copyWith(
        isLoadingBrands: false,
        brands: data,
        selectedBrandIndex: 0,
        isLoadingModels: true,
        models: [],
      ));

      await selectBrand(0);

    } catch (e) {
      emit(state.copyWith(
        isLoadingBrands: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> selectBrand(int index) async {
    if (index == state.selectedBrandIndex &&
        state.models.isNotEmpty) return;

    final brand = state.brands[index];
    final brandId = brand.id;

    if (brandId == null) return;

    /// show loading
    emit(state.copyWith(
      selectedBrandIndex: index,
      selectedModelIndex: -1,
      isLoadingModels: true,
      models: [],
      error: null,
    ));

    try {
      if (_modelsCache.containsKey(brandId)) {
        emit(state.copyWith(
          isLoadingModels: false,
          models: _modelsCache[brandId],
        ));
        return;
      }

      final data = await getCarBrandModelsFunction(
        request: GetCarBrandModelsRequest(
          carBrandId: brandId,
        ),
      );

      _modelsCache[brandId] = data;

      emit(state.copyWith(
        isLoadingModels: false,
        models: data,
      ));

    } catch (e) {
      emit(state.copyWith(
        isLoadingModels: false,
        error: e.toString(),
      ));
    }
  }

  void selectModel(int index) {
    emit(state.copyWith(
      selectedModelIndex: index,
    ));
  }
}