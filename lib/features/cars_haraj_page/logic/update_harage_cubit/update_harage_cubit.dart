import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../../../core/api_functions/harage/update_harage_model/update_harage_repository.dart';
import '../../../../../features/cars_haraj_page/logic/update_harage_cubit/update_harage_state.dart';
import '../../../../core/api_functions/harage/update_harage_model/update_harage_request.dart';
import '../../../../core/api/dio_function/failures.dart';

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
}