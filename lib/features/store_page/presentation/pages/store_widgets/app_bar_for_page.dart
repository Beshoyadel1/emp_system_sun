import 'package:emp_system_sun/features/notifications/presentation/pages/notification_popup/notification_popup.dart';
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
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AppBarForPage({
    super.key,
    required this.scaffoldKey,
  });

  @override
  State<AppBarForPage> createState() => _AppBarForPageState();
}

class _AppBarForPageState extends State<AppBarForPage> {
  final AppCubit _appCubit = getIt<AppCubit>();

  bool? _previousIsMobile;

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

  void _handleResponsiveMenu(bool isMobile) {
    if (_previousIsMobile == null) {
      _previousIsMobile = isMobile;
      return;
    }

    final wasMobile = _previousIsMobile!;

    // Mobile -> Desktop
    if (wasMobile && !isMobile) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        // Close mobile drawer
        if (widget.scaffoldKey.currentState?.isDrawerOpen ?? false) {
          widget.scaffoldKey.currentState?.closeDrawer();
        }

        // Show desktop menu
        _appCubit.showMenu();
      });
    }

    _previousIsMobile = isMobile;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final isMobile = width <= ValuesOfAllApp.mobileWidth;

    _handleResponsiveMenu(isMobile);

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
                iconData: isMobile
                    ? Icons.menu_outlined
                    : _appCubit.isMenuOpen
                    ? Icons.menu_outlined
                    : Icons.menu_open,
                iconColor: AppColors.darkColor,
                buttonColor: Colors.transparent,
                iconSize: 25,
                borderRadius: 7,
                onTap: () {
                  if (isMobile) {
                    widget.scaffoldKey.currentState?.openDrawer();
                    return;
                  }

                  _appCubit.toggleMenu();
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

              const NotificationPopup(),

              const SizedBox(width: 10),

              const ChangeLanguageButton(),
            ],
          ),
        );
      },
    );
  }
}