import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/cubit/app_cubit/app_cubit.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/pages_widgets/button_widget.dart';

class LoginLanguageButtonWidget extends StatelessWidget {
  const LoginLanguageButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 45,
      child: ButtonWidget(
        text: AppLanguageKeys.languageKey,
        textSize: 17,
        textColor: AppColors.orangeColor,
        fontWeightIndex: FontSelectionData.semiBoldFontFamily,
        borderRadius: 25,
        onTap: () {
          context.read<AppCubit>().changeAllAppLanguage(
              context.read<AppCubit>().isAllAppLanguageArabic ? 2 : 1);
        },
      ),
    );
  }
}
