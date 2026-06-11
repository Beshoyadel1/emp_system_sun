import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../main.dart';
import '../../../../../core/cubit/app_cubit/app_cubit.dart';
import '../../../../../core/cubit/app_cubit/app_states.dart';
import '../../../../../core/pages_widgets/button_widget.dart';
import '../../../../../core/pages_widgets/general_widgets/change_language_button.dart';
import '../../../../../core/setup_git_it.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/utilies/map_of_all_app.dart';

class AppBarForPage extends StatefulWidget {
  const AppBarForPage({super.key});

  @override
  State<AppBarForPage> createState() => _AppBarForPageState();
}

class _AppBarForPageState extends State<AppBarForPage> {
  final AppCubit _appCubit = getIt<AppCubit>();

  String _getPageTitle() {
    final selectedIndex = _appCubit.selectedPageIndex;
    // Search main pages
    final page = appPages
        .where((e) => e.number == selectedIndex)
        .firstOrNull;

    if (page != null) {
      return page.name;
    }

    // Search children pages
    for (final parent in appPages) {
      final child = parent.children
          .where((e) => e.number == selectedIndex)
          .firstOrNull;

      if (child != null) {
        return child.name;
      }
    }

    return 'Page Not Found';
  }
  bool? _previousIsMobile;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width <= ValuesOfAllApp.mobileWidth;

    if (_previousIsMobile != null &&
        _previousIsMobile == true &&
        isMobile == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scaffoldKeyDrawer.currentState?.isDrawerOpen ?? false) {
          Navigator.of(context).pop();
        }
      });
    }

    _previousIsMobile = isMobile;

    return BlocBuilder<AppCubit, AppStates>(
      bloc: _appCubit,
      buildWhen: (previous, current) {
        return current is ChangeSelectedPageIndexState ||
            current is HideMenuState ||
            current is DropDownState;
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            border: Border(
              bottom: BorderSide(
                color: AppColors.scaffoldColor,
                width: 2,
              ),
            ),
          ),
          child: Row(
            children: [
              ButtonWidget(
                iconData: _appCubit.isMenuOpen
                    ? Icons.menu_outlined
                    : Icons.menu_open,
                iconColor: AppColors.darkColor,
                buttonColor: Colors.transparent,
                iconSize: 25,
                borderRadius: 7,
                onTap: () {
                  if (isMobile) {
                    scaffoldKeyDrawer.currentState?.openDrawer();
                  } else {
                    _appCubit.isMenuOpen = !_appCubit.isMenuOpen;
                    _appCubit.dropDown();
                  }
                },
              ),
              Expanded(
                child: Container(
                  height: 60,
                  alignment: AlignmentDirectional.centerStart,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextInAppWidget(
                    text: _getPageTitle(),
                    textSize: 20,
                    textColor: AppColors.darkColor,
                    fontWeightIndex:
                    FontSelectionData.mediumFontFamily,
                  ),
                ),
              ),

              const Icon(
                Icons.notifications,
                size: 40,
                color: AppColors.blackColor,
              ),

              const SizedBox(width: 10),

              const ChangeLanguageButton(),
            ],
          ),
        );
      },
    );
  }
}