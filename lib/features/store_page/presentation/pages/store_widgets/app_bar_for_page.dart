import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cubit/app_cubit/app_cubit.dart';
import '../../../../../core/cubit/app_cubit/app_states.dart';
import '../../../../../core/pages_widgets/general_widgets/change_language_button.dart';
import '../../../../../core/setup_git_it.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/language/language_constant.dart';

class AppBarForPage extends StatefulWidget {
  const AppBarForPage({super.key});

  @override
  State<AppBarForPage> createState() => _AppBarForPageState();
}

class _AppBarForPageState extends State<AppBarForPage> {
  final AppCubit _appCubit = getIt<AppCubit>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;
    return BlocBuilder<AppCubit, AppStates>(buildWhen: (previous, current) {
      return current is ChangeSelectedPageIndexState ||
          current is HideMenuState;
    }, builder: (context, AppStates state) {
      return Container(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          border: Border(
            bottom: BorderSide(color: AppColors.scaffoldColor, width: 2),
          ),
        ),
        child: Row(
          spacing: 10,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                alignment: AlignmentDirectional.centerStart,
                width: double.infinity,
                height: 60,
                child: const TextInAppWidget(
                  text: AppLanguageKeys.facilityManagementKey,
                  textSize: 20,
                  textColor: AppColors.darkColor,
                  fontWeightIndex: FontSelectionData.mediumFontFamily,
                ),
              ),
            ),
            Image.asset(
              AppImageKeys.notification,
              width: 40,
              height: 40,
            ),
            Image.asset(
              AppImageKeys.profileImage,
              width: 50,
              height: 48,
            ),
            const ChangeLanguageButton()
          ],
        ),
      );
    });
  }
}
