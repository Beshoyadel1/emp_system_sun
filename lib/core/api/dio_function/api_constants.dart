import 'dart:ui';

import '../../theming/colors.dart';

class ApiConfig {
  static const String baseUrlApi = "http://89.117.62.174:809";
  static const String user = "Users";
  static const String banner = "Banner";
  static const String service = "Service";
  static const String statistics = "Statistics";
  static const String harage = "Harage";
  static const String order = "Order";
  static const String chat = "Chat";
  static const String product = "Product";
  static const String rate = "Rate";
  static const String employeeService = "EmployeeService";
  static const String coupon = "Coupon";
  static const String payment = "Payment";
  static const String paymentCard = "PaymentCard";
  static const String about = "About";
  static const String carBrand = "CarBrand";
  static const String carModel = "CarModel";
  static const String tax = "Tax";
  static const String points = "Points";
  static const String carGroup = "CarGroup";
  static const String driver = "Driver";
  static const String car = "Car";
  static const String expectedPetrolSpend = "ExpectedPetrolSpend";
  static const String provService = "ProvService";
  static const String providerServicePackage = "ProviderServicePackage";
  static const String serviceProvider = "ServiceProvider";
  static const String workTIme = "WorkTIme";
  static const String branch = "Branch";
}

class ApiLink {
  //User
  static const String loginUser =
      "${ApiConfig.baseUrlApi}/${ApiConfig.user}/LogInUser";
  static const String createUser =
      "${ApiConfig.baseUrlApi}/${ApiConfig.user}/CreateUser";
  static const String changePassword =
      "${ApiConfig.baseUrlApi}/${ApiConfig.user}/ChangePassword";
  static const String checkIfUserExist =
      "${ApiConfig.baseUrlApi}/${ApiConfig.user}/CheckIfUserExist";
  static const String checkIfUserExistOrNot =
      "${ApiConfig.baseUrlApi}/${ApiConfig.user}/CheckIfUserExistOrNot";
  static const String deleteUser =
      "${ApiConfig.baseUrlApi}/${ApiConfig.user}/DeleteUser";
  static const String getAppUserInfo =
      "${ApiConfig.baseUrlApi}/${ApiConfig.user}/GetAppUserInfo";
  static const String restoreUser =
      "${ApiConfig.baseUrlApi}/${ApiConfig.user}/RestoreUser";
  static const String updateUser =
      "${ApiConfig.baseUrlApi}/${ApiConfig.user}/UpdateUser";

  //Banner
  static const String getBanners =
      "${ApiConfig.baseUrlApi}/${ApiConfig.banner}/GetBanners";
  static const String uploadBanners =
      "${ApiConfig.baseUrlApi}/${ApiConfig.banner}/UploadBanners";

  //Chat
  static const String getOtherMessages =
      "${ApiConfig.baseUrlApi}/${ApiConfig.chat}/GetOtherMessages";
  static const String getUserProviderMessages =
      "${ApiConfig.baseUrlApi}/${ApiConfig.chat}/GetUserProviderMessages";
  static const String getWorkTeamChat =
      "${ApiConfig.baseUrlApi}/${ApiConfig.chat}/GetWorkTeamChat";
  static const String makeChatViewed =
      "${ApiConfig.baseUrlApi}/${ApiConfig.chat}/MakeChatViewed";
  static const String openCloseChat =
      "${ApiConfig.baseUrlApi}/${ApiConfig.chat}/OpenCloseChat";
  static const String sendMessage =
      "${ApiConfig.baseUrlApi}/${ApiConfig.chat}/SendMessage";

