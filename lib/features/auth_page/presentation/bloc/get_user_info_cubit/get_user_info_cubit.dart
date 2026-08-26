import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/datasource/get_user_info_datasource/get_user_info_datasource.dart';
import '../../../../../../../features/auth_page/data/model/create_user_model/create_user_request.dart';
import '../../../../../../../features/auth_page/data/request/get_user_inf_request/get_user_info_datasource.dart';
import 'get_user_info_state.dart';


class GetUserInfoCubit extends Cubit<GetUserInfoState> {
  GetUserInfoCubit() : super(GetUserInfoInitial());

  CreateUserRequest? user;

  Future<void> getUserInfo({
    required GetUserInfoRequest request,
  }) async {
    emit(GetUserInfoLoading());

    try {
      user = await getUserInfoFunction(
        request: request,
      );

      emit(
        GetUserInfoSuccess(
          user: user!,
        ),
      );
    } catch (e) {
      emit(
        GetUserInfoError(
          message: e.toString(),
        ),
      );
    }
  }
}