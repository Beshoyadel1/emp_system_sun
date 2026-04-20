import '../../../../core/utilies/map_of_all_app.dart';

class AppLanguageKeys {
  //status//
  static const String notSold = 'notSold';
  static const String sold = 'sold';
  static const String newCar = 'newCar';
  static const String usedCar = 'usedCar';
  static const String newOrderForCompany = 'newOrderForCompany';
  static const String rejectedByCompany = 'rejectedByCompany';
  static const String newOrderForProvider = 'newOrderForProvider';
  static const String waitingAppointment = 'waitingAppointment';
  static const String employeeInRound = 'employeeInRound';
  static const String workInProgress = 'workInProgress';
  static const String orderCompleted = 'orderCompleted';
  static const String rejectedByProvider = 'rejectedByProvider';
  static const String cancelledByUser = 'cancelledByUser';

  //end//

  //others//
  static const String oldService = 'oldService';
  static const String createService = 'createService';
  static const String serviceNameAr = 'serviceNameAr';
  static const String serviceNameEn = 'serviceNameEn';
  static const String restAll = 'restAll';
  static const String selectPricingTypeFirst = "selectPricingTypeFirst";
  static const String cost = 'cost';
  static const String confirmDelete = 'confirmDelete';
  static const String description = 'description';
  static const String mileage = 'mileage';
  static const String carStatus = 'carStatus';
  static const String emailOrPhoneInvalid = 'emailOrPhoneInvalid';
  static const String phoneInvalid = 'phoneInvalid';
  static const String userNotFound = 'userNotFound';
  static const String wrongCode = 'wrongCode';
  static const String loginFailed = 'loginFailed';
  static const String enterOtp = 'enterOtp';
  static const String verify = 'verify';
  static const String subscriptionEndDate = 'subscriptionEndDate';
  static const String subscriptionStartDate = 'subscriptionStartDate';
  static const String annualPrice = 'annualPrice';
  static const String monthlyPrice = 'monthlyPrice';
  static const String invoiceServices = 'invoiceServices';
  static const String transferDate = 'transferDate';
  static const String ordersCommission = 'ordersCommission';
  static const String netBalance = 'netBalance';
  static const String allPayments = 'allPayments';
  static const String cardPayments = 'cardPayments';
  static const String cashOnDeliveryPayments = 'cashOnDeliveryPayments';
  static const String packageType = 'packageType';
  static const String subscriptionDuration = 'subscriptionDuration';
  static const String subscriptionFee = 'subscriptionFee';
  static const String nextSubscriptionDate = 'nextSubscriptionDate';
  static const String downloadInvoice = 'downloadInvoice';
  static const String transactionNumber = 'transactionNumber';
  static const String invoiceDate = 'invoiceDate';
  static const String orderStatus = 'orderStatus';
  static const String transactionDetails = 'transactionDetails';
  static const String latinName = 'latinName';
  static const String items = 'items';
  static const String create = 'create';
  static const String carMarketSales = 'carMarketSales';
  static const String rejectionReason = 'rejectionReason';
  static const String orderInProgress = 'orderInProgress';
  static const String waitingForInvoicePayment = 'waitingForInvoicePayment';

  static const String carsListCurrentAndSold = 'carsListCurrentAndSold';
  static const String soldCars = 'soldCars';
  static const String carList = 'carList';
  static const String availableCarsShortList = 'availableCarsShortList';
  static const String filling = 'filling';
  static const String fillingDate = 'fillingDate';
  static const String order = 'order';
  static const String authCompanyNameRequired = 'authCompanyNameRequired';
  static const String authEmailRequired = 'authEmailRequired';
  static const String authEnterCorrectEmail = 'authEnterCorrectEmail';
  static const String authPasswordRequired = 'authPasswordRequired';
  static const String authWeakPassword = 'authWeakPassword';
  static const String authPhoneNumberRequired = 'authPhoneNumberRequired';
  static const String authEnterCorrectPhoneNumber =
      'authEnterCorrectPhoneNumber';
  static const String createNewPassword = 'createNewPassword';
  static const String gender = 'gender';
  static const String age = 'age';

  //end//

  //message api response//
  static const String passwordsDoNotMatch = 'passwordsDoNotMatch';
  static const String wrongUsername = 'wrongUsername';
  static const String somethingWentWrong = 'somethingWentWrong';
  static const String emailExist = 'emailExist';
  static const String emailNotExist = 'emailNotExist';
  static const String phoneExist = 'phoneExist';
  static const String emailOrPhoneExist = 'emailOrPhoneExist';
  static const String done = 'done';
  static const String notFound = 'notFound';
  static const String storeNotExist = 'storeNotExist';
  static const String noUser = 'noUser';
  static const String wrongPassword = 'wrongPassword';
  static const String notActive = 'notActive';
  static const String sameUser = 'sameUser';
  static const String notEnoughPoints = 'notEnoughPoints';
  static const String notEnoughBalance = 'notEnoughBalance';
  static const String reservedUser = 'reservedUser';
  static const String haveOperationForDelete = 'haveOperationForDelete';
  static const String wrongReferralCode = 'wrongReferralCode';
  static const String empty = 'empty';
  static const String expired = 'expired';
  static const String couponReachMaxUse = 'couponReachMaxUse';
  static const String userReachMaxUseCoupon = 'userReachMaxUseCoupon';
  static const String pointsFromNewOrder = 'pointsFromNewOrder';
  static const String categoryExist = 'categoryExist';

  //End//

  //Api Failures//
  static const String oopsErrorTryAgain = 'oopsErrorTryAgain';
  static const String internalServerError = 'internalServerError';
  static const String requestNotFound = 'requestNotFound';
  static const String badResponseError = 'badResponseError';
  static const String success = 'success';
  static const String badRequestError = 'badRequestError';
  static const String unauthorizedError = 'unauthorizedError';
  static const String forbiddenError = 'forbiddenError';
  static const String methodNotAllowed = 'methodNotAllowed';
  static const String requestTimeout = 'requestTimeout';
  static const String conflictError = 'conflictError';
  static const String validationError = 'validationError';
  static const String tooManyRequests = 'tooManyRequests';
  static const String badGateway = 'badGateway';
  static const String serviceUnavailable = 'serviceUnavailable';
  static const String gatewayTimeout = 'gatewayTimeout';
  static const String noInternetConnection = 'noInternetConnection';

  //End//

  //login//
  static const String enterUsernameAndPassword = 'enterUsernameAndPassword';
  static const String fillAllFields = 'fillAllFields';

  //End//
  //api_functions//
  static const String changePasswordSuccessfully = 'changePasswordSuccessfully';
  static const String checkIfUserExistSuccessfully =
      'checkIfUserExistSuccessfully';
  static const String checkIfUserExistOrNotSuccessfully =
      'checkIfUserExistOrNotSuccessfully';
  static const String accountCreatedSuccessfully = 'accountCreatedSuccessfully';
  static const String deleteUserSuccessfully = 'deleteUserSuccessfully';
  static const String getAppUserInfoSuccessfully = 'getAppUserInfoSuccessfully';
  static const String accountLoginSuccessfully = 'accountLoginSuccessfully';
  static const String restoreUserSuccessfully = 'restoreUserSuccessfully';
  static const String updateUserSuccessfully = 'updateUserSuccessfully';