  //Company Management
  static const String addCarToGroup =
      "${ApiConfig.baseUrlApi}/${ApiConfig.carGroup}/AddCarToGroup";
  static const String addCompanyDriver =
      "${ApiConfig.baseUrlApi}/${ApiConfig.driver}/AddCompanyDriver";
  static const String createCarGroup =
      "${ApiConfig.baseUrlApi}/${ApiConfig.carGroup}/CreateCarGroup";
  static const String deleteCarGroup =
      "${ApiConfig.baseUrlApi}/${ApiConfig.carGroup}/DeleteCarGroup";
  static const String deleteCompanyDriver =
      "${ApiConfig.baseUrlApi}/${ApiConfig.driver}/DeleteCompanyDriver";
  static const String getCarGroups =
      "${ApiConfig.baseUrlApi}/${ApiConfig.carGroup}/GetCarGroups";
  static const String getCompanyDrivers =
      "${ApiConfig.baseUrlApi}/${ApiConfig.driver}/GetCompanyDrivers";
  static const String getDriverDetails =
      "${ApiConfig.baseUrlApi}/${ApiConfig.driver}/GetDriverDetails";
  static const String removeCarFromGroup =
      "${ApiConfig.baseUrlApi}/${ApiConfig.carGroup}/RemoveCarFromGroup";
  static const String updateCarGroup =
      "${ApiConfig.baseUrlApi}/${ApiConfig.carGroup}/UpdateCarGroup";
  static const String updateCompanyDriver =
      "${ApiConfig.baseUrlApi}/${ApiConfig.driver}/UpdateCompanyDriver";

//Employee Management
  static const String assignServiceToEmployee =
      "${ApiConfig.baseUrlApi}/${ApiConfig.employeeService}/AssignServiceToEmployee";
  static const String getEmployeeServices =
      "${ApiConfig.baseUrlApi}/${ApiConfig.employeeService}/GetEmployeeServices";

//General Setup And Config
  static const String addTax =
      "${ApiConfig.baseUrlApi}/${ApiConfig.tax}/AddTax";
  static const String getAvailableTaxs =
      "${ApiConfig.baseUrlApi}/${ApiConfig.tax}/getAvailableTaxs";
  static const String getPointInfo =
      "${ApiConfig.baseUrlApi}/${ApiConfig.points}/GetPointInfo";
  static const String createCarBrand =
      "${ApiConfig.baseUrlApi}/${ApiConfig.carBrand}/CreateCarBrand";
  static const String createCarModel =
      "${ApiConfig.baseUrlApi}/${ApiConfig.carModel}/CreateCarModel";
  static const String deleteTax =
      "${ApiConfig.baseUrlApi}/${ApiConfig.tax}/DeleteTax";
  static const String getAllPagesAbout =
      "${ApiConfig.baseUrlApi}/${ApiConfig.about}/GetAllPagesAbout";
  static const String getCarBrandModels =
      "${ApiConfig.baseUrlApi}/${ApiConfig.carModel}/GetCarBrandModels";
  static const String getCarBrand =
      "${ApiConfig.baseUrlApi}/${ApiConfig.carBrand}/GetCarBrands";
  static const String getServices =
      "${ApiConfig.baseUrlApi}/${ApiConfig.service}/GetServices";
  static const String updateCarBrand =
      "${ApiConfig.baseUrlApi}/${ApiConfig.carBrand}/UpdateCarBrand";
  static const String updateCarModel =
      "${ApiConfig.baseUrlApi}/${ApiConfig.carModel}/UpdateCarModel";
  static const String updatePageAbout =
      "${ApiConfig.baseUrlApi}/${ApiConfig.about}/UpdatePageAbout";
  static const String updateTax =
      "${ApiConfig.baseUrlApi}/${ApiConfig.tax}/UpdateTax";
  static const String uploadPointInfo =
      "${ApiConfig.baseUrlApi}/${ApiConfig.points}/UploadPointInfo";

//Harage
  static const String createHarage =
      "${ApiConfig.baseUrlApi}/${ApiConfig.harage}/CreateHarage";
  static const String deleteHarage =
      "${ApiConfig.baseUrlApi}/${ApiConfig.harage}/DeleteHarage";
  static const String getAllHarage =
      "${ApiConfig.baseUrlApi}/${ApiConfig.harage}/GetAllHarages";
  static const String getHarage =
      "${ApiConfig.baseUrlApi}/${ApiConfig.harage}/GetHarage";
  static const String updateHarage =
      "${ApiConfig.baseUrlApi}/${ApiConfig.harage}/UpdateHarage";

//Order
  static const String cancelOrder =
      "${ApiConfig.baseUrlApi}/${ApiConfig.order}/CancelOrder";
  static const String createOrder =
      "${ApiConfig.baseUrlApi}/${ApiConfig.order}/CreateOrder";
  static const String getCompanyOrders =
      "${ApiConfig.baseUrlApi}/${ApiConfig.order}/GetCompanyOrders";
  static const String getOrderDetails =
      "${ApiConfig.baseUrlApi}/${ApiConfig.order}/GetOrderDetails";
  static const String getOrders =
      "${ApiConfig.baseUrlApi}/${ApiConfig.order}/GetOrders";
  static const String getProviderOrders =
      "${ApiConfig.baseUrlApi}/${ApiConfig.order}/GetProviderOrders";
  static const String updateOrderOfferStatus =
      "${ApiConfig.baseUrlApi}/${ApiConfig.order}/UpdateOrderOfferStatus";
  static const String updateOrderStatus =
      "${ApiConfig.baseUrlApi}/${ApiConfig.order}/UpdateOrderStatus";

//Payments And Wallet
  static const String addCard =
      "${ApiConfig.baseUrlApi}/${ApiConfig.paymentCard}/AddCard";
  static const String createPayment =
      "${ApiConfig.baseUrlApi}/${ApiConfig.payment}/CreatePayment";
  static const String getUserCards =
      "${ApiConfig.baseUrlApi}/${ApiConfig.paymentCard}/GetUserCards";
  static const String getWalletBalance =
      "${ApiConfig.baseUrlApi}/${ApiConfig.payment}/GetWalletBalance";
  static const String getWalletTransactions =
      "${ApiConfig.baseUrlApi}/${ApiConfig.payment}/GetWalletTransactions";
  static const String rechargeWallet =
      "${ApiConfig.baseUrlApi}/${ApiConfig.payment}/RechargeWallet";
  static const String removeCard =
      "${ApiConfig.baseUrlApi}/${ApiConfig.paymentCard}/RemoveCard";
  static const String setDefaultCard =
      "${ApiConfig.baseUrlApi}/${ApiConfig.paymentCard}/SetDefaultCard";

//Product
  static const String createProduct =
      "${ApiConfig.baseUrlApi}/${ApiConfig.product}/CreateProduct";
  static const String deleteProduct =
      "${ApiConfig.baseUrlApi}/${ApiConfig.product}/DeleteProduct";
  static const String getProduct =
      "${ApiConfig.baseUrlApi}/${ApiConfig.product}/GetProduct";
  static const String getProductsSuitableForCar =
      "${ApiConfig.baseUrlApi}/${ApiConfig.product}/getProductsSuitableForCar";
  static const String updateProduct =
      "${ApiConfig.baseUrlApi}/${ApiConfig.product}/UpdateProduct";

//provider Management
  static const String createExpectedPetrolSpend =
      "${ApiConfig.baseUrlApi}/${ApiConfig.expectedPetrolSpend}/CreateExpectedPetrolSpend";
  static const String addBranch =
      "${ApiConfig.baseUrlApi}/${ApiConfig.branch}/AddBranch";
  static const String createProvService =
      "${ApiConfig.baseUrlApi}/${ApiConfig.provService}/CreateProvService";
  static const String createServicePackage =
      "${ApiConfig.baseUrlApi}/${ApiConfig.providerServicePackage}/CreateServicePackage";
  static const String deleteExpectedPetrolSpend =
      "${ApiConfig.baseUrlApi}/${ApiConfig.expectedPetrolSpend}/DeleteExpectedPetrolSpend";
  static const String deleteProvService =
      "${ApiConfig.baseUrlApi}/${ApiConfig.provService}/DeleteProvService";
  static const String deleteProviderWorkTime =
      "${ApiConfig.baseUrlApi}/${ApiConfig.workTIme}/DeleteProviderWorkTime";
  static const String deleteServicePackage =
      "${ApiConfig.baseUrlApi}/${ApiConfig.providerServicePackage}/DeleteServicePackage";
  static const String getBranchEmployees =
      "${ApiConfig.baseUrlApi}/${ApiConfig.branch}/GetBranchEmployees";
  static const String getExpectedPetrolSpend =
      "${ApiConfig.baseUrlApi}/${ApiConfig.expectedPetrolSpend}/GetExpectedPetrolSpend";
  static const String getProviderBranches =
      "${ApiConfig.baseUrlApi}/${ApiConfig.branch}/GetProviderBranches";
  static const String getProviderServicePackages =
      "${ApiConfig.baseUrlApi}/${ApiConfig.providerServicePackage}/GetProviderServicePackages";
  static const String getProviderWorkTime =
      "${ApiConfig.baseUrlApi}/${ApiConfig.workTIme}/GetProviderWorkTime";
  static const String getServiceProviderDetailsForAppUser =
      "${ApiConfig.baseUrlApi}/${ApiConfig.serviceProvider}/GetServiceProviderDetailsForAppUser";
  static const String getServiceProvidersByServiceIdForAppUser =
      "${ApiConfig.baseUrlApi}/${ApiConfig.serviceProvider}/GetServiceProvidersByServiceIdForAppUser";
  static const String updateBranch =
      "${ApiConfig.baseUrlApi}/${ApiConfig.branch}/UpdateBranch";
  static const String updateExpectedPetrolSpend =
      "${ApiConfig.baseUrlApi}/${ApiConfig.expectedPetrolSpend}/UpdateExpectedPetrolSpend";
  static const String updateProvService =
      "${ApiConfig.baseUrlApi}/${ApiConfig.provService}/UpdateProvService";
  static const String updateServicePackage =
      "${ApiConfig.baseUrlApi}/${ApiConfig.providerServicePackage}/UpdateServicePackage";
  static const String uploadProviderWorkTimes =
      "${ApiConfig.baseUrlApi}/${ApiConfig.workTIme}/UploadProviderWorkTimes";

