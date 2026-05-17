import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/cubit/app_cubit/app_cubit.dart';
import '../../../../../../core/cubit/app_cubit/app_states.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/theming/colors.dart';

class FreeTrialWidget extends StatelessWidget {
  const FreeTrialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      buildWhen: (previous, current) => current is ChangeAllAppLanguageState,
      builder: (BuildContext context, AppStates state) {
        return InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {},
          child: SizedBox(
            width: context.read<AppCubit>().isAllAppLanguageArabic ? 150 : 100,
            child: const Column(
              children: [
                TextInAppWidget(
                  text: AppLanguageKeys.freeTrialKey,
                  textSize: 20,
                  fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                  textColor: AppColors.scaffoldColor,
                ),
                Divider(
                  color: AppColors.scaffoldColor,
                  thickness: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
