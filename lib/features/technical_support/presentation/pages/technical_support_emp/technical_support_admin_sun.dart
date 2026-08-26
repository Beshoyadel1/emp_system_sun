import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/technical_support/presentation/bloc/chat_details_cubit/chat_details_cubit.dart';
import '../../../../../features/technical_support/presentation/bloc/message_cubit/message_cubit.dart';
import '../../../../../features/technical_support/presentation/pages/technical_support_emp/screens/chat/chat_in_technical_support_emp_admin_sun.dart';
import '../../../../../features/technical_support/presentation/pages/technical_support_emp/screens/team_work/container_design_team_work_admin_sun.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import 'screens/message/list_data_technical_support_admin_sun.dart';
import '../../../../../core/theming/colors.dart';

class TechnicalSupportAdminSun extends StatelessWidget {
  const TechnicalSupportAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MessageCubit()..getMessages(),
        ),
        BlocProvider(
          create: (_) => ChatDetailsCubit(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              final double horizontalPadding = width < 600 ? 10 : 20;

              // Same card height for all cards
              final double cardHeight = width < 600
                  ? 550
                  : width < 1000
                  ? 600
                  : 650;

              int columns;

              if (width >= 900) {
                columns = 3;
              } else if (width >= 600) {
                columns = 2;
              } else {
                columns = 1;
              }

              return SingleChildScrollView(
                padding: EdgeInsets.all(horizontalPadding),
                child: CustomContainer(
                  isSelected: false,
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12),
                  typeWidget: LayoutBuilder(
                    builder: (context, innerConstraints) {
                      final spacing = width < 600 ? 10.0 : 15.0;

                      final cardWidth = columns == 1
                          ? innerConstraints.maxWidth
                          : (innerConstraints.maxWidth -
                          ((columns - 1) * spacing)) /
                          columns;

                      return Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: [
                          SizedBox(
                            width: cardWidth,
                            height: cardHeight,
                            child: const ListDataTechnicalSupportAdminSun(),
                          ),

                          SizedBox(
                            width: cardWidth,
                            height: cardHeight,
                            child: const ChatInTechnicalSupportEmpAdminSun(),
                          ),

                          SizedBox(
                            width: cardWidth,
                            height: cardHeight,
                            child: const ContainerDesignTeamWorkAdminSun(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}