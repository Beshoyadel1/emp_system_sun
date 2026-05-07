import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/language/language_cubit/language_cubit.dart';
import '../../../core/cubit/app_cubit/app_cubit.dart';
import '../../../core/theming/colors.dart';
import '../button_widget.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      iconData: Icons.language,
      iconColor: AppColors.darkColor,
      buttonColor: Colors.transparent,
      iconSize: 25,
      borderRadius: 7,
        onTap: () {
          final cubit = context.read<LanguageCubit>();

          cubit.changeAllAppLanguage(
            cubit.isAllAppLanguageArabic ? 2 : 1,
          );
        }
    );
  }
}