  //Rate
  static const String createRate =
      "${ApiConfig.baseUrlApi}/${ApiConfig.rate}/CreateRate";
  static const String deleteRate =
      "${ApiConfig.baseUrlApi}/${ApiConfig.rate}/DeleteRate";
  static const String getProviderDetailsRates =
      "${ApiConfig.baseUrlApi}/${ApiConfig.rate}/GetProviderDetailsRates";
  static const String getProvidersBasicRate =
      "${ApiConfig.baseUrlApi}/${ApiConfig.rate}/GetProvidersBasicRate";
  static const String updateRate =
      "${ApiConfig.baseUrlApi}/${ApiConfig.rate}/UpdateRate";

  //Service
  static const String createService =
      "${ApiConfig.baseUrlApi}/${ApiConfig.service}/CreateService";
  static const String uploadService =
      "${ApiConfig.baseUrlApi}/${ApiConfig.service}/UploadService";

//Statistics
  static const String getAdminDashboardStatistics =
      "${ApiConfig.baseUrlApi}/${ApiConfig.statistics}/GetAdminDashboardStatistics";
  static const String getAdminMostRequestedServices =
      "${ApiConfig.baseUrlApi}/${ApiConfig.statistics}/GetAdminMostRequestedServices";
  static const String getCompanyCarGroupChart =
      "${ApiConfig.baseUrlApi}/${ApiConfig.statistics}/GetCompanyCarGroupChart";
  static const String getCompanyGeneralStatistics =
      "${ApiConfig.baseUrlApi}/${ApiConfig.statistics}/GetCompanyGeneralStatistics";
  static const String getMaintenanceReport =
      "${ApiConfig.baseUrlApi}/${ApiConfig.statistics}/GetMaintenanceReport";
  static const String getProviderHarageMonthlySales =
      "${ApiConfig.baseUrlApi}/${ApiConfig.statistics}/GetProviderHarageMonthlySales";
  static const String getProviderHarageSalesChart =
      "${ApiConfig.baseUrlApi}/${ApiConfig.statistics}/GetProviderHarageSalesChart";
  static const String getProviderHarageSoldCarsByType =
      "${ApiConfig.baseUrlApi}/${ApiConfig.statistics}/GetProviderHarageSoldCarsByType";
  static const String getProviderMainServiceStatistics =
      "${ApiConfig.baseUrlApi}/${ApiConfig.statistics}/GetProviderMainServiceStatistics";
  static const String getProviderOrdersSales =
      "${ApiConfig.baseUrlApi}/${ApiConfig.statistics}/GetProviderOrdersSales";
  static const String getProviderPetrolBranchesSales =
      "${ApiConfig.baseUrlApi}/${ApiConfig.statistics}/GetProviderPetrolBranchesSales";
  static const String getProviderPetrolSalesChart =
      "${ApiConfig.baseUrlApi}/${ApiConfig.statistics}/GetProviderPetrolSalesChart";
  static const String getProviderServiceStatistics =
      "${ApiConfig.baseUrlApi}/${ApiConfig.statistics}/GetProviderServiceStatistics";
  static const String getProviderTotalRateAndEmployeeAndBalance =
      "${ApiConfig.baseUrlApi}/${ApiConfig.statistics}/GetProviderTotalRateAndEmployeeAndBalance";