  static const String changeCouponStatusSuccessfully =
      'changeCouponStatusSuccessfully';
  static const String getCarSuccessfully = 'getCarSuccessfully';
  static const String getCouponByCodeSuccessfully =
      'getCouponByCodeSuccessfully';
  static const String getStaticsForCouponSuccessfully =
      'getStaticsForCouponSuccessfully';
  static const String uploadCouponSuccessfully = 'uploadCouponSuccessfully';

  static const String createRateSuccessfully = 'createRateSuccessfully';
  static const String deleteRateSuccessfully = 'deleteRateSuccessfully';
  static const String getProviderDetailsRatesSuccessfully =
      'getProviderDetailsRatesSuccessfully';
  static const String getProvidersBasicRateSuccessfully =
      'getProvidersBasicRateSuccessfully';
  static const String updateRateSuccessfully = 'updateRateSuccessfully';

  static const String createServiceSuccessfully = 'createServiceSuccessfully';
  static const String uploadServiceSuccessfully = 'uploadServiceSuccessfully';

  static const String getAdminDashboardStatisticsSuccessfully =
      'getAdminDashboardStatisticsSuccessfully';
  static const String getAdminMostRequestedServicesSuccessfully =
      'getAdminMostRequestedServicesSuccessfully';
  static const String getCompanyCarGroupChartSuccessfully =
      'getCompanyCarGroupChartSuccessfully';
  static const String getCompanyGeneralStatisticsSuccessfully =
      'getCompanyGeneralStatisticsSuccessfully';
  static const String getMaintenanceReportSuccessfully =
      'getMaintenanceReportSuccessfully';
  static const String getProviderHarageMonthlySalesSuccessfully =
      'getProviderHarageMonthlySalesSuccessfully';
  static const String getProviderHarageSalesChartSuccessfully =
      'getProviderHarageSalesChartSuccessfully';
  static const String getProviderHarageSoldCarsByTypeSuccessfully =
      'getProviderHarageSoldCarsByTypeSuccessfully';
  static const String getProviderMainServiceStatisticsSuccessfully =
      'getProviderMainServiceStatisticsSuccessfully';
  static const String getProviderOrdersSalesSuccessfully =
      'getProviderOrdersSalesSuccessfully';
  static const String getProviderPetrolBranchesSalesSuccessfully =
      'getProviderPetrolBranchesSalesSuccessfully';
  static const String getProviderPetrolSalesChartSuccessfully =
      'getProviderPetrolSalesChartSuccessfully';
  static const String getProviderServiceStatisticsSuccessfully =
      'getProviderServiceStatisticsSuccessfully';
  static const String getProviderTotalRateEmployeeBalanceSuccessfully =
      'getProviderTotalRateEmployeeBalanceSuccessfully';

  static const String createProductSuccess = 'createProductSuccess';
  static const String deleteProductSuccess = 'deleteProductSuccess';
  static const String getProductSuccess = 'getProductSuccess';
  static const String getProductsSuitableForCarSuccess =
      'getProductsSuitableForCarSuccess';
  static const String updateProductSuccess = 'updateProductSuccess';

  static const String addBranchSuccess = 'addBranchSuccess';
  static const String createExpectedPetrolSpendSuccess =
      'createExpectedPetrolSpendSuccess';
  static const String createProvServiceSuccess = 'createProvServiceSuccess';
  static const String createServicePackageSuccess =
      'createServicePackageSuccess';
  static const String deleteExpectedPetrolSpendSuccess =
      'deleteExpectedPetrolSpendSuccess';
  static const String deleteProvServiceSuccess = 'deleteProvServiceSuccess';
  static const String deleteProviderWorkTimeSuccess =
      'deleteProviderWorkTimeSuccess';
  static const String deleteServicePackageSuccess =
      'deleteServicePackageSuccess';
  static const String getBranchEmployeesSuccess = 'getBranchEmployeesSuccess';
  static const String getExpectedPetrolSpendSuccess =
      'getExpectedPetrolSpendSuccess';
  static const String getProviderBranchesSuccess = 'getProviderBranchesSuccess';
  static const String getProviderServicePackagesSuccess =
      'getProviderServicePackagesSuccess';
  static const String getProviderWorkTimeSuccess = 'getProviderWorkTimeSuccess';
  static const String getServiceProviderDetailsForAppUserSuccess =
      'getServiceProviderDetailsForAppUserSuccess';
  static const String getServiceProvidersByServiceIdForAppUserSuccess =
      'getServiceProvidersByServiceIdForAppUserSuccess';
  static const String updateBranchSuccess = 'updateBranchSuccess';
  static const String updateExpectedPetrolSpendSuccess =
      'updateExpectedPetrolSpendSuccess';
  static const String updateProvServiceSuccess = 'updateProvServiceSuccess';
  static const String updateServicePackageSuccess =
      'updateServicePackageSuccess';
  static const String uploadProviderWorkTimesSuccess =
      'uploadProviderWorkTimesSuccess';

  static const String createHarageSuccessfully = 'createHarageSuccessfully';
  static const String deleteHarageSuccessfully = 'deleteHarageSuccessfully';
  static const String getAllHarageSuccessfully = 'getAllHarageSuccessfully';
  static const String getHarageSuccessfully = 'getHarageSuccessfully';
  static const String updateHarageSuccessfully = 'updateHarageSuccessfully';

  static const String cancelOrderSuccessfully = 'cancelOrderSuccessfully';
  static const String createOrderSuccessfully = 'createOrderSuccessfully';
  static const String getCompanyOrdersSuccessfully =
      'getCompanyOrdersSuccessfully';
  static const String getOrderDetailsSuccessfully =
      'getOrderDetailsSuccessfully';
  static const String getOrdersSuccessfully = 'getOrdersSuccessfully';
  static const String getProviderOrdersSuccessfully =
      'getProviderOrdersSuccessfully';
  static const String updateOrderOfferStatusSuccessfully =
      'updateOrderOfferStatusSuccessfully';
  static const String updateOrderStatusSuccessfully =
      'updateOrderStatusSuccessfully';

  static const String addCardSuccessfully = 'addCardSuccessfully';
  static const String createPaymentSuccessfully = 'createPaymentSuccessfully';
  static const String getUserCardsSuccessfully = 'getUserCardsSuccessfully';
  static const String getWalletBalanceSuccessfully =
      'getWalletBalanceSuccessfully';
  static const String getWalletTransactionsSuccessfully =
      'getWalletTransactionsSuccessfully';
  static const String rechargeWalletSuccessfully = 'rechargeWalletSuccessfully';
  static const String removeCardSuccessfully = 'removeCardSuccessfully';
  static const String setDefaultCardSuccessfully = 'setDefaultCardSuccessfully';

