import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/setup_git_it.dart';
import '../../../../core/cubit/app_cubit/app_cubit.dart';
import '../../../../core/cubit/app_cubit/app_states.dart';
import '../../../../core/utilies/map_of_all_app.dart';
import '../../../../core/theming/colors.dart';
import '../../../../main.dart';
import '../../../../../core/general_models/pages_model.dart';
import 'store_widgets/app_bar_for_page.dart';
import 'store_widgets/dialog_for_back.dart';
import 'store_widgets/pages_selection_bar.dart';
import 'store_widgets/selected_screen_widget.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    super.initState();
    getPages();
    final facilityAccountPage = appPages.firstWhere(
      (e) => e.number == PagesOfAllApp.dashboardPageNumber,
    );
    final facilityAccountWithID = PageNodeWithIDModel(
      id: facilityAccountPage.number,
      name: facilityAccountPage.name,
      number: facilityAccountPage.number,
      page: facilityAccountPage.page,
    );
    _appCubit.selectedPageFromOpenedPagesIndex = facilityAccountWithID.id;
    _appCubit.selectedPageIndex = facilityAccountWithID.id;
  }

  final AppCubit _appCubit = getIt<AppCubit>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showBackDialog(context: context) ?? false;
        if (shouldPop) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteGreyColor,
        key: scaffoldKeyDrawer,
        drawer: const Drawer(width: 256, child: PagesSelectionBar()),
        body: Row(
          children: [
            if (!isMobile)
              BlocBuilder<AppCubit, AppStates>(
                buildWhen: (previous, current) {
                  return current is HideMenuState;
                },
                builder: (BuildContext context, AppStates state) {
                  return !_appCubit.isMenuOpen
                      ? const SizedBox()
                      : const PagesSelectionBar();
                },
              ),
            const Expanded(
              child: Column(
                children: [
                  AppBarForPage(),
                  SelectedScreenWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