  //Utility And Extras
  static const String changeCouponStatus =
      "${ApiConfig.baseUrlApi}/${ApiConfig.coupon}/ChangeCouponStatus";
  static const String getCar =
      "${ApiConfig.baseUrlApi}/${ApiConfig.car}/GetCar";
  static const String getCouponByCode =
      "${ApiConfig.baseUrlApi}/${ApiConfig.coupon}/GetCouponByCode";
  static const String getStaticsForCoupon =
      "${ApiConfig.baseUrlApi}/${ApiConfig.coupon}/GetStaticsForCoupon";
  static const String uploadCoupon =
      "${ApiConfig.baseUrlApi}/${ApiConfig.coupon}/UploadCoupon";
}

class OrderStatus {
  static const int newOrderForCompany = -2;
  static const int rejectedByCompany = -1;
  static const int newOrderForProvider = 0;
  static const int waitingAppointment = 1;
  static const int employeeInRoad = 2;
  static const int workInProgress = 3;
  static const int orderCompleted = 4;
  static const int rejectedByProvider = 5;
  static const int cancelledByUser = 6;
}

class OrderType {
  static const int New = 1;
  static const int current = 2;
  static const int done = 3;
  static const List<int> newOrders = [
    OrderStatus.newOrderForProvider,
    OrderStatus.newOrderForCompany
  ];
  static const List<int> currentOrders = [
    OrderStatus.waitingAppointment,
    OrderStatus.employeeInRoad,
    OrderStatus.workInProgress
  ];
  static const List<int> doneOrders = [
    OrderStatus.orderCompleted,
    OrderStatus.cancelledByUser,
    OrderStatus.rejectedByProvider,
  ];
}