  static const String assignServiceToEmployeeSuccessfully =
      'assignServiceToEmployeeSuccessfully';
  static const String getEmployeeServicesSuccessfully =
      'getEmployeeServicesSuccessfully';

  static const String addTaxSuccessfully = 'addTaxSuccessfully';
  static const String createCarBrandSuccessfully = 'createCarBrandSuccessfully';
  static const String createCarModelSuccessfully = 'createCarModelSuccessfully';
  static const String deleteTaxSuccessfully = 'deleteTaxSuccessfully';
  static const String getAllPagesAboutSuccessfully =
      'getAllPagesAboutSuccessfully';
  static const String getCarBrandModelsSuccessfully =
      'getCarBrandModelsSuccessfully';
  static const String getServicesSuccessfully = 'getServicesSuccessfully';
  static const String updateCarBrandSuccessfully = 'updateCarBrandSuccessfully';
  static const String updateCarModelSuccessfully = 'updateCarModelSuccessfully';
  static const String updatePageAboutSuccessfully =
      'updatePageAboutSuccessfully';
  static const String updateTaxSuccessfully = 'updateTaxSuccessfully';
  static const String uploadPointInfoSuccessfully =
      'uploadPointInfoSuccessfully';

  static const String getBannersSuccessfully = 'getBannersSuccessfully';
  static const String uploadBannersSuccessfully = 'uploadBannersSuccessfully';

  static const String getOtherMessagesSuccessfully =
      'getOtherMessagesSuccessfully';
  static const String getUserProviderMessagesSuccessfully =
      'getUserProviderMessagesSuccessfully';
  static const String getWorkTeamChatSuccessfully =
      'getWorkTeamChatSuccessfully';
  static const String makeChatViewedSuccessfully = 'makeChatViewedSuccessfully';
  static const String openCloseChatSuccessfully = 'openCloseChatSuccessfully';
  static const String sendMessageSuccessfully = 'sendMessageSuccessfully';

  static const String addCarToGroupSuccessfully = 'addCarToGroupSuccessfully';
  static const String addCompanyDriverSuccessfully =
      'addCompanyDriverSuccessfully';
  static const String createCarGroupSuccessfully = 'createCarGroupSuccessfully';
  static const String deleteCarGroupSuccessfully = 'deleteCarGroupSuccessfully';
  static const String deleteCompanyDriverSuccessfully =
      'deleteCompanyDriverSuccessfully';
  static const String getCarGroupsSuccessfully = 'getCarGroupsSuccessfully';
  static const String getCompanyDriversSuccessfully =
      'getCompanyDriversSuccessfully';
  static const String getDriverDetailsSuccessfully =
      'getDriverDetailsSuccessfully';
  static const String removeCarFromGroupSuccessfully =
      'removeCarFromGroupSuccessfully';
  static const String updateCarGroupSuccessfully = 'updateCarGroupSuccessfully';
  static const String updateCompanyDriverSuccessfully =
      'updateCompanyDriverSuccessfully';

  //End//
  //New Adds///
  static const String petroleum = 'petroleum';
  static const String languageKey = 'Language';
  static const String dashBoardPageKey = PagesOfAllApp.dashboardPage;
  static const String securityPageKey = PagesOfAllApp.securityPage;
  static const String permissionsGroupPageKey =
      PagesOfAllApp.permissionsGroupPage;
  static const String usersPermissionsPageKey =
      PagesOfAllApp.usersPermissionsPage;
  static const String userStatisticsPageKey = PagesOfAllApp.userStatisticsPage;
  static const String settingsPageKey = PagesOfAllApp.settingsPage;
  static const String companiesPageKey = PagesOfAllApp.companiesPage;
  static const String generalSettingsPageKey =
      PagesOfAllApp.generalSettingsPage;
  static const String branchesPageKey = PagesOfAllApp.branchesPage;
  static const String inventoriesPageKey = PagesOfAllApp.inventoriesPage;
  static const String banksPageKey = PagesOfAllApp.banksPage;
  static const String areasPageKey = PagesOfAllApp.areasPage;
  static const String taxesPageKey = PagesOfAllApp.taxesPage;
  static const String financialPeriodPageKey =
      PagesOfAllApp.financialPeriodPage;
  static const String costCenterPageKey = PagesOfAllApp.costCenterPage;
  static const String currenciesPageKey = PagesOfAllApp.currenciesPage;
  static const String categoriesPageKey = PagesOfAllApp.categoriesPage;
  static const String skipKey = 'Skip';
  static const String nextKey = 'Next';
  static const String startKey = 'Start';
  static const String userNameKey = 'UserName';
  static const String passwordKey = 'Password';
  static const String loginKey = 'Login';
  static const String freeTrialKey = 'Free_Trial';
  static const String versionKey = 'Version';
  static const String rememberMeKey = 'Remember_Me';
  static const String okKey = 'Ok';
  static const String backButtonKey = 'Back_Button';
  static const String addAllRequiredFieldsKey = 'Add_All_Required_Fields';
  static const String passwordNotMatchKey = 'Password_Not_Match';
  static const String passwordAtLeastKey = 'Password_At_Least';
  static const String wrongPasswordKey = 'Wrong_Password';

