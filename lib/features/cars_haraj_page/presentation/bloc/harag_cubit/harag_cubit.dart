import 'package:emp_system_sun/features/cars_haraj_page/data/datasource/change_harage_status_datasource/change_harage_status_datasource.dart';
import 'package:emp_system_sun/features/cars_haraj_page/data/request/change_harage_status_request/change_harage_status_request.dart';

import '../../../../../../../../../features/cars_haraj_page/data/datasource/get_car_brand_datasource/get_car_brand_models_repository.dart';
import '../../../../../../../../../features/cars_haraj_page/data/request/get_car_brand_request/get_car_brand_models_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../core/theming/auth_local_storage.dart';
import '../../../../../../../../../features/cars_haraj_page/data/datasource/create_harage_datasource/create_harage_repository.dart';
import '../../../../../../../../../features/cars_haraj_page/data/datasource/delete_harage_datasource/delete_harage_repository.dart';
import '../../../../../../../../../features/cars_haraj_page/data/datasource/get_car_brand_models_datasource/get_car_brand_repository.dart';
import '../../../../../../../../../features/cars_haraj_page/data/datasource/update_harage_datasource/update_harage_repository.dart';
import '../../../../../../../../../features/cars_haraj_page/data/model/get_car_brand_models_model/car_brand_data_model.dart';
import '../../../../../../../../../features/cars_haraj_page/data/request/create_update_harage_request/create_update_harage_request.dart';
import '../../../../../../../../../features/cars_haraj_page/data/request/delete_harage_request/delete_harage_request.dart';
import '../../../../../../../../../features/technical_support/data/datasource/send_message_datasource/send_message_repository.dart';
import '../../../../../../../../../features/technical_support/data/request/send_message_request/send_message_request.dart';
import '../../../../../../../features/cars_haraj_page/data/datasource/get_user_harages_datasource/get_user_harages_datasource.dart';
import '../../../../../../../features/cars_haraj_page/data/request/get_user_harages_request/get_user_harages_request.dart';
import '../../../../../../../features/cars_haraj_page/data/response/get_user_harages_response/get_user_harages_response.dart';
import '../../../../../../../features/cars_haraj_page/data/datasource/get_all_harages_datasource/get_all_harages_datasource.dart';
import '../../../../../../../features/cars_haraj_page/data/datasource/get_car_details_datasource/get_car_details_datasource.dart';
import '../../../../../../../features/cars_haraj_page/data/model/get_car_details_model/get_car_details_model.dart';
import '../../../../../../../features/cars_haraj_page/data/request/get_all_harages_request/get_all_harages_request.dart';
import '../../../../../../../features/cars_haraj_page/data/request/get_car_details_request/get_car_details_request.dart';
import '../../../../../../../features/cars_haraj_page/data/response/get_all_harage_response/get_all_harage_response.dart';
import '../../../../../../../features/cars_haraj_page/presentation/bloc/harag_cubit/harag_state.dart';
import '../../../../../../../features/cars_haraj_page/data/request/get_harage_details_request/get_harage_details_request.dart';
import '../../../../../../../features/cars_haraj_page/data/response/get_harage_details_response/get_harage_details_response.dart';
import '../../../../../../../features/cars_haraj_page/data/datasource/get_harage_details_datasource/get_harage_details_datasource.dart';


class HaragCubit extends Cubit<HaragState> {
  HaragCubit()
      : super(
    const HaragInitial(),
  );

  GetAllHarageResponse? haragesResponse;

  GetHarageDetailsResponse? harageDetailsResponse;
  GetCarDetailsModel? carDetailsResponse;

  GetUserHaragesResponse? userHaragesResponse;

// ============================================================
// GET USER HARAGES
// ============================================================

