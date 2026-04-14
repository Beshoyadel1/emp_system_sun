import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/technical_support/logic/work_team_cubit/work_team_cubit.dart';
import '../../../../../features/technical_support/technical_support_emp/screens/team_work/list_team_work_view_admin_sun.dart';
import '../../../../../features/technical_support/technical_support_emp/screens/team_work/title_with_number_members_admin_sun.dart';

class ListDataContainerDesignTeamWorkAdminSun extends StatelessWidget {
  const ListDataContainerDesignTeamWorkAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WorkTeamCubit()..getTeam(),
      child: const Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWithNumberMembersAdminSun(),
          ListTeamWorkViewAdminSun(),
        ],
      ),
    );
  }
}