  static const String signUpTitleKey = 'signUpTitleEN';
  static const String centerNameKey = 'centerNameEN';
  static const String phoneNumberKey = 'phoneNumberEN';
  static const String emailKey = 'emailEN';
  static const String confirmPasswordKey = 'confirmPasswordEN';
  static const String createAccountKey = 'createAccountEN';
  static const String enterPhoneAndPasswordKey = 'enterPhoneAndPasswordEN';
  static const String forgotPasswordKey = 'forgotPasswordEN';
  static const String loginAgainKey = 'loginAgainEN';
  static const String fromKey = 'fromEN';
  static const String toKey = 'toEN';
  static const String backKey = 'backEN';
  static const String mainBranchKey = 'mainBranchEN';
  static const String editKey = 'editEN';
  static const String addNewBranchKey = 'addNewBranchEN';
  static const String facilityManagementKey = 'facilityManagementEN';
  static const String addMainBranchKey = 'addMainBranchEN';
  static const String branchAddressKey = 'branchAddressEN';
  static const String addressDetailsKey = 'addressDetailsEN';
  static const String confirmBranchLocationKey = 'confirmBranchLocationEN';
  static const String saveKey = 'saveEN';
  static const String selectCarModelKey = 'selectCarModelEN';
  static const String searchCarModelKey = 'searchCarModelEN';
  static const String continueFacilityDataKey = 'continueFacilityDataEN';
  static const String fillFacilityDataKey = 'fillFacilityDataEN';
  static const String saturdayKey = 'saturdayEN';
  static const String sundayKey = 'sundayEN';
  static const String mondayKey = 'mondayEN';
  static const String tuesdayKey = 'tuesdayEN';
  static const String wednesdayKey = 'wednesdayEN';
  static const String thursdayKey = 'thursdayEN';
  static const String fridayKey = 'fridayEN';
  static const String weekDaysKey = 'weekDaysEN';
  static const String selectWorkDaysKey = 'selectWorkDaysEN';
  static const String availableTimesKey = 'availableTimesEN';
  static const String selectAvailableTimeKey = 'selectAvailableTimeEN';
  static const String facilityIdentityKey = 'facilityIdentityEN';
  static const String attachIdentityKey = 'attachIdentityEN';
  static const String imageRequirementsKey = 'imageRequirementsEN';
  static const String facilityNameKey = 'facilityNameEN';
  static const String facilityNameENKey = 'facilityNameENEN';
  static const String activityTypeKey = 'activityTypeEN';
  static const String emailAgainKey = 'emailAgainEN';
  static const String phoneAgainKey = 'phoneAgainEN';
  static const String commercialRecordKey = 'commercialRecordEN';
  static const String taxNumberKey = 'taxNumberEN';
  static const String shortAddressKey = 'shortAddressEN';
  static const String buildingNumberKey = 'buildingNumberEN';
  static const String cityKey = 'cityEN';
  static const String buildingNumberAgainKey = 'buildingNumberAgainEN';
  static const String commercialRecordFileKey = 'commercialRecordFileEN';
  static const String attachFileKey = 'attachFileEN';
  static const String ownerIdKey = 'ownerIdEN';
  static const String bankNameKey = 'bankNameEN';
  static const String beneficiaryNameKey = 'beneficiaryNameEN';
  static const String bankAccountNumberKey = 'bankAccountNumberEN';
  static const String swiftCodeKey = 'swiftCodeEN';
  static const String ibanNumberKey = 'ibanNumberEN';
  static const String addKey = 'addEN';
  static const String newModelKey = 'newModelEN';
  static const String carCategoryKey = 'carCategoryEN';
  static const String nissanKey = 'nissanEN';
  static const String allCategoriesKey = 'allCategoriesEN';
  static const String nissanAllCategoriesKey = 'nissanAllCategoriesEN';
  static const String serviceSettingsKey = 'serviceSettingsEN';
  static const String selectModelYearsKey = 'selectModelYearsEN';
  static const String chooseCategoryKey = 'chooseCategoryEN';
  static const String allCategoriesAgainKey = 'allCategoriesAgainEN';
  static const String addedCarsKey = 'addedCarsEN';
  static const String modelRangeKey = 'modelRangeEN';
  static const String porscheKey = 'porscheEN';
  static const String mercedesKey = 'mercedesEN';
  static const String lexusKey = 'lexusEN';
  static const String mercedesAgainKey = 'mercedesAgainEN';
  static const String nissanQashqaiKey = 'nissanQashqaiEN';
  static const String defineModelsKey = 'defineModelsEN';
  static const String carModelsKey = 'carModelsEN';
  static const String multipleCarsKey = 'multipleCarsEN';
  static const String serviceSettingsDetailsKey = 'serviceSettingsDetailsEN';
  static const String addNewCarKey = 'addNewCarEN';
  static const String addCarModelKey = 'addCarModelEN';
  static const String facilityDataKey = 'facilityDataEN';
  static const String identityKey = 'identityEN';
  static const String branchesKey = 'branchesEN';
  static const String workingHoursKey = 'workingHoursEN';
  static const String bankAccountKey = 'bankAccountEN';
  static const String facilityManagementAgainKey = 'facilityManagementAgainEN';
  static const String facilityAccountKey = 'facilityAccountEN';
  static const String carModelsTitleKey = 'carModelsTitleEN';
  static const String serviceSettingsTitleKey = 'serviceSettingsTitleEN';
  static const String nameKey = 'nameEN';
  static const String newUserKey = 'newUserEN';
  static const String introTextKey = 'introTextEN';

  static const String internalMaintenanceKey = 'internalMaintenanceEN';
  static const String sparePartsKey = 'sparePartsEN';
  static const String mobileServicesKey = 'mobileServicesEN';
  static const String allOrdersKey = 'allOrdersEN';
  static const String newOrdersKey = 'newOrdersEN';
  static const String completedOrdersKey = 'completedOrdersEN';
  static const String createNewOrderKey = 'createNewOrderEN';
  static const String orderInProgressKey = 'orderInProgressEN';
  static const String waitingForPaymentKey = 'waitingForPaymentEN';
  static const String serviceDeliveredKey = 'serviceDeliveredEN';
  static const String accountBalanceKey = 'accountBalanceEN';
  static const String detailsKey = 'detailsEN';
  static const String ordersKey = 'ordersEN';
  static const String internalServicesKey = 'internalServicesEN';
  static const String ordersCountKey = 'ordersCountEN';
  static const String increasePercentKey = 'increasePercentEN';
  static const String maintenanceAndRepairKey = 'maintenanceAndRepairEN';
  static const String revenueFromOrderKey = 'revenueFromOrderEN';
  static const String jobTitleKey = 'jobTitleEN';
  static const String employeeNameKey = 'employeeNameEN';
  static const String requestsCountKey = 'requestsCountEN';
  static const String topEmployeesKey = 'topEmployeesEN';
  static const String topOrderReceiversKey = 'topOrderReceiversEN';
  static const String servicesRatingKey = 'servicesRatingEN';
  static const String internalServicesStatsKey = 'internalServicesStatsEN';
  static const String executeOrderKey = 'executeOrderEN';
  static const String internalServicesTitleKey = 'internalServicesTitleEN';
  static const String maintenanceAndRepairTitleKey =
      'maintenanceAndRepairTitleEN';
  static const String clientNameKey = 'clientNameEN';
  static const String expectedEndDateKey = 'expectedEndDateEN';
  static const String notesKey = 'notesEN';
  static const String washingAndCleaningKey = 'washingAndCleaningEN';
  static const String jobNameKey = 'jobNameEN';
  static const String internalServiceKey = 'internalServiceEN';
  static const String newOrdersListKey = 'newOrdersListEN';
  static const String newOrdersFromServicesKey = 'newOrdersFromServicesEN';
  static const String viewAllKey = 'viewAllEN';
  static const String orderDateKey = 'orderDateEN';
  static const String orderDetailsTitleKey = 'orderDetailsTitleEN';
  static const String viewAllOrderDetailsKey = 'viewAllOrderDetailsEN';
  static const String orderStatusKey = 'orderStatusEN';
  static const String underServiceKey = 'underServiceEN';
  static const String allOrdersListKey = 'allOrdersListEN';
  static const String ordersListFromServicesKey = 'ordersListFromServicesEN';
  static const String invoiceKey = 'invoiceEN';
  static const String insuranceInstallmentKey = 'insuranceInstallmentEN';
  static const String taxesKey = 'taxesEN';
  static const String totalKey = 'totalEN';
  static const String insuranceAgainKey = 'insuranceAgainEN';
  static const String paidByKey = 'paidByEN';
  static const String orderCompletionKey = 'orderCompletionEN';
  static const String internalServicesProfitKey = 'internalServicesProfitEN';
  static const String searchKey = 'searchEN';
  static const String filterKey = 'filterEN';
  static const String servicePriceKey = 'servicePriceEN';
  static const String statisticsKey = 'statisticsEN';
  static const String maintenanceAndInternalServicesKey =
      'maintenanceAndInternalServicesEN';
  static const String ordersSectionKey = 'ordersSectionEN';
  static const String mobileAndTransportServicesKey =
      'mobileAndTransportServicesEN';
  static const String sparePartsSectionKey = 'sparePartsSectionEN';
  static const String carMarketKey = 'carMarketEN';
  static const String accountManagementKey = 'accountManagementEN';
  static const String permissionsKey = 'permissionsEN';
  static const String notificationsKey = 'notificationsEN';
  static const String adsKey = 'adsEN';
  static const String reviewsKey = 'reviewsEN';
  static const String socialPagesAndPoliciesKey = 'socialPagesAndPoliciesEN';
  static const String logoutKey = 'logoutEN';
  static const String priceKey = 'priceEN';

