import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/api_functions/harage/get_all_harage_model/get_all_harage_repository.dart';
import '../../../../core/api_functions/harage/get_all_harage_model/get_all_harage_request.dart';
import 'get_all_harage_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/api_functions/harage/get_all_harage_model/get_all_harage_repository.dart';
import '../../../../core/api_functions/harage/get_all_harage_model/get_all_harage_request.dart';
import 'get_all_harage_state.dart';

class GetAllHarageCubit extends Cubit<GetAllHarageState> {
  GetAllHarageCubit() : super(GetAllHarageInitial());

  Future<void> getAllHarage({int page = 1}) async {

    if (isClosed) return;

    emit(GetAllHarageLoading());

    try {
      final request = GetAllHarageRequest(
        pageNumber: page,
      );

      final result = await getAllHarageFunction(
        getAllHarageRequest: request,
      );

      if (isClosed) return;

      final currentPage = result.currentPage ?? page;
      final pageCount = result.pageCount ?? 1;
      final totalCount = result.totalCount ?? 0;

      emit(
        GetAllHarageSuccess(
          response: result,
          currentPage: currentPage,
          pageCount: pageCount,
          totalCount: totalCount,
        ),
      );

    } catch (e) {

      // 🔥 لازم check هنا برضه
      if (isClosed) return;

      emit(GetAllHarageError(e.toString()));
    }
  }
}