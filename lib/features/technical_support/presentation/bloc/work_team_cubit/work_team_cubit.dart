import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/features/auth_page/data/datasource/login_datasource/login_repository.dart';
import 'package:emp_system_sun/features/technical_support/presentation/bloc/work_team_cubit/work_team_state.dart';

import '../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../data/datasource/get_work_team_chat_datasource/get_work_team_chat_repository.dart';
import '../../../data/request/get_work_team_chat_request/get_work_team_chat_request.dart';

class WorkTeamCubit extends Cubit<WorkTeamState> {
  WorkTeamCubit() : super(WorkTeamInitial());

  void safeEmit(WorkTeamState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  Future<void> getTeam() async {
    if (isClosed) return;

    safeEmit(WorkTeamLoading());

    try {
      final user = await AuthLocalStorage.getUser();

      if (isClosed) return;

      if (user == null) {
        safeEmit(WorkTeamError("User not found"));
        return;
      }

      final data = await getWorkTeamChatFunction(
        request: GetWorkTeamChatRequest(
          user: user.userid ?? 58,
          userType: UserType.providerUser,
        ),
      );

      if (isClosed) return;

      safeEmit(WorkTeamSuccess(data));
    } catch (e) {
      if (isClosed) return;

      safeEmit(WorkTeamError(e.toString()));
    }
  }
}