  //End///

  ////dashboard////
  static const String establishmentOrders = 'establishmentOrders';
  static const String waitingForApproval = 'waitingForApproval';

  static const String drivers = 'drivers';

  static const String serviceProvider = 'serviceProvider';

  static const String paymentSuccessful = 'paymentSuccessful';
  static const String orderDelivery = 'orderDelivery';
  static const String contactCustomer = 'contactCustomer';
  static const String orderArrived = 'orderArrived';

  static const String sparePartsOrders = 'sparePartsOrders';
  static const String serviceOrdersList = 'serviceOrdersList';
  static const String shippingCompany = 'shippingCompany';

  static const String carDetails = 'carDetails';
  static const String viewAllOrderDetails = 'viewAllOrderDetails';
  static const String carSpecifications = 'carSpecifications';
  static const String carSold = 'carSold';

  static const String usage = 'usage';
  static const String brandNew = 'brandNew';
  static const String filter = 'filter';
  static const String carsList = 'carsList';
  static const String allCars = 'allCars';
  static const String newCars = 'newCars';
  static const String usedCars = 'usedCars';
  static const String carCondition = 'carCondition';
  static const String messagesCount = 'messagesCount';
  static const String carPrice = 'carPrice';

  static const String yourPerfectPlatform = 'yourPerfectPlatform';
  static const String employeesLogin = 'employeesLogin';
  static const String enterPhoneAndPassword = 'enterPhoneAndPassword';

  static const String writeYourMessageHere = 'writeYourMessageHere';

  static const String technicalSupport = 'technicalSupport';
  static const String messages = 'messages';
  static const String teamMembers = 'teamMembers';
  static const String membersCount = 'membersCount';
  static const String searchInMessages = 'searchInMessages';

  static const String employeeNameEn = 'employeeNameEn';
  static const String employeeId = 'employeeId';
  static const String joiningDate = 'joiningDate';
  static const String address = 'address';

  static const String commercialRecordCertificate =
      'commercialRecordCertificate';
  static const String ownerIdOrResidenceCard = 'ownerIdOrResidenceCard';
  static const String establishmentManagement = 'establishmentManagement';
  static const String establishmentData = 'establishmentData';
  static const String fillEstablishmentAccountData =
      'fillEstablishmentAccountData';
  static const String identity = 'identity';
  static const String branches = 'branches';
  static const String workingHours = 'workingHours';
  static const String bankAccount = 'bankAccount';
  static const String establishmentName = 'establishmentName';
  static const String establishmentNameEn = 'establishmentNameEn';
  static const String activityType = 'activityType';
  static const String commercialRegistration = 'commercialRegistration';
  static const String taxNumber = 'taxNumber';
  static const String shortAddress4Letters = 'shortAddress4Letters';
  static const String buildingNumber = 'buildingNumber';
  static const String city = 'city';
  static const String attachFile = 'attachFile';
  static const String ownerIdOrIqama = 'ownerIdOrIqama';

  static const String oilProducts = 'oilProducts';
  static const String allSoldProducts = 'allSoldProducts';
  static const String allDisplayedProducts = 'allDisplayedProducts';
  static const String availableDisplayedList = 'availableDisplayedList';
  static const String addNewOil = 'addNewOil';
  static const String saleDate = 'saleDate';
  static const String productPrice = 'productPrice';
  static const String allFillingOrders = 'allFillingOrders';
  static const String fillingOrdersSalesForAllBranches =
      'fillingOrdersSalesForAllBranches';
  static const String fuelFillingSalesPerBranch = 'fuelFillingSalesPerBranch';
  static const String addDifferentServices = 'addDifferentServices';
  static const String specialPackage = 'specialPackage';
  static const String packageName = 'packageName';
  static const String packageDescription = 'packageDescription';
  static const String servicesIncluded = 'servicesIncluded';

  static const String delete = 'delete';
  static const String sizesOrDimensions = 'sizesOrDimensions';
  static const String availableQuantity = 'availableQuantity';

  static const String addSparePart = 'addSparePart';
  static const String addSparePartDetails = 'addSparePartDetails';
  static const String allCategoriesIncluded = 'allCategoriesIncluded';
  static const String specificCategory = 'specificCategory';
  static const String partName = 'partName';
  static const String spareCategory = 'spareCategory';
  static const String price = 'price';
  static const String sparePartImage = 'sparePartImage';
  static const String writeText = 'writeText';
  static const String imageSizeNote = 'imageSizeNote';
  static const String productDetails = 'productDetails';
  static const String totalPartsInStock = 'totalPartsInStock';
  static const String numberOfSizesIfAvailable = 'numberOfSizesIfAvailable';

  static const String mobileServices = 'mobileServices';
  static const String towTruckRequest = 'towTruckRequest';
  static const String highwayService = 'highwayService';
  static const String selectCarModelByServices = 'selectCarModelByServices';
  static const String multipleCarSelectionNote = 'multipleCarSelectionNote';
  static const String searchCarModel = 'searchCarModel';
  static const String chooseCategory = 'chooseCategory';
  static const String selectModelYears = 'selectModelYears';
  static const String carCategory = 'carCategory';
  static const String addCarModel = 'addCarModel';

  static const String transferCarToAnotherUser = 'transferCarToAnotherUser';
  static const String yourPassword = 'yourPassword';
  static const String newUserEmailOrPhone = 'newUserEmailOrPhone';
  static const String reasonForTransfer = 'reasonForTransfer';
  static const String transferNotice = 'transferNotice';
  static const String completeTransfer = 'completeTransfer';
  static const String waitingForNewUserApproval = 'waitingForNewUserApproval';
  static const String carTransferredToNewOwner = 'carTransferredToNewOwner';
  static const String transferYourNewCar = 'transferYourNewCar';

