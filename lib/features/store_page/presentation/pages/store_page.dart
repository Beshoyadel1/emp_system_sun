import 'package:emp_system_sun/features/notifications/presentation/pages/signalR_status_bar/signalR_status_bar.dart';
import 'package:emp_system_sun/features/service_emp_view/presentation/cubit/employee_services_cubit/employee_services_cubit.dart';
import 'package:emp_system_sun/features/service_emp_view/presentation/cubit/employee_services_cubit/employee_services_state.dart';
import 'package:emp_system_sun/features/store_page/presentation/pages/store_widgets/app_bar_for_page.dart';
import 'package:emp_system_sun/features/store_page/presentation/pages/store_widgets/dialog_for_back.dart';
import 'package:emp_system_sun/features/store_page/presentation/pages/store_widgets/pages_selection_bar.dart';
import 'package:emp_system_sun/features/store_page/presentation/pages/store_widgets/selected_screen_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/setup_git_it.dart';
import '../../../../../../core/cubit/app_cubit/app_cubit.dart';
import '../../../../../../core/cubit/app_cubit/app_states.dart';
import '../../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../../core/theming/colors.dart';

class StorePage extends StatefulWidget {
  const StorePage({
    super.key,
  });

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final GlobalKey<ScaffoldState> _scaffoldKeyDrawer =
  GlobalKey<ScaffoldState>();

  final AppCubit _appCubit =
  getIt<AppCubit>();

  final EmployeeServicesCubit
  _employeeServicesCubit =
  getIt<EmployeeServicesCubit>();

  bool _isLoadingPages = true;

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  Future<void> _initialize() async {

    await _employeeServicesCubit.getEmployeeServices();

    await _initializePages();
  }

  Future<void> _initializePages() async {
    await getPages(context);

    if (!mounted) return;

    if (appPages.isEmpty) {
      setState(() {
        _isLoadingPages = false;
      });

      return;
    }

    // ----------------------------------------------------------
    // FIND DASHBOARD
    // ----------------------------------------------------------

    final dashboardPages = appPages.where(
          (page) =>
      page.number ==
          PagesOfAllApp.dashboardPageNumber,
    );

    final selectedPage =
    dashboardPages.isNotEmpty
        ? dashboardPages.first
        : appPages.first;

    // ----------------------------------------------------------
    // SET SELECTED PAGE
    // ----------------------------------------------------------

    _appCubit.selectedPageFromOpenedPagesIndex =
        selectedPage.number;

    _appCubit.selectedPageIndex =
        selectedPage.number;

    if (!mounted) return;

    setState(() {
      _isLoadingPages = false;
    });
  }

  Future<void> _refreshPages() async {
    await getPages(context);

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.sizeOf(context).width;

    final isMobile =
        width <= ValuesOfAllApp.mobileWidth;

    // ==========================================================
    // LOADING
    // ==========================================================

    if (_isLoadingPages) {
      return const Scaffold(
        body: Center(
          child:
          CircularProgressIndicator(),
        ),
      );
    }

    // ==========================================================
    // NO PAGES
    // ==========================================================

    if (appPages.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            'No pages available',
          ),
        ),
      );
    }

    return BlocListener<
        EmployeeServicesCubit,
        EmployeeServicesState>(
      bloc: _employeeServicesCubit,

      listener: (
          context,
          state,
          ) {
        if (state
        is EmployeeServicesSuccess) {
          _refreshPages();
        }
      },

      child: PopScope(
        canPop: false,

        onPopInvokedWithResult: (
            bool didPop,
            Object? result,
            ) async {
          if (didPop) return;

          final shouldPop =
              await showBackDialog(
                context: context,
              ) ??
                  false;

          if (shouldPop &&
              context.mounted) {
            Navigator.of(context).pop();
          }
        },

        child: Scaffold(
          key: _scaffoldKeyDrawer,

          backgroundColor:
          AppColors.whiteGreyColor,

          // ====================================================
          // MOBILE DRAWER
          // ====================================================

          drawer: isMobile
              ? const Drawer(
            width: 256,
            child:
            PagesSelectionBar(),
          )
              : null,

          // ====================================================
          // BODY
          // ====================================================

          body: Row(
            children: [

              // ==================================================
              // DESKTOP SIDEBAR
              // ==================================================

              if (!isMobile)
                BlocBuilder<
                    AppCubit,
                    AppStates>(
                  bloc: _appCubit,

                  buildWhen: (
                      previous,
                      current,
                      ) {
                    return current
                    is HideMenuState;
                  },

                  builder: (
                      context,
                      state,
                      ) {
                    if (!_appCubit
                        .isMenuOpen) {
                      return const SizedBox.shrink();
                    }

                    return const PagesSelectionBar();
                  },
                ),

              // ==================================================
              // CONTENT
              // ==================================================

              Expanded(
                child: Column(
                  children: [

                    AppBarForPage(
                      scaffoldKey:
                      _scaffoldKeyDrawer,
                    ),

                    const Expanded(
                      child:
                      SelectedScreenWidget(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}