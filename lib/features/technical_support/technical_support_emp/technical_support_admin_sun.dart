import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../features/technical_support/logic/chat_details_cubit/chat_details_cubit.dart';
import '../../../../../../../features/technical_support/logic/message_cubit/message_cubit.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../features/technical_support/technical_support_emp/screens/chat/chat_in_technical_support_emp_admin_sun.dart';
import 'screens/message/list_data_technical_support_admin_sun.dart';
import '../../../../../features/technical_support/technical_support_emp/screens/team_work/container_design_team_work_admin_sun.dart';
import '../../../../../core/theming/colors.dart';

class TechnicalSupportAdminSun extends StatelessWidget {
  const TechnicalSupportAdminSun({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MessageCubit()..getMessages()),
        BlocProvider(create: (_) => ChatDetailsCubit()),
      ],
      child: Scaffold(
          backgroundColor: AppColors.scaffoldColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: CustomContainer(
                  isSelected: false,
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12),
                  typeWidget: const Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 350,
                        //height: 600,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: SingleChildScrollView(
                            child: ListDataTechnicalSupportAdminSun(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        height: 600,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: ChatInTechnicalSupportEmpAdminSun(),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                       // height: 600,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: SingleChildScrollView(
                              child: ContainerDesignTeamWorkAdminSun()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          )),
    );
  }
}