  static const String allNotifications = 'allNotifications';

  static const String searchFrom = 'searchFrom';
  static const String to = 'to';

  static const String allOrders = 'allOrders';
  static const String ordersListFromServices = 'ordersListFromServices';
  static const String newOrders = 'newOrders';
  static const String completedOrders = 'completedOrders';
  static const String search = 'search';

  static const String confirm = 'confirm';
  static const String cancel = 'cancel';

  static const String logout = 'logout_dashboard';
  static const String confirmLogout = 'confirmLogout';

  static const String oils = 'oils';
  static const String allChanges = 'allChanges';

  static const String allReviews = 'allReviews';
  static const String reviewsListForAllServices = 'reviewsListForAllServices';
  static const String totalReviews = 'totalReviews';

  static const providersTermsAndConditions = 'providersTermsAndConditions';
  static const providersPrivacyPolicy = 'providersPrivacyPolicy';
  static const aboutSunIntro = 'aboutSunIntro';

  static const String contactAndPoliciesPages = 'contactAndPoliciesPages';
  static const String contactUs = 'establishment_data';
  static const String aboutSun = 'about_sun_emp';
  static const String privacyPolicy = 'privacy_policy_emp';
  static const String termsAndConditions = 'termsAndConditions';
  static const String sendUsMessage = 'sendUsMessage';
  static const String name = 'name';
  static const String messageText = 'messageText';
  static const String send = 'send';

  static const String advertisements =
      'meteorological_Department_And_Business_Features_And_Profits';
  static const String bannerImage = 'bannerImage';
  static const String bannerSizeNote = 'bannerSizeNote';
  static const String uploadImage = 'uploadImage';
  static const String link = 'link';
  static const String category = 'category';
  static const String storeOffers = 'storeOffers';
  static const String durationFromTo = 'durationFromTo';
  static const String createBannerAd = 'createBannerAd';

  static const String monthly = 'monthly';
  static const String daily = 'daily';

  static const String selectTime = 'selectTime';
  static const String newRequests = 'newRequests';
  static const String newRequestsList = 'newRequestsList';
  static const String noRequests = 'noRequests';
  static const String internalServicesStats = 'internalServicesStats';
  static const String weekly = 'weekly';
  static const String internalServicesProfit = 'internalServicesProfit';
  static const String internalServicesRating = 'internalServicesRating';
  static const String afterReceivingRequests = 'afterReceivingRequests';
  static const String jobName = 'jobName';
  static const String requestStatus = 'requestStatus';
  static const String underService = 'underService';
  static const String requestDate = 'requestDate';
  static const String servicePrice = 'servicePrice';
  static const String delivered = 'delivered';
  static const String requestRejected = 'requestRejected';
  static const String newRequest = 'newRequest';

  static const String addNewUser = 'addNewUser';
  static const String userPermissionsSettings = 'userPermissionsSettings';
  static const String employeeName = 'employeeName';
  static const String jobTitle = 'jobTitle';
  static const String accountStatus = 'accountStatus';
  static const String active = 'active';
  static const String inactive = 'inactive';
  static const String picture = 'picture';
  static const String uploadPicture = 'uploadPicture';
  static const String userPermissions = 'userPermissions';
  static const String statistics = 'statistics';
  static const String servicesSettings = 'servicesSettings';
  static const String carModelSettings = 'carModelSettings';
  static const String accountManagement = 'accountManagement';
  static const String permissionsManagement = 'permissionsManagement';
  static const String organizationManagement = 'organizationManagement';
  static const String permissionsFromServices = 'permissionsFromServices';
  static const String maintenanceServices = 'maintenanceServices';

  static const String nissanServiceSettings = 'nissanServiceSettings';
  static const String serviceSettingsDetails = 'serviceSettingsDetails';
  static const String backToSettings = 'backToSettings';
  static const String internalServices = 'internalServices';
  static const String addServices = 'addServices';
  static const String mobileAndTransportServices = 'mobileAndTransportServices';
  static const String carSpareParts = 'carSpareParts';
  static const String sharedPackages = 'sharedPackages';
  static const String serviceSettings = 'serviceSettings';
  static const String addInternalServices = 'addInternalServices';
  static const String allCategories = 'allCategories';
  static const String unifiedPriceForAll = 'unifiedPriceForAll';
  static const String pricePerCategory = 'pricePerCategory';
  static const String sar = 'sar';
  static const String add = 'add';
  static const String carWash = 'carWash';
  static const String battery = 'battery';
  static const String back = 'back';
  static const String save = 'save';

  ////End////

  ////Change the glass////
  static const String frontGlassReplacement = 'frontGlassReplacement';
  static const String sideGlassReplacement = 'sideGlassReplacement';
  static const String frontGlass = 'frontGlass';

  ////End////

  ////Change tires////
  static const String tireBalancing = 'tireBalancing';
  static const String wheelAlignment = 'wheelAlignment';

  ////End////

  ////Delivery laundry////
  static const String packages = 'packages';
  static const String goldPackage = 'goldPackage';
  static const String premiumPackage = 'premiumPackage';
  static const String fullCleaning = 'fullCleaning';
  static const String interiorPolishing = 'interiorPolishing';
  static const String writeNotes = 'writeNotes';
  static const String sendRequest = 'sendRequest';
  static const String requestAccepted = 'requestAccepted';
  static const String highwayServiceCompleted = 'highwayServiceCompleted';
  static const String searchYourAddress = 'searchYourAddress';
  static const String confirmCarLocation = 'confirmCarLocation';
  static const String pleaseSelectCarLocation = 'pleaseSelectCarLocation';

  ////End////

  ////Car Batteries////
  static const String glassReplacement = 'glassReplacement';
  static const String hour = 'hour';
  static const String mobile = 'mobile';
  static const String sharedServices = 'sharedServices';
  static const String sparePartsAndProducts = 'sparePartsAndProducts';
  static const String reviews = 'reviews';
  static const String viewReviews = 'viewReviews';
  static const String bookService = 'bookService';
  static const String newItem = 'newItem';
  static const String selectServices = 'selectServices';
  static const String confirmService = 'confirmService';
  static const String confirmBookingTime = 'confirmBookingTime';
  static const String selectDay = 'selectDay';
  static const String selectHour = 'selectHour';
  static const String confirmServiceBooking = 'confirmServiceBooking';
  static const String appointment = 'appointment';
  static const String coupon = 'coupon';
  static const String apply = 'apply';

  ////End////

  ////Order list////
  static const String createNewRequest = 'createNewRequest';
  static const String requestReceived = 'requestReceived';
  static const String onTheWayToYou = 'onTheWayToYou';
  static const String cancelBooking = 'cancelBooking';
  static const String rateService = 'rateService';
  static const String writeComment = 'writeComment';
  static const String addYourComment = 'addYourComment';

  ////end////

