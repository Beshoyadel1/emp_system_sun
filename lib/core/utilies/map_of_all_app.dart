import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:emp_system_sun/core/setup_git_it.dart';
import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:emp_system_sun/features/cars_haraj_page/presentation/ui/car_haraj_orders_page/car_haraj_orders_page.dart';
import 'package:emp_system_sun/features/communication_and_policies_pages/presentation/pages/first_screen_communication_and_policies_pages/first_screen_communication_and_policies_pages.dart';
import 'package:emp_system_sun/features/dashboard_page/presentation/dashboard_page.dart';
import 'package:emp_system_sun/features/internal_services/presentation/pages/internal_orders/first_screen_internal_orders/first_screen_internal_orders.dart';
import 'package:emp_system_sun/features/internal_services/presentation/pages/internal_services_statistics/Internal_services_page/ui/internal_orders_page.dart';
import 'package:emp_system_sun/features/logout_dashboard/presentation/first_screen_logout_dashboard/logout_dashboard.dart';
import 'package:emp_system_sun/features/mobile_services/presentation/pages/mobile_services_orders/first_screen_mobile_services_orders/first_screen_mobile_services_orders.dart';
import 'package:emp_system_sun/features/mobile_services/presentation/pages/mobile_services_statistics/mobile_services_page/ui/mobile_services_statistics_page.dart';
import 'package:emp_system_sun/features/order_services/presentation/pages/order_services_type/ui/order_services_type_page.dart';
import 'package:emp_system_sun/features/permissions/presentation/pages/first_screen_permissions/first_screen_permissions.dart';
import 'package:emp_system_sun/features/service_emp_view/data/model/get_employee_services_model/employee_service_model.dart';
import 'package:emp_system_sun/features/service_emp_view/presentation/cubit/employee_services_cubit/employee_services_cubit.dart';
import 'package:emp_system_sun/features/service_emp_view/presentation/pages/service_emp_view_orders/service_emp_view_orders_page/ui/service_emp_view_orders_page.dart';
import 'package:emp_system_sun/features/spare_parts/presentation/pages/spare_parts_orders/first_screen_spare_parts_orders/first_screen_spare_parts_orders.dart';
import 'package:emp_system_sun/features/spare_parts/presentation/pages/spare_parts_statistics/spare_parts_page/ui/spare_parts_statistics_page.dart';
import 'package:emp_system_sun/features/store_page/presentation/pages/store_widgets/facility_account/facility_account.dart';
import 'package:emp_system_sun/features/technical_support/presentation/pages/technical_support_emp/technical_support_admin_sun.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/general_models/pages_model.dart';
import '../../../core/language/language_constant.dart';
import '../../../core/theming/assets.dart';

class AppStatesApi {
  static const String phoneExist = 'PhoneExist';
  static const String emailExist = 'EmailExist';
  static const String done = 'Done';
  static const String noUser = 'No User';
  static const String notActive = 'not active';
  static const String wrongPassword = 'Wrong Password';
  static const String reservedUser = 'Reserved';
  static const String haveOperationForDelete = 'HaveOperation';
  static const String notFound = 'not found';
  static const String sameUser = 'same user';
  static const String notEnoughSMAT = 'not enough SMAT';
}

class ValuesOfAllApp {
  static const int mobileWidth = 900;
  static const int tabWidth = 1250;
  static const int customTabWidth = 1050;
  static const int balanceRadioIndex = 1;
  static const int smatRadioIndex = 2;
  static const int subscriptionEliteButtonIndex = 1;
  static const String version = '2.0.0';
}

class PagesOfAllApp {
  static const String dashboardPage = 'Dashboard_Page';
  static const int dashboardPageNumber = 1;

  static const String securityPage = 'Security_Page';
  static const int securityPageNumber = 2;

  static const String permissionsGroupPage = 'Permissions_Group_Page';
  static const int permissionsGroupPageNumber = 201;

  static const String usersPermissionsPage = 'Users_Permissions_Page';
  static const int usersPermissionsPageNumber = 202;

  static const String userStatisticsPage = 'User_Statistics_Page';
  static const int userStatisticsPageNumber = 203;

  static const String settingsPage = 'Settings_Page';
  static const int settingsPageNumber = 3;

  static const String companiesPage = 'Companies_Page';
  static const int companiesPageNumber = 301;

