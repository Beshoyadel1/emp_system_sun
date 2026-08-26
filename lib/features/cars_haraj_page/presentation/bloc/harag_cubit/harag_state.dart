import 'package:emp_system_sun/features/cars_haraj_page/data/model/get_car_brand_models/car_model_data_model.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../../../features/cars_haraj_page/data/model/get_car_brand_models_model/car_brand_data_model.dart';
import '../../../../../../../../../features/cars_haraj_page/data/model/get_car_details_model/get_car_details_model.dart';
import '../../../../../../../../../features/cars_haraj_page/data/response/get_all_harage_response/get_all_harage_response.dart';
import '../../../../../../../../../features/cars_haraj_page/data/response/get_harage_details_response/get_harage_details_response.dart';
import '../../../../../../../../../features/cars_haraj_page/data/response/get_user_harages_response/get_user_harages_response.dart';

abstract class HaragState extends Equatable {
  final int currentPage;
  final int pageCount;

  const HaragState({
    this.currentPage = 1,
    this.pageCount = 0,
  });

  @override
  List<Object?> get props => [
    currentPage,
    pageCount,
  ];
}

class HaragInitial extends HaragState {
  const HaragInitial();
}

class HaragLoading extends HaragState {
  const HaragLoading({
    required super.currentPage,
    required super.pageCount,
  });
}

class HaragSuccess extends HaragState {
  final GetAllHarageResponse response;

  const HaragSuccess({
    required this.response,
    required super.currentPage,
    required super.pageCount,
  });

  @override
  List<Object?> get props => [
    response,
    currentPage,
    pageCount,
  ];
}

class HaragError extends HaragState {
  final String message;

  const HaragError({
    required this.message,
    required super.currentPage,
    required super.pageCount,
  });

  @override
  List<Object?> get props => [
    message,
    currentPage,
    pageCount,
  ];
}

class HaragDetailsLoading extends HaragState {
  const HaragDetailsLoading({
    required super.currentPage,
    required super.pageCount,
  });
}

class HaragDetailsSuccess extends HaragState {
  final GetHarageDetailsResponse? response;

  const HaragDetailsSuccess({
    required this.response,
    required super.currentPage,
    required super.pageCount,
  });
}

class HaragDetailsError extends HaragState {
  final String message;

  const HaragDetailsError({
    required this.message,
    required super.currentPage,
    required super.pageCount,
  });
}
class CarDetailsLoading extends HaragState {
  const CarDetailsLoading();
}

class CarDetailsSuccess extends HaragState {
  final GetCarDetailsModel response;

  const CarDetailsSuccess({
    required this.response,
  });

  @override
  List<Object?> get props => [
    response,
  ];
}

class CarDetailsError extends HaragState {
  final String message;

  const CarDetailsError({
    required this.message,
  });

  @override
  List<Object?> get props => [
    message,
  ];
}
// ============================================================
// USER HARAGES
// ============================================================

class UserHaragesLoading extends HaragState {
  const UserHaragesLoading({
    required super.currentPage,
    required super.pageCount,
  });
}

class UserHaragesSuccess extends HaragState {
  final GetUserHaragesResponse? response;

  const UserHaragesSuccess({
    required this.response,
    required super.currentPage,
    required super.pageCount,
  });
}

class UserHaragesError extends HaragState {
  final String message;

  const UserHaragesError({
    required this.message,
    required super.currentPage,
    required super.pageCount,
  });
}
// ============================================================
// CREATE / UPDATE HARAGE
// ============================================================

class CreateHarageLoading extends HaragState {
  const CreateHarageLoading();
}

class CreateHarageSuccess extends HaragState {
  const CreateHarageSuccess();
}

class CreateHarageError extends HaragState {
  final String message;

  const CreateHarageError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

// ============================================================
// UPDATE HARAGE
// ============================================================

class UpdateHarageLoading extends HaragState {
  const UpdateHarageLoading();
}

class UpdateHarageSuccess extends HaragState {

  const UpdateHarageSuccess();

  @override
  List<Object?> get props => [];
}

class UpdateHarageError extends HaragState {
  final String message;

  const UpdateHarageError({
    required this.message,
  });

}
// ============================================================
// BRAND + MODELS
// ============================================================

class HaragBrandModelsLoading extends HaragState {
  const HaragBrandModelsLoading();
}

class HaragBrandModelsSuccess extends HaragState {
  final CarBrandDataModel brand;
  final List<CarModelDataModel> models;

  const HaragBrandModelsSuccess({
    required this.brand,
    required this.models,
  });

  @override
  List<Object?> get props => [
    brand,
    models,
  ];
}

class HaragBrandModelsError extends HaragState {
  final String message;

  const HaragBrandModelsError({
    required this.message,
  });

  @override
  List<Object?> get props => [
    message,
  ];
}
// ============================================================
// BRANDS
// ============================================================

class HaragBrandsLoading extends HaragState {
  const HaragBrandsLoading();
}

class HaragBrandsSuccess extends HaragState {
  final List<CarBrandDataModel> brands;

  const HaragBrandsSuccess({
    required this.brands,
  });
}

class HaragBrandsError extends HaragState {
  final String message;

  const HaragBrandsError({
    required this.message,
  });
}

// ============================================================
// MODELS
// ============================================================

class HaragModelsLoading extends HaragState {
  const HaragModelsLoading();
}

class HaragModelsSuccess extends HaragState {
  final List<CarModelDataModel> models;

  const HaragModelsSuccess({
    required this.models,
  });
}

class HaragModelsError extends HaragState {
  final String message;

  const HaragModelsError({
    required this.message,
  });
}
class DeleteHarageLoading extends HaragState {
  const DeleteHarageLoading();
}

class DeleteHarageSuccess extends HaragState {
  const DeleteHarageSuccess();
}

class DeleteHarageError extends HaragState {
  final String message;

  const DeleteHarageError({
    required this.message,
  });
}
class SendMessageLoading extends HaragState {
  const SendMessageLoading();
}

class SendMessageSuccess extends HaragState {
  final String? date;

  const SendMessageSuccess({
    this.date,
  });
}

class SendMessageError extends HaragState {
  final String message;

  const SendMessageError({
    required this.message,
  });
}