class CategoryConstants {
  static const int maintenanceAndRepair = 6;
  static const int oilChange = 7;
  static const int batteryMaintenance = 8;
  static const int periodicMaintenance = 9;
  static const int mobileServices = 10;
  static const int towingService = 11;
  static const int roadsideAssistance = 12;
  static const int interiorParts = 13;
  static const int oilsAndLubricants = 14;
  static const int carAccessories = 15;
  static const int batteryPackage = 16;
  static const int autoGlass = 17;
  static const int tires = 18;
  static const int petrolService = 19;
}

class MainCategoryConstants {
  static const int maintenanceAndInternalServicesID = 1;
  static const int mobileServicesAndTransportationID = 2;
  static const int carSparePartsID = 3;
  static const int servicePackagesID = 4;
  static const int petrolMainID = 5;

  final List<int> maintenanceSubCategories = [
    CategoryConstants.maintenanceAndRepair,
    CategoryConstants.oilChange,
    CategoryConstants.batteryMaintenance,
    CategoryConstants.periodicMaintenance
  ];

  final List<int> mobileSubCategories = [
    CategoryConstants.mobileServices,
    CategoryConstants.towingService,
    CategoryConstants.roadsideAssistance
  ];

  final List<int> sparePartsSubCategories = [
    CategoryConstants.interiorParts,
    CategoryConstants.oilsAndLubricants,
    CategoryConstants.carAccessories,
    CategoryConstants.batteryPackage,
    CategoryConstants.autoGlass,
    CategoryConstants.tires
  ];

  final List<int> servicePackageSubCategories = [];

  final List<int> petrolSubCategories = [CategoryConstants.petrolService];
}

class UserType {
  static const int appUser = 1;
  static const int companyUser = 2;
  static const int driverUser = 3;
  static const int providerUser = 4;
  static const int employeeUser = 5;
  static const int adminUser = 6;
}

Color legendColor(int index) {
  const colors = [
    AppColors.brownColor,
    AppColors.lightBlueColor,
    AppColors.greenColor,
    AppColors.orangeColor,
    AppColors.purpleColor,
    AppColors.yelloIconLoadingColor,
    AppColors.redColor,
    AppColors.cyanColor,
    AppColors.blackColor
  ];

  return colors[index % colors.length];
}