  ////Request - Service////
  static const String selectServiceType = 'selectServiceType';
  static const String roadService = 'roadService';
  static const String serviceDetails = 'serviceDetails';
  static const String desiredServicePrice = 'desiredServicePrice';
  static const String serviceCompletionTime = 'serviceCompletionTime';
  static const String selectCurrentLocation = 'selectCurrentLocation';
  static const String createServiceRequest = 'createServiceRequest';
  static const String saturday = 'saturday';
  static const String sunday = 'sunday';
  static const String monday = 'monday';
  static const String tuesday = 'tuesday';
  static const String wednesday = 'wednesday';
  static const String thursday = 'thursday';
  static const String friday = 'friday';
  static const String serviceCenterOffers = 'serviceCenterOffers';
  static const String mobileMaintenanceOffer = 'mobileMaintenanceOffer';
  static const String repairCenterName = 'repairCenterName';
  static const String acceptOffer = 'acceptOffer';
  static const String rejectRequest = 'rejectRequest';
  static const String withinOneDay = 'withinOneDay';
  static const String requestNumber = 'requestNumber';
  static const String daysAgo = 'daysAgo';
  static const String expectedArrival = 'expectedArrival';
  static const String notes = 'notes';
  static const String contactMaintenanceRep = 'contactMaintenanceRep';
  static const String maintenanceRep = 'maintenanceRep';
  static const String trackTechnician = 'trackTechnician';
  static const String openMap = 'openMap';
  static const String payBill = 'payBill';
  static const String brakeRepair = 'brakeRepair';
  static const String electricalRepair = 'electricalRepair';
  static const String totalServices = 'totalServices';
  static const String mobileService = 'mobileService';
  static const String serviceRequest = 'serviceRequest';
  static const String serviceProvidersArrival = 'serviceProvidersArrival';
  static const String serviceCompleted = 'serviceCompleted';
  static const String serviceRating = 'serviceRating';
  static const String notRatedYet = 'notRatedYet';

  ////End////

  ////Change Car////
  static const String myCarData = 'myCarData';
  static const String myCar = 'myCar';
  static const String setAsPrimaryCar = 'setAsPrimaryCar';
  static const String wifeCar = 'wifeCar';
  static const String replaceCarAsAccount = 'replaceCarAsAccount';
  static const String mySecondCar = 'mySecondCar';
  static const String carBills = 'carBills';
  static const String carOwner = 'carOwner';
  static const String carChassisNumber = 'carChassisNumber';
  static const String carLicense = 'carLicense';
  static const String carFiles = 'carFiles';
  static const String transferCar = 'transferCar';
  static const String deleteCar = 'deleteCar';

  ////END////

  ////Wallet- Bonus - Send code to friend////
  static const String wallet = 'wallet';
  static const String currentBalance = 'currentBalance';
  static const String rechargeWallet = 'rechargeWallet';
  static const String walletTransactionDetails = 'walletTransactionDetails';
  static const String viewAll = 'viewAll';
  static const String bonusBalance = 'bonusBalance';
  static const String payMaintenanceService = 'payMaintenanceService';
  static const String rechargeFromVisa = 'rechargeFromVisa';
  static const String points = 'points';
  static const String myPoints = 'myPoints';
  static const String pointsDetails = 'pointsDetails';
  static const String bonusPoints = 'bonusPoints';
  static const String redeemPointsService = 'redeemPointsService';
  static const String rechargeFromVisaPoints = 'rechargeFromVisaPoints';
  static const String inviteFriendText = 'inviteFriendText';
  static const String referralCode = 'referralCode';
  static const String copyCode = 'copyCode';
  static const String shareLink = 'shareLink';
  static const String sendToFriend = 'sendToFriend';
  static const String codeCopiedSuccessfully = 'codeCopiedSuccessfully';

  ////End////

  ////Warranty////
  static const String warrantyPeriod = 'warrantyPeriod';
  static const String warrantyServiceCenters = 'warrantyServiceCenters';
  static const String warrantyCarsMarket = 'warrantyCarsMarket';
  static const String warrantyFreeMaintenance = 'warrantyFreeMaintenance';
  static const String warrantySubscription = 'warrantySubscription';
  static const String balanceChargedSuccessfully = 'balanceChargedSuccessfully';
  static const String showServicesAtApprovedCenters =
      'showServicesAtApprovedCenters';

  ////End////

  ////Profile////
  static const String notifications = 'notifications';
  static const String newMessage = 'newMessage';
  static const String order255Expired = 'order255Expired';
  static const String onTheWay = 'onTheWay';
  static const String privacyTitle = 'privacyTitle';
  static const String privacyIntro = 'privacyIntro';
  static const String personalData = 'personalData';
  static const String username = 'username';
  static const String nationality = 'nationality';
  static const String language = 'language';
  static const String arabic = 'arabic';
  static const String english = 'english';
  static const String myAddress = 'myAddress';
  static const String yourCarAddress = 'yourCarAddress';
  static const String addAddress = 'addAddress';
  static const String creditCards = 'creditCards';
  static const String cardName = 'cardName';
  static const String cardNumber = 'cardNumber';
  static const String cvv = 'cvv';
  static const String expiryDate = 'expiryDate';
  static const String addPaymentCard = 'addPaymentCard';
  static const String financialTransactions = 'financialTransactions';
  static const String tires = 'tires';
  static const String qrCode = 'qrCode';
  static const String scanQrCode = 'scanQrCode';

  ////End////

  ////InsuranceNew////
  static const String selectInsuranceType = 'selectInsuranceType';
  static const String integrativeInsurance = 'integrativeInsurance';
  static const String carModel = 'carModel';
  static const String edit = 'edit';
  static const String sixMonthlyPayments = 'sixMonthlyPayments';
  static const String twelveMonthlyPayments = 'twelveMonthlyPayments';
  static const String semiAnnual = 'semiAnnual';
  static const String annual = 'annual';
  static const String insuranceAccountRegistration =
      'insuranceAccountRegistration';
  static const String firstPayment = 'firstPayment';

  ////End////