  static const String generalSettingsPage = 'General_Settings_Page';
  static const int generalSettingsPageNumber = 302;

  static const String branchesPage = 'Branches_Page';
  static const int branchesPageNumber = 303;

  static const String inventoriesPage = 'Inventories_Page';
  static const int inventoriesPageNumber = 304;

  static const String banksPage = 'Banks_Page';
  static const int banksPageNumber = 305;

  static const String areasPage = 'Areas_Page';
  static const int areasPageNumber = 306;

  static const String taxesPage = 'Taxes_Page';
  static const int taxesPageNumber = 307;

  static const String financialPeriodPage = 'Financial_Period_Page';
  static const int financialPeriodPageNumber = 308;

  static const String costCenterPage = 'Cost_Center_Page';
  static const int costCenterPageNumber = 309;

  static const String currenciesPage = 'Currencies_Page';
  static const int currenciesPageNumber = 310;

  static const String categoriesPage = 'Categories_Page';
  static const int categoriesPageNumber = 311;

  static const String facilityManagementPage = 'Facility_Management_Page';
  static const int facilityManagementPageNumber = 312;

  static const String facilityAccountPage = 'Facility_Account_Page';
  static const int facilityAccountPageNumber = 313;

  static const String carModelsPage = 'Car_Models_Page';
  static const int carModelsPageNumber = 314;

  static const String InternalServices = 'Service_Settings_Page';
  static const int internalServicesPageNumber = 315;

  static const String sparePage = 'Spare_Page';
  static const int sparePageNumber = 316;

  static const String walletPage = 'Security_Page';
  static const int walletPageNumber = 317;

  static const String usersPage = 'Security_Page';
  static const int usersPageNumber = 318;

  static const String notificationPage = 'Security_Page';
  static const int notificationPageNumber = 319;

  static const String bannerPage = 'Security_Page';
  static const int bannerPageNumber = 320;

  static const String starPage = 'Security_Page';
  static const int starPageNumber = 321;

  static const String pagesPage = 'Security_Page';
  static const int pagesPageNumber = 322;

  static const String logoutPage = 'Security_Page';
  static const int logoutPageNumber = 323;

  static const String carPage = 'Security_Page';
  static const int carPageNumber = 324;

  static const String internalServicesStatisticsPage = 'Security_Page';
  static const int internalServicesStatisticsPageNumber = 4;

  static const String carsHarajStatisticsPage = 'Security_Page';
  static const int carsHarajStatisticsPageNumber = 6;

  static const String internalOrdersPage = 'Security_Page';
  static const int internalOrdersPageNumber = 5;

  static const String carHarajOrdersPage = 'Security_Page';
  static const int carHarajOrdersPageNumber = 7;

  //-----------------------------------------------------------------
  static const String permissionsPage = 'Permissions_Page';
  static const int permissionsPageNumber = 500;

  static const String advertisementsPage = 'Advertisements_Page';
  static const int advertisementsPageNumber = 501;

  static const String petroleumPage = 'Petroleum_Page';
  static const int petroleumPageNumber = 502;
  static const String ordersPetroleumPage = 'Orders_Petroleum_Page';
  static const int ordersPetroleumPageNumber = 503;
  static const String oilProductsPetroleumPage = 'Oil_Products_Petroleum_Page';
  static const int oilProductsPetroleumPageNumber = 504;
  static const String facilityManagementPetroleumPage =
      'Facility_Management_Petroleum_Page';
  static const int facilityManagementPetroleumPageNumber = 505;
  static const String statisticsPetroleumPage = 'Statistics_Petroleum_Page';
  static const int statisticsPetroleumPageNumber = 506;

  static const String serviceSettingsPage = 'Service_Settings_Page';
  static const int serviceSettingsPageNumber = 507;
  static const String maintenanceAndInteriorServicesPage =
      'Maintenance_And_Interior_Services_Page';
  static const int maintenanceAndInteriorServicesPageNumber = 508;
  static const String carPartsPage = 'Car_Parts_Page';
  static const int carPartsPageNumber = 509;
  static const String sharedPackagesPage = 'Shared_Packages_Page';
  static const int sharedPackagesPageNumber = 510;
  static const String mobileServicesAndTransportationPage =
      'Mobile_Services_and_Transportation_Page';
  static const int mobileServicesAndTransportationPageNumber = 511;

