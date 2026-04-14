import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../features/technical_support/logic/work_team_cubit/work_team_cubit.dart';
import '../../../../../features/technical_support/logic/work_team_cubit/work_team_state.dart';

class TitleWithNumberMembersAdminSun extends StatelessWidget {
  const TitleWithNumberMembersAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        const TextInAppWidget(
          text: AppLanguageKeys.teamMembers,
          textSize: 18,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor: AppColors.blackColor,
        ),

        Row(
          spacing: 20,
          children: [
            const Flexible(
              child: TextInAppWidget(
                text: AppLanguageKeys.membersCount,
                textSize: 15,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor: AppColors.blackColor,
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: const BoxDecoration(
                color: AppColors.greyColor200,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: BlocBuilder<WorkTeamCubit, WorkTeamState>(
                builder: (context, state) {
                  if (state is WorkTeamLoading) {
                    return const CupertinoActivityIndicator();
                  }
                  if (state is WorkTeamError) {
                    return const SizedBox();
                  }
                  if (state is WorkTeamSuccess) {
                    return TextInAppWidget(
                      text: state.users.length.toString(),
                      textSize: 12,
                      fontWeightIndex: FontSelectionData.regularFontFamily,
                      textColor: AppColors.blackColor,
                    );
                  }
                  return const SizedBox();
                },
              ),
            )
          ],
        )
      ],
    );
  }
}