  ////Insurance////
  static const String insuranceOffers = 'insuranceOffers';
  static const String insuranceOffersOnly = 'insuranceOffers';
  static const String comprehensiveInsurance = 'comprehensiveInsurance';
  static const String thirdPartyInsurance = 'thirdPartyInsurance';
  static const String bestOffer = 'bestOffer';
  static const String scienceInsurance = 'scienceInsurance';
  static const String annualPayment = 'annualPayment';
  static const String cooperativeInsurance = 'cooperativeInsurance';
  static const String enterPolicyData = 'enterPolicyData';
  static const String policyNumber = 'policyNumber';
  static const String identityVerification = 'identityVerification';
  static const String checkAbsherAccount = 'checkAbsherAccount';
  static const String loginViaAbsher = 'loginViaAbsher';
  static const String nationalIdOrIqama = 'nationalIdOrIqama';
  static const String verifyAbsher = 'verifyAbsher';
  static const String yourInsuranceData = 'yourInsuranceData';
  static const String beneficiaryName = 'beneficiaryName';
  static const String insurancePolicyNumber = 'insurancePolicyNumber';
  static const String nationalIdNumber = 'nationalIdNumber';
  static const String carPlateNumber = 'carPlateNumber';
  static const String chassisNumber = 'chassisNumber';
  static const String insuranceType = 'insuranceType';
  static const String insuranceValue = 'insuranceValue';
  static const String installmentValue = 'installmentValue';
  static const String linkInsuranceWithSanad = 'linkInsuranceWithSanad';
  static const String pleaseWait = 'pleaseWait';
  static const String policyData = 'policyData';
  static const String annualPayments = 'annualPayments';
  static const String firstInstallment = 'firstInstallment';
  static const String paid = 'paid';
  static const String details = 'details';
  static const String secondInstallment = 'secondInstallment';
  static const String thirdInstallment = 'thirdInstallment';
  static const String payInstallment = 'payInstallment';
  static const String notPaid = 'notPaid';
  static const String fourthInstallment = 'fourthInstallment';
  static const String nextInstallmentJuly = 'nextInstallmentJuly';
  static const String nextInstallmentAugust = 'nextInstallmentAugust';
  static const String invoice = 'invoice';
  static const String insuranceInstallment = 'insuranceInstallment';
  static const String taxes = 'taxes';
  static const String total = 'total';
  static const String paymentMethod = 'paymentMethod';
  static const String payment = 'payment';
  static const String selectPaymentOptionFirst = 'selectPaymentOptionFirst';
  static const String thirdInstallmentDetails = 'thirdInstallmentDetails';
  static const String paidBy = 'paidBy';
  static const String enterYourData = 'enterYourData';
  static const String waitingForOffers = 'waitingForOffers';

  ////End////

  static const String startNow = 'Start now';

  static const String yourCarIsSafeWithSan = 'Your car is safe with San';

  static const String maintenanceAndRepairServices =
      'Maintenance and repair services';

  static const String emergencyService = 'Emergency service';

  static const String buyingAndSellingCars = 'Buying and selling cars';

  static const String listYourCarInASafeAndReliableAuctionWithSan =
      'List your car in a safe and reliable auction with San';
  static const String highwayAssistance =
      '24/7 Highway Assistance Wherever You Are';

  static const String weSendYouProfessional =
      'We send you professional technicians who diagnose and fix the problem.';
  static const String integratedSolutions =
      'Integrated solutions for warranty and insurance for all services in one place';

  static const String password = 'Password';

  static const String forgetPassword = 'Forget_Password';

  static const String dontHaveAccount = 'Dont_have_account';

  static const String login = 'Login';

  static const String loginAsAnIndividualOrCompany =
      'Log in as an individual or company';
  static const String registerAsAnIndividual = 'Register as an individual';
  static const String registerAsCompanies = 'Register as companies';
  static const String orRegisterVia = 'Or register via';
  static const String appleAccount = 'Apple account';
  static const String googleAccount = 'Google';
  static const String noAccount = "You don't have an account";
  static const String registerHere = 'Register here';
  static const String pleaseEnterYourPhoneNumberAndPassword =
      'Please enter your phone number and password.';
  static const String phoneNumber = 'phone number';
  static const String forgotPassword = 'forgot my password';
  static const String redeemFromHere = 'Redeem from here';
  static const String loginAsAGuestUser = 'Login as a guest user';
  static const String userName = 'user name';
  static const String email = 'Email';
  static const String resetPassword = 'Reset password';
  static const String createAnAccount = 'Create an account';
  static const String yourName = 'Your name';
  static const String accountInformation =
      'Please enter your account information and password.';
  static const String createAnAccountInTheNameOfACompany =
      'Create an account in the name of a company';
  static const String confirmPin = 'Confirm PIN';
  static const String pleaseEnterThePinSentToYourPhoneNumber =
      'Please enter the PIN sent to your phone number';
  static const String iDidNotReceiveAMessage = 'I did not receive a message';
  static const String resend = 'Resend';
  static const String yourCarData = 'your car data';
  static const String toViewYourCarsModelsServicesAndCenters =
      "To view your car's api_functions's services and centers";
  static const String chooseTheCategory = "Choose the category";
  static const String modelYear = "Model year";
  static const String yourCarName = "Your car name";
  static const String exampleModelName = "(Example: My Honda - My wife's car)";
  static const String chooseYourCarModel = 'Choose your car api_functions';
  static const String youCanSearchToSelectYourCarCategory =
      'You can search to select your car category';
  static const String profile = 'Profile';
  static const String skipLater = 'Skip later';
  static const String next = 'Next';
  static const String locationServiceDisabled = 'Location service is disabled';
  static const String locationNotFound = 'Location not found';
  static const String yourLocation = 'Your location';
  static const String nearbyServices = 'Nearby services';
  static const String maintenanceAndRepair = 'Maintenance and repair';
  static const String oilChange = 'Oil change';
  static const String highways = 'Highways';
  static const String carElectricity = 'Car electricity';
  static const String spareParts = 'Spare parts';
  static const String mobileMaintenance = 'Mobile maintenance';
  static const String carAuction = 'Car auction';
  static const String transportService = 'Transport service';
  static const String favoriteServices = 'Favorite services';
  static const String selectFavoriteServices =
      'You can select favorite services';
  static const String chooseFavoriteServices = 'Choose favorite services';
  static const String congratulations = 'Congratulations, you got';
  static const String gift = 'Gift';
  static const String sunWarranty = 'Sun warranty';
  static const String fiveYearsWarranty = '5 years warranty gift';
  static const String showServicesNow = 'Show services now';
  static const String sunWarrantyFeatures = 'Sun warranty features';
  static const String warrantyCenters =
      'Benefit from warranty at our authorized centers';
  static const String carWarrantyAuction =
      'Car warranty in car auction (buy/sell)';
  static const String freeMaintenance =
      'Free maintenance services during warranty period';
  static const String home = 'Home';
  static const String myOrders = 'My orders';
  static const String map = 'Map';
  static const String requestService = 'Request a service';
  static const String services = 'Services';
  static const String searchPlaceholder =
      'Search for any service, center name, or anything';
  static const String tireSpareParts = 'Tire spare parts';
  static const String discount50 = '50% discount';
  static const String discount = 'discount';
  static const String variousServices = 'Various services';
  static const String repairAndMaintenance = 'Repair and maintenance';
  static const String oilServices = 'Oil services';
  static const String cleaningAndWashing = 'Cleaning and washing';
  static const String carInsurance = 'Car insurance';
  static const String carMarket = 'Car market';
  static const String periodicMaintenance = 'Periodic maintenance';
  static const String sparePartsService = 'Spare parts service';
  static const String carWarranty = 'Car warranty';
  static const String glass = 'Glass';
  static const String tireChange = 'Tire change';
  static const String batteries = 'Batteries';
  static const String roadAssistance = 'Road assistance';
  static const String from = "from";
}
