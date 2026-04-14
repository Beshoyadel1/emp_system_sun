import '../../../../../../../core/api_functions/chat/get_work_team_chat_model/work_team_user_model.dart';

abstract class WorkTeamState {}

class WorkTeamInitial extends WorkTeamState {}

class WorkTeamLoading extends WorkTeamState {}

class WorkTeamSuccess extends WorkTeamState {
  final List<WorkTeamUserModel> users;

  WorkTeamSuccess(this.users);
}

class WorkTeamError extends WorkTeamState {
  final String message;

  WorkTeamError(this.message);
}

