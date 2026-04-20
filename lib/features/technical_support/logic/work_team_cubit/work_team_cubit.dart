import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../../core/api_functions/chat/get_work_team_chat_model/get_work_team_chat_repository.dart';
import '../../../../../../../core/api_functions/chat/get_work_team_chat_model/get_work_team_chat_request.dart';
import '../../../../../../../core/api_functions/user/login_model/login_repository.dart';
import '../../../../../../../features/technical_support/logic/work_team_cubit/work_team_state.dart';

class WorkTeamCubit extends Cubit<WorkTeamState> {
  WorkTeamCubit() : super(WorkTeamInitial());

  Future<void> getTeam() async {
    emit(WorkTeamLoading());

    try {
      final user = await AuthLocalStorage.getUser();

      if (user == null) {
        emit(WorkTeamError("User not found"));
        return;
      }

      final data = await getWorkTeamChatFunction(
        request: GetWorkTeamChatRequest(
          user: user.userid??58,
          userType: UserType.providerUser,
        ),
      );

      emit(WorkTeamSuccess(data));

    } catch (e) {
      emit(WorkTeamError(e.toString()));
    }
  }
}