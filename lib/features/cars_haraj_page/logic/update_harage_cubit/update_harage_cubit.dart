import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../../../../core/api_functions/harage/create_harage_model/create_harage_repository.dart';
import '../../../../../../core/api_functions/harage/update_harage_model/update_harage_repository.dart';
import '../../../../../../core/api_functions/user/login_model/login_repository.dart';
import '../../../../../../features/cars_haraj_page/logic/update_harage_cubit/update_harage_state.dart';
import '../../../../core/api_functions/harage/update_harage_model/update_harage_request.dart';
import '../../../../core/api/dio_function/failures.dart';


class UpdateHarageCubit extends Cubit<UpdateHarageState> {
  UpdateHarageCubit() : super(UpdateHarageInitial());

  /// 🔥 UPDATE
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
