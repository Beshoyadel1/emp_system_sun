import '../../../features/accounts_management/first_screen_accounts_management_admin_sun/first_screen_accounts_management_admin_sun.dart';
import '../../../features/accounts_management/list_payment_view/list_payment_view.dart';
import '../../../features/internal_services/internal_services_statistics/Internal_services_page/ui/internal_orders_page.dart';
import '../../../features/mobile_services/mobile_services_orders/first_screen_mobile_services_orders/first_screen_mobile_services_orders.dart';
import '../../../features/mobile_services/mobile_services_statistics/spare_parts_page/ui/mobile_services_statistics_page.dart';
import '../../../features/spare_parts/spare_parts_orders/first_screen_spare_parts_orders/first_screen_spare_parts_orders.dart';
import '../../../features/spare_parts/spare_parts_statistics/spare_parts_page/ui/spare_parts_statistics_page.dart';
import '../../../features/store_page/store_widgets/facility_account/facility_account.dart';
import '../../../features/technical_support/technical_support_emp/technical_support_admin_sun.dart';
import '../../../core/general_models/pages_model.dart';
import '../../../features/cars_haraj_page/ui/car_haraj_orders_page.dart';
import '../../../features/cars_haraj_page/ui/cars_haraj_statistics_page.dart';
import '../../../features/communication_and_policies_pages/first_screen_communication_and_policies_pages/first_screen_communication_and_policies_pages.dart';
import '../../../features/dashboard_page/dashboard_page.dart';
import '../../../features/internal_services/internal_orders/first_screen_internal_orders/first_screen_internal_orders.dart';
import '../../../features/logout_dashboard/first_screen_logout_dashboard/logout_dashboard.dart';
import '../../../core/language/language_constant.dart';
import '../../../core/theming/assets.dart';
import '../../../features/permissions/first_screen_permissions/first_screen_permissions.dart';

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
/*
  * PageNodeModel(
            name: AppLanguageKeys.carModelsTitleKey,
            number: PagesOfAllApp.usersPermissionsPageNumber1,
            children: [
              PageNodeModel(
                name: AppLanguageKeys.firstScreenCarModelSettings,
                number: PagesOfAllApp.usersPermissionsPageNumber,
                page: FirstScreenCarModelSettings(),
              ),
              PageNodeModel(
                name: AppLanguageKeys.serviceSettingsCarModel,
                number: PagesOfAllApp.usersPermissionsPageNumber,
                page: ServiceSettingsCarModel(),
              ),
              PageNodeModel(
                name: AppLanguageKeys.carAddScreenInCarModelSettings,
                number: PagesOfAllApp.usersPermissionsPageNumber,
                page: CarAddScreenInCarModelSettings(),
              ),
            ],
            //page: FirstScreenCarModelSettings(),
          ),*/
}

List<PageNodeModel> appPages = [];

void getPages() {
  appPages.clear();
  appPages = [
    const PageNodeModel(
      name: AppLanguageKeys.dashBoardPageKey,
      image: AppImageKeys.home,
      number: PagesOfAllApp.dashboardPageNumber,
      page: DashboardPage(),
    ),
    const PageNodeModel(
        name: AppLanguageKeys.maintenanceAndInternalServicesKey,
        image: AppImageKeys.carServices,
        number: PagesOfAllApp.internalServicesPageNumber,
        children: [
          PageNodeModel(
            name: AppLanguageKeys.permissionsGroupPageKey,
            number: PagesOfAllApp.internalServicesStatisticsPageNumber,
            page: FirstScreenInternalOrders(),
          ),
          PageNodeModel(
            name: AppLanguageKeys.ordersSectionKey,
            number: PagesOfAllApp.internalOrdersPageNumber,
            page: InternalOrdersPage(),
          ),
        ]),

    const PageNodeModel(
        name: AppLanguageKeys.spareParts,
        image: AppImageKeys.spare,
        number: PagesOfAllApp.sparePageNumber,
        children: [
          PageNodeModel(
            name: AppLanguageKeys.statistics,
            number: PagesOfAllApp.sparePartsOrdersPageNumber,
            page: FirstScreenSparePartsOrders(),
          ),
          PageNodeModel(
            name: AppLanguageKeys.ordersSectionKey,
            number: PagesOfAllApp.sparePartsStaticsPageNumber,
            page: SparePartsStatisticsPage(),
          ),
        ]),

    const PageNodeModel(
        name: AppLanguageKeys.mobileServices,
        image: AppImageKeys.mobile_maintenance,
        number: PagesOfAllApp.mobileServicePageNumber,
        children: [
          PageNodeModel(
            name: AppLanguageKeys.statistics,
            number: PagesOfAllApp.mobileServiceOrdersPageNumber,
            page: FirstScreenMobileServicesOrders(),
          ),
          PageNodeModel(
            name: AppLanguageKeys.ordersSectionKey,
            number: PagesOfAllApp.mobileServiceStaticsPageNumber,
            page: MobileServicesStatisticsPage(),
          ),
        ]),
    const PageNodeModel(
      name: AppLanguageKeys.permissionsKey,
      image: AppImageKeys.userPermissions,
      number: PagesOfAllApp.permissionsPageNumber,
      page: FirstScreenPermissions(),
    ),

    const PageNodeModel(
        name: AppLanguageKeys.carMarketKey,
        image: AppImageKeys.sell,
        number: PagesOfAllApp.carPageNumber,
        children: [
          PageNodeModel(
            name: AppLanguageKeys.permissionsGroupPageKey,
            number: PagesOfAllApp.carsHarajStatisticsPageNumber,
            page: CarsHarajStatisticsPage(),
          ),
          PageNodeModel(
            name: AppLanguageKeys.ordersSectionKey,
            number: PagesOfAllApp.carHarajOrdersPageNumber,
            page: CarHarajOrdersPage(),
          ),
        ]),

    const PageNodeModel(
        name: AppLanguageKeys.facilityManagementKey,
        image: AppImageKeys.store,
        number: PagesOfAllApp.securityPageNumber,
        children: [
          PageNodeModel(
            name: AppLanguageKeys.facilityAccountKey,
            number: PagesOfAllApp.permissionsGroupPageNumber,
            page: FacilityAccount(),
          ),
        ]),
    const PageNodeModel(
        name: AppLanguageKeys.accountManagementKey,
        image: AppImageKeys.wallet,
        number: PagesOfAllApp.walletPageNumber,
        children: [
          PageNodeModel(
            name: AppLanguageKeys.accountManagementKey,
            number: PagesOfAllApp.amountPageNumber,
            page: FirstScreenAccountsManagementAdminSun(),
          ),
          PageNodeModel(
            name: AppLanguageKeys.allPayments,
            number: PagesOfAllApp.amountPageNumber2,
            page: ListPaymentView(),
          ),
        ]),
    const PageNodeModel(
        name: AppLanguageKeys.technicalSupport,
        image: AppImageKeys.users,
        number: PagesOfAllApp.technicalSupportPageNumber,
        page: TechnicalSupportAdminSun()
    ),
    const PageNodeModel(
      name: AppLanguageKeys.socialPagesAndPoliciesKey,
      image: AppImageKeys.pages,
      number: PagesOfAllApp.pagesPageNumber,
      page: FirstScreenCommunicationAndPoliciesPages(),
    ),
    const PageNodeModel(
      name: AppLanguageKeys.logoutKey,
      image: AppImageKeys.logout,
      number: PagesOfAllApp.logoutPageNumber,
      page: LogoutDashboard(),
    ),
  ];
}
