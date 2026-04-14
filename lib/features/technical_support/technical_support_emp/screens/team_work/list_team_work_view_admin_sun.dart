import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/technical_support/custom_widget/row_member_team_work_widget.dart';
import '../../../../../features/technical_support/logic/work_team_cubit/work_team_cubit.dart';
import '../../../../../features/technical_support/logic/work_team_cubit/work_team_state.dart';

class ListTeamWorkViewAdminSun extends StatelessWidget {
  const ListTeamWorkViewAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkTeamCubit, WorkTeamState>(
      builder: (context, state) {

        if (state is WorkTeamLoading) {
          return const SizedBox(
            height: 300,
            child: Center(child: CupertinoActivityIndicator()),
          );
        }

        if (state is WorkTeamError) {
          return SizedBox(
            height: 300,
            child: Center(child: Text(state.message)),
          );
        }

        if (state is WorkTeamSuccess) {
          final users = state.users;

          if (users.isEmpty) {
            return const SizedBox(
              height: 300,
              child: Center(child: Text("No team members")),
            );
          }

          return SizedBox(
            height: 300,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: users.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final user = users[index];

                return RowMemberTeamWorkWidget(
                  imageBytes:user.image,
                  subTitle: user.getJobName(context).isNotEmpty
                      ? user.getJobName(context)
                      : "User@gmail.com",
                  title: user.getName(context).isNotEmpty
                      ? user.getName(context)
                      : "User",
                );
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}