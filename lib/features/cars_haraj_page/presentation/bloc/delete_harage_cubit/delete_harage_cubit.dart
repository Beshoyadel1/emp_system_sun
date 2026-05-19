import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../data/request/delete_harage_request/delete_harage_request.dart';
import '../../../data/datasource/delete_harage_datasource/delete_harage_repository.dart';
import '../../../../../../core/api/dio_function/failures.dart';

import 'delete_harage_state.dart';

class DeleteHarageCubit extends Cubit<DeleteHarageState> {
  DeleteHarageCubit() : super(DeleteHarageInitial());

  Future<void> deleteHarage({
    required int harageId,
  }) async {
    emit(DeleteHarageLoading());

    try {
      await deleteHarageFunction(
        deleteHarageRequest: DeleteHarageRequest(
          harageId: harageId,
        ),
      );

      emit(DeleteHarageSuccess());
    } catch (e) {
      emit(
        DeleteHarageError(
          e is DioException
              ? responseOfStatusCode(e.response?.statusCode)
              : e.toString(),
        ),
      );
    }
  }
}