  Future<void> getUserHarages({
    required int currentPage,
  }) async {
    final previousPageCount = state.pageCount;

    emit(
      UserHaragesLoading(
        currentPage: currentPage,
        pageCount: previousPageCount,
      ),
    );

    try {
      final user = await AuthLocalStorage.getUser();

      if (user == null) {
        emit(
          UserHaragesError(
            message: 'User not found',
            currentPage: currentPage,
            pageCount: previousPageCount,
          ),
        );
        return;
      }

      final response = await getUserHaragesFunction(
        getUserHaragesRequest: GetUserHaragesRequest(
          userId: user.userid??0,
          userType: user.type??0,
          pageNumber: currentPage,
        ),
      );

      userHaragesResponse = response;

      emit(
        UserHaragesSuccess(
          response: response,
          currentPage: response?.data?.currentPage ?? currentPage,
          pageCount: response?.data?.pageCount ?? previousPageCount,
        ),
      );
    } catch (e) {
      emit(
        UserHaragesError(
          message: e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
          currentPage: currentPage,
          pageCount: previousPageCount,
        ),
      );
    }
  }
  // ============================================================
// GET CAR DETAILS
// ============================================================

  Future<void> getCarDetails({
    required int carId,
  }) async {
    try {
      emit(
        const CarDetailsLoading(),
      );

      final response = await getCarDetailsFunction(
        request: GetCarDetailsRequest(
          carId: carId,
        ),
      );

      carDetailsResponse = response;

      emit(
        CarDetailsSuccess(
          response: response,
        ),
      );
    } catch (e) {
      carDetailsResponse = null;

      emit(
        CarDetailsError(
          message: e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }
  // ============================================================
  // GET ALL HARAGES
  // ============================================================

  Future<void> getAllHarages({
    required int currentPage,
  }) async {
    final previousPageCount = state.pageCount;

    emit(
      HaragLoading(
        currentPage: currentPage,
        pageCount: previousPageCount,
      ),
    );

    try {
      final response = await getAllHaragesFunction(
        request: GetAllHaragesRequest(
          pageNumber: currentPage,
        ),
      );

      haragesResponse = response;

      emit(
        HaragSuccess(
          response: response,
          currentPage: response.currentPage,
          pageCount: response.pageCount,
        ),
      );
    } catch (e) {
      emit(
        HaragError(
          message: e
              .toString()
              .replaceFirst(
            'Exception: ',
            '',
          ),
          currentPage: currentPage,
          pageCount: previousPageCount,
        ),
      );
    }
  }

  // ============================================================
  // GET HARAGE DETAILS
  // ============================================================

  Future<void> getHarageDetails({
    required int harageId,
  }) async {
    try {
      emit(
        HaragDetailsLoading(
          currentPage: state.currentPage,
          pageCount: state.pageCount,
        ),
      );

      final response = await getHarageDetailsFunction(
        getHarageDetailsRequest: GetHarageDetailsRequest(
          harageId: harageId,
        ),
      );

      harageDetailsResponse = response;

      // ==========================================
      // GET CAR DETAILS
      // ==========================================

      final car = response?.data?.car;

      if (car != null && car.id != null) {
        await getCarDetails(
          carId: car.id!,
        );
      }

      // await getCarDetails(
      //   carId:1,
      // );
      emit(
        HaragDetailsSuccess(
          response: response,
          currentPage: state.currentPage,
          pageCount: state.pageCount,
        ),
      );
    } catch (e) {
      emit(
        HaragDetailsError(
          message: e
              .toString()
              .replaceFirst(
            'Exception: ',
            '',
          ),
          currentPage: state.currentPage,
          pageCount: state.pageCount,
        ),
      );
    }
  }
  Future<void> sendMessage({
    required int toUser,
    required int toUserType,
    required String message,
    required int harageId,
  }) async {
    emit(const SendMessageLoading());

    try {
      final user = await AuthLocalStorage.getUser();

      if (user == null) {
        emit(
          const SendMessageError(
            message: 'User not found',
          ),
        );
        return;
      }

      final request = SendMessageRequest(
        id: 0,
        fromuser: user.userid ?? 0,
        fromusertype: user.type ?? 0,
        touser: toUser,
        tousertype: toUserType,
        message: message,
        date: DateTime.now().toUtc().toIso8601String(),
        harageid: harageId,
      );

      await sendMessageFunction(
        sendMessageRequest: request,
      );

      emit(const SendMessageSuccess());
    } catch (e) {
      emit(
        SendMessageError(
          message: e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }
// ============================================================
// CREATE HARAGE
// ============================================================

  Future<void> createHarage({
    required CreateUpdateHarageRequest request,
  }) async {
    emit(const CreateHarageLoading());

    try {
      final user = await AuthLocalStorage.getUser();

      if (user == null) {
        emit(
          const CreateHarageError(
            message: 'User not found',
          ),
        );
        return;
      }

      final createRequest = CreateUpdateHarageRequest(
        userId: user.userid,
        userType: user.type,

        carId: request.carId,
        carBrandId: request.carBrandId,
        carModelId: request.carModelId,
        isNew: request.isNew,
        releaseDate: request.releaseDate,
        transmissionType: request.transmissionType,
        fuelType: request.fuelType,
        kilometers: request.kilometers,
        description: request.description,
        addressText: request.addressText,
        price: request.price,
        cost: request.cost,
        branchId: request.branchId,
        images: request.images,
      );

      await createHarageFunction(
        createUpdateHarageRequest: createRequest,
      );

      emit(const CreateHarageSuccess());
    } catch (e) {
      emit(
        CreateHarageError(
          message: e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }
  Future<void> deleteHarage({
    required int harageId,
  }) async {
    emit(const DeleteHarageLoading());

    try {
      final request = DeleteHarageRequest(
        harageId: harageId,
      );

      await deleteHarageFunction(
        deleteHarageRequest: request,
      );

      emit(const DeleteHarageSuccess());
    } catch (e) {
      emit(
        DeleteHarageError(
          message: e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }
// ============================================================
// UPDATE HARAGE
// ============================================================

  Future<void> changeHarageStatus({
    required ChangeHarageStatusRequest request,
  }) async {
    emit(ChangeHarageStatusLoading());

    try {
      await changeHarageStatusFunction(
        request: request,
      );

      emit(ChangeHarageStatusSuccess());
    } catch (e) {
      emit(
        ChangeHarageStatusError(
          e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }
  Future<void> updateHarage({
    required CreateUpdateHarageRequest request,
    int? harageStatus,
    String? statusNotes,
  }) async {
    emit(const UpdateHarageLoading());

    try {
      // =========================
      // UPDATE HARAGE
      // =========================

      await updateHarageFunction(
        createUpdateHarageRequest: request,
      );

      // =========================
      // CHANGE STATUS
      // =========================

      if (harageStatus != null && request.id != null) {
        await changeHarageStatusFunction(
          request: ChangeHarageStatusRequest(
            harageId: request.id!,
            status: harageStatus,
            notes: statusNotes,
          ),
        );
      }

      // =========================
      // SUCCESS
      // =========================

      emit(
        const UpdateHarageSuccess(),
      );
    } catch (e) {
      emit(
        UpdateHarageError(
          message: e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }
  // ============================================================
  // REFRESH
  // ============================================================
  Future<void> getCarBrands() async {
    emit(const HaragBrandsLoading());

    try {
      final brands = await getCarBrandFunction();

      final validBrands = <CarBrandDataModel>[];

      for (final brand in brands) {
        final brandId = brand.id;

        if (brandId == null || brandId == 0) {
          continue;
        }

        try {
          final models = await getCarBrandModelsFunction(
            request: GetCarBrandModelsRequest(
              carBrandId: brandId,
            ),
          );

          // Only add the brand if it has models
          if (models.isNotEmpty) {
            validBrands.add(brand);
          }
        } catch (_) {
          // Ignore this brand if its models request fails
          continue;
        }
      }

      if (validBrands.isEmpty) {
        emit(
          const HaragBrandsError(
            message: 'No brands with models found',
          ),
        );
        return;
      }

      emit(
        HaragBrandsSuccess(
          brands: validBrands,
        ),
      );
    } catch (e) {
      emit(
        HaragBrandsError(
          message: e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }

// ============================================================
// GET MODELS BY BRAND ID
// ============================================================
  Future<void> getCarModels({
    required int brandId,
  }) async {
    emit(const HaragModelsLoading());

    try {
      final models = await getCarBrandModelsFunction(
        request: GetCarBrandModelsRequest(
          carBrandId: brandId,
        ),
      );

      if (models.isEmpty) {
        emit(
          const HaragModelsError(
            message: 'No models found',
          ),
        );
        return;
      }

      emit(
        HaragModelsSuccess(
          models: models,
        ),
      );
    } catch (e) {
      emit(
        HaragModelsError(
          message: e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }


  Future<void> refreshGetAllHarages() async {
    await getAllHarages(
      currentPage: state.currentPage,
    );
  }
}