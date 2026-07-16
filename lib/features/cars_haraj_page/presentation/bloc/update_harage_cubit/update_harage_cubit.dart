import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:emp_system_sun/features/auth_page/data/datasource/login_datasource/login_repository.dart';
import 'package:emp_system_sun/features/cars_haraj_page/data/datasource/create_harage_datasource/create_harage_repository.dart';
import 'package:emp_system_sun/features/cars_haraj_page/data/datasource/update_harage_datasource/update_harage_repository.dart';
import 'package:emp_system_sun/features/cars_haraj_page/presentation/bloc/update_harage_cubit/update_harage_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../data/request/update_harage_request/update_harage_request.dart';
import '../../../../../../core/api/dio_function/failures.dart';


class UpdateHarageCubit extends Cubit<UpdateHarageState> {
  UpdateHarageCubit() : super(UpdateHarageInitial());

  Future<void> updateHarage({
    required UpdateHarageRequest request,
  }) async {
    emit(UpdateHarageLoading());

    try {
      await updateHarageFunction(
        updateHarageRequest: request,
      );

      emit(UpdateHarageSuccess());
    } catch (e) {
      emit(
        UpdateHarageError(
          e is DioException
              ? responseOfStatusCode(e.response?.statusCode)
              : e.toString(),
        ),
      );
    }
  }

  Future<int> getProviderId() async {
    final user = await AuthLocalStorage.getUser();
    return user?.userid ?? 0;
  }
  Future<int> getProviderType() async {
    final user = await AuthLocalStorage.getUser();
    return user?.type ?? 0;
  }

  Future<void> createHarage({
    required UpdateHarageRequest request,
  }) async {
    emit(UpdateHarageLoading());

    try {
      final userId = await getProviderId();
      final userType = await getProviderType();

      final finalRequest = request.copyWith(
        userId: userId,
        userType: userType,
      );

      await createHarageFunction(
        updateHarageRequest: finalRequest,
      );

      emit(UpdateHarageSuccess());
    } catch (e) {
      emit(
        UpdateHarageError(
          e is DioException
              ? responseOfStatusCode(e.response?.statusCode)
              : e.toString(),
        ),
      );
    }
  }
}