  static const String sparePartsPage = 'spare_Parts_Page_Number_Page';
  static const int sparePartsPageNumber = 512;
  static const String sparePartsOrdersPage =
      'spare_Parts_orders_Page_Number_Page';
  static const int sparePartsOrdersPageNumber = 513;

  static const String sparePartsStaticsPage =
      'spare_parts_statics_page_number_page';
  static const int sparePartsStaticsPageNumber = 514;

  static const int mobileServicePageNumber = 515;
  static const int mobileServiceOrdersPageNumber = 516;
  static const int mobileServiceStaticsPageNumber = 517;

  static const int orderDetailsOnTheWayEmpPageNumber = 518;
  static const int orderDetailsOrderReceivedEmpPageNumber = 519;
  static const int orderDetailsNewOrderEmpPageNumber = 520;
  static const int orderDetailsUnderServiceEmpPageNumber = 521;
  static const String petrolInServiceSettingPage =
      'Petrol_In_Service_Setting_Page';
  static const int petrolInServiceSettingPageNumber = 522;

  static const int usersPermissionsPageNumber1 = 523;
  static const int firstScreenCarModelSettings = 524;
  static const int serviceSettingsCarModel = 525;
  static const int carAddScreenInCarModelSettings = 526;
  static const int walletPageNumber2 = 527;
  static const int amountPageNumber = 528;
  static const int technicalSupportPageNumber = 529;
  static const int amountPageNumber2 = 530;

  static const int oilChangeServicePageNumber = 531;
  static const int oilChangeServiceOrdersPageNumber = 532;
  static const int oilChangeServiceStaticsPageNumber = 533;

}

List<PageNodeModel> appPages = [];

