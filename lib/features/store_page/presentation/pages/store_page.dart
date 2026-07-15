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
import '../../../../../../main.dart';
import '../../../../../../../core/general_models/pages_model.dart';


class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    super.initState();
    getPages(context);
    getIt<EmployeeServicesCubit>().getEmployeeServices();

    final facilityAccountPage = appPages.firstWhere(
          (e) => e.number == PagesOfAllApp.dashboardPageNumber,
    );

    final facilityAccountWithID = PageNodeWithIDModel(
      id: facilityAccountPage.number,
      name: facilityAccountPage.name,
      number: facilityAccountPage.number,
      page: facilityAccountPage.page,
    );

    _appCubit.selectedPageFromOpenedPagesIndex =
        facilityAccountWithID.id;
    _appCubit.selectedPageIndex =
        facilityAccountWithID.id;
  }

  final AppCubit _appCubit = getIt<AppCubit>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;
    return BlocListener<EmployeeServicesCubit, EmployeeServicesState>(
        bloc: getIt<EmployeeServicesCubit>(),
        listener: (context, state) {
          if (state is EmployeeServicesSuccess) {
            getPages(context);
            print("AFTER SUCCESS => ${appPages.length}");
            print("SERVICES => ${getIt<EmployeeServicesCubit>().services.length}");
            setState(() {});
          }
        },
      child: PopScope(
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
          //bottomNavigationBar: const SignalRStatusBar(),
        ),
      ),
      );

  }
}