Future<void> getPages(BuildContext context) async {
  appPages.clear();

  final user = await AuthLocalStorage.getUser();

  final employee = user?.employeeDetails;

  // ============================================================
  // NO EMPLOYEE DETAILS
  // ============================================================

  if (employee == null) {
    appPages = await _getAllEmployeePages(context);
    return;
  }

  final permissions = employee.permissions;

  // ============================================================
  // CHECK PERMISSIONS
  // ============================================================

  final allPermissionsAreNull =
      permissions == null ||
          (
              permissions.acceptAllOrders == null &&
                  permissions.changeOrderStatus == null &&
                  permissions.harage == null &&
                  permissions.maintenanceAndInternalServices == null &&
                  permissions.mobileServices == null &&
                  permissions.spareParts == null &&
                  permissions.servicePackage == null &&
                  permissions.petrol == null
          );

  // ============================================================
  // NO PERMISSION CONFIGURATION
  // ============================================================

  if (allPermissionsAreNull) {
    appPages = await _getAllEmployeePages(context);
    return;
  }

  bool hasPermission(bool? permission) {
    return permission == true;
  }

  // ============================================================
  // GET CURRENT SERVICES FROM CUBIT
  // ============================================================

  final employeeServicesCubit =
  getIt<EmployeeServicesCubit>();


  final services = employeeServicesCubit.services;


  // ============================================================
  // FILTER SERVICES
  // ============================================================

  final employeeServices = services.where((service) {
    final serviceId = service.id;

    final exists =
        serviceId != null &&
            employee.serviceIds.contains(serviceId);

    return exists;
  }).toList();


  // ============================================================
  // BUILD PAGES
  // ============================================================

  appPages = [

    // ==========================================================
    // MAINTENANCE & INTERNAL SERVICES
    // ==========================================================

    if (hasPermission(
      permissions.maintenanceAndInternalServices,
    ))
      const PageNodeModel(
        name:
        AppLanguageKeys.maintenanceAndInternalServicesKey,
        image: AppImageKeys.carServices,
        number:
        PagesOfAllApp.internalServicesPageNumber,
        page: OrderServicesTypePage(
          serviceId:
          MainCategoryConstants
              .maintenanceAndInternalServicesID,
        ),
      ),

    // ==========================================================
    // SPARE PARTS
    // ==========================================================

    if (hasPermission(permissions.spareParts))
      const PageNodeModel(
        name: AppLanguageKeys.spareParts,
        image: AppImageKeys.spare,
        number: PagesOfAllApp.sparePageNumber,
        page: OrderServicesTypePage(
          serviceId:
          MainCategoryConstants.carSparePartsID,
        ),
      ),

    // ==========================================================
    // MOBILE SERVICES
    // ==========================================================

    if (hasPermission(permissions.mobileServices))
      const PageNodeModel(
        name: AppLanguageKeys.mobileServices,
        image: AppImageKeys.mobile_maintenance,
        number:
        PagesOfAllApp.mobileServicePageNumber,
        page: OrderServicesTypePage(
          serviceId:
          MainCategoryConstants
              .mobileServicesAndTransportationID,
        ),
      ),

    // ==========================================================
    // PETROL
    // ==========================================================

    if (hasPermission(permissions.petrol))
      const PageNodeModel(
        name: AppLanguageKeys.petroleum,
        image: AppImageKeys.petrol,
        number: PagesOfAllApp.petroleumPageNumber,
        page: OrderServicesTypePage(
          serviceId:
          MainCategoryConstants.petrolMainID,
        ),
      ),

    // ==========================================================
    // HARAJ
    // ==========================================================

    if (hasPermission(permissions.harage))
      const PageNodeModel(
        name: AppLanguageKeys.harage,
        image: AppImageKeys.car,
        number:
        PagesOfAllApp.carHarajOrdersPageNumber,
        page: CarHarajOrdersPage(),
      ),

    // ==========================================================
    // PERSONAL DATA
    // ==========================================================

    const PageNodeModel(
      name: AppLanguageKeys.personalData,
      image: AppImageKeys.store,
      number: PagesOfAllApp.securityPageNumber,
      page: FacilityAccount(),
    ),

    // ==========================================================
    // EMPLOYEE SERVICES
    // ==========================================================

    if (employeeServices.isNotEmpty)
      PageNodeModel(
        name: AppLanguageKeys.services,
        image: AppImageKeys.userPermissions,
        number:
        PagesOfAllApp.permissionsPageNumber,

        children: employeeServices.map(
              (service) {
            return PageNodeModel(
              name: service.getName(context),

              number:
              (service.id ?? 0) + 100,

              page: ServiceEmpViewOrdersPage(
                key: ValueKey(
                  'order_${service.id}',
                ),
                serviceId:
                service.id ?? 0,
              ),
            );
          },
        ).toList(),
      ),

    // ==========================================================
    // TECHNICAL SUPPORT
    // ==========================================================

    const PageNodeModel(
      name: AppLanguageKeys.technicalSupport,
      image: AppImageKeys.users,
      number:
      PagesOfAllApp.technicalSupportPageNumber,
      page: TechnicalSupportAdminSun(),
    ),

    // ==========================================================
    // SOCIAL PAGES
    // ==========================================================

    const PageNodeModel(
      name:
      AppLanguageKeys.socialPagesAndPoliciesKey,
      image: AppImageKeys.pages,
      number: PagesOfAllApp.pagesPageNumber,
      page:
      FirstScreenCommunicationAndPoliciesPages(),
    ),

    // ==========================================================
    // LOGOUT
    // ==========================================================

    const PageNodeModel(
      name: AppLanguageKeys.logoutKey,
      image: AppImageKeys.logout,
      number: PagesOfAllApp.logoutPageNumber,
      page: LogoutDashboard(),
    ),
  ];

  print(
    'TOTAL APP PAGES: ${appPages.length}',
  );
}

Future<List<PageNodeModel>> _getAllEmployeePages(
    BuildContext context,
    ) async {
  return [
    const PageNodeModel(
      name: AppLanguageKeys.personalData,
      image: AppImageKeys.store,
      number: PagesOfAllApp.securityPageNumber,
      page: FacilityAccount(),
    ),

    const PageNodeModel(
      name: AppLanguageKeys.technicalSupport,
      image: AppImageKeys.users,
      number:
      PagesOfAllApp.technicalSupportPageNumber,
      page: TechnicalSupportAdminSun(),
    ),

    const PageNodeModel(
      name:
      AppLanguageKeys.socialPagesAndPoliciesKey,
      image: AppImageKeys.pages,
      number: PagesOfAllApp.pagesPageNumber,
      page:
      FirstScreenCommunicationAndPoliciesPages(),
    ),

    const PageNodeModel(
      name: AppLanguageKeys.logoutKey,
      image: AppImageKeys.logout,
      number: PagesOfAllApp.logoutPageNumber,
      page: LogoutDashboard(),
    ),
  ];
}