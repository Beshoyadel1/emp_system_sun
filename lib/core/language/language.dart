import 'package:flutter/material.dart';

import 'language_constant.dart';

List<Locale> supportedLocales = [
  const Locale('ar', 'SA'),
  const Locale('en', 'US'),
];

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static final Map<String, Map<String, String>> _localizedValues = {
    'ar': {
      //status//
      AppLanguageKeys.notSold: 'لم يتم البيع',
      AppLanguageKeys.sold: 'تم البيع',
      AppLanguageKeys.newCar: 'جديدة',
      AppLanguageKeys.usedCar: 'مستعملة',
      AppLanguageKeys.newOrderForCompany: 'طلب جديد',
      AppLanguageKeys.rejectedByCompany: 'تم الرفض من الشركة',
      AppLanguageKeys.newOrderForProvider: 'طلب جديد',
      AppLanguageKeys.waitingAppointment: 'انتظار الموعد',
      AppLanguageKeys.employeeInRound: 'في الطريق',
      AppLanguageKeys.workInProgress: 'قيد التنفيذ',
      AppLanguageKeys.orderCompleted: 'تم التسليم',
      AppLanguageKeys.rejectedByProvider: 'تم الرفض من المزود',
      AppLanguageKeys.cancelledByUser: 'تم الإلغاء من العميل',
      //END//

      //others//
      AppLanguageKeys.oldService: 'خدمة سابقة',
      AppLanguageKeys.createService: 'إنشاء خدمة',
      AppLanguageKeys.serviceNameAr: 'اسم الخدمة (عربي)',
      AppLanguageKeys.serviceNameEn: 'اسم الخدمة (إنجليزي)',
      AppLanguageKeys.restAll: 'إعادة تعيين الكل',
      AppLanguageKeys.selectPricingTypeFirst : "اختار نوع التسعير الأول",
      AppLanguageKeys.cost: 'التكلفة',
      AppLanguageKeys.confirmDelete: 'هل أنت متأكد أنك تريد حذف هذا العنصر؟',
      AppLanguageKeys.description: 'الوصف',
      AppLanguageKeys.mileage: 'عدد الكيلومترات',
      AppLanguageKeys.carStatus: 'حالة السيارة',
      AppLanguageKeys.emailOrPhoneInvalid: 'البريد الإلكتروني أو رقم الهاتف غير صحيح أو غير نشط',
      AppLanguageKeys.phoneInvalid: 'رقم الهاتف غير صحيح أو غير نشط',
      AppLanguageKeys.userNotFound: 'المستخدم غير موجود',
      AppLanguageKeys.wrongCode: 'رمز غير صحيح',
      AppLanguageKeys.loginFailed: 'فشل تسجيل الدخول',
      AppLanguageKeys.enterOtp: 'أدخل رمز مكون من 4 أرقام',
      AppLanguageKeys.verify: 'تحقق',
      AppLanguageKeys.subscriptionEndDate: 'تاريخ انتهاء الاشتراك',
      AppLanguageKeys.subscriptionStartDate: 'تاريخ بدء الاشتراك',
      AppLanguageKeys.annualPrice: 'السعر السنوي',
      AppLanguageKeys.monthlyPrice: 'السعر الشهري',
      AppLanguageKeys.invoiceServices: 'الخدمات الخاصة بالفاتورة',
      AppLanguageKeys.transferDate: 'تاريخ التحويل',
      AppLanguageKeys.ordersCommission: 'عمولة الطلبات',
      AppLanguageKeys.netBalance: 'صافي الرصيد',
      AppLanguageKeys.allPayments: 'جميع المدفوعات',
      AppLanguageKeys.cardPayments: 'المدفوعات بالبطاقة الائتمانية',
      AppLanguageKeys.cashOnDeliveryPayments: 'المدفوعات بالاستلام نقدا',
      AppLanguageKeys.packageType: 'نوع الباقة',
      AppLanguageKeys.subscriptionDuration: 'مدة الاشتراك',
      AppLanguageKeys.subscriptionFee: 'رسوم الاشتراك',
      AppLanguageKeys.nextSubscriptionDate: 'تاريخ الاشتراك القادم',
      AppLanguageKeys.downloadInvoice: 'تنزيل الفاتورة',
      AppLanguageKeys.transactionNumber: 'رقم العملية',
      AppLanguageKeys.invoiceDate: 'تاريخ الفاتورة',
      AppLanguageKeys.orderStatus: 'حالة الطلب',
      AppLanguageKeys.transactionDetails: 'تفاصيل العملية',
      AppLanguageKeys.latinName: 'الاسم اللاتيني',
      AppLanguageKeys.items: 'العناصر',
      AppLanguageKeys.create: 'إنشاء',
      AppLanguageKeys.carMarketSales: 'مبيعات حراج سيارات',
      AppLanguageKeys.rejectionReason: 'سبب رفض الطلب',
      AppLanguageKeys.orderInProgress: 'جاري تنفيذ الطلب',
      AppLanguageKeys.waitingForInvoicePayment: 'انتظار دفع الفاتورة',
      AppLanguageKeys.carsListCurrentAndSold: 'قائمة السيارات من السيارات الحالية والمباعة سابقاً',
      AppLanguageKeys.soldCars: 'سيارة مباعة',
      AppLanguageKeys.carList: 'قائمة السيارات',
      AppLanguageKeys.availableCarsShortList: 'قائمة مختصرة من السيارات المتاحة',
      AppLanguageKeys.filling: 'التعبئة',
      AppLanguageKeys.fillingDate: 'تاريخ التعبئة',
      AppLanguageKeys.gender: 'الجنس',
      AppLanguageKeys.age: 'العمر',
      AppLanguageKeys.order: 'طلب',
      AppLanguageKeys.authCompanyNameRequired: 'اسم الشركة مطلوب',
      AppLanguageKeys.authEmailRequired: 'البريد الإلكتروني مطلوب',
      AppLanguageKeys.authEnterCorrectEmail: 'يرجى إدخال بريد إلكتروني صحيح',
      AppLanguageKeys.authPasswordRequired: 'كلمة المرور مطلوبة',
      AppLanguageKeys.authWeakPassword: 'كلمة المرور ضعيفة',
      AppLanguageKeys.authPhoneNumberRequired: 'رقم الجوال مطلوب',
      AppLanguageKeys.authEnterCorrectPhoneNumber: 'يرجى إدخال رقم جوال صحيح',
      AppLanguageKeys.createNewPassword: 'إنشاء كلمة مرور جديدة',
      //end//
      //message api response//
      AppLanguageKeys.passwordsDoNotMatch: 'كلمتا المرور غير متطابقتين',
      AppLanguageKeys.wrongUsername: 'اسم المستخدم غير صحيحة',
      AppLanguageKeys.somethingWentWrong: 'حدث خطأ ما',
      AppLanguageKeys.emailExist: 'البريد الإلكتروني موجود بالفعل',
      AppLanguageKeys.emailNotExist: 'البريد الإلكتروني غير موجود',
      AppLanguageKeys.phoneExist: 'رقم الهاتف موجود بالفعل',
      AppLanguageKeys.emailOrPhoneExist: 'البريد الإلكتروني أو رقم الهاتف موجود بالفعل',
      AppLanguageKeys.done: 'تمت العملية بنجاح',
      AppLanguageKeys.notFound: 'غير موجود',
      AppLanguageKeys.storeNotExist: 'المتجر غير موجود',
      AppLanguageKeys.noUser: 'المستخدم غير موجود',
      AppLanguageKeys.wrongPassword: 'كلمة المرور غير صحيحة',
      AppLanguageKeys.notActive: 'الحساب غير مفعل',
      AppLanguageKeys.sameUser: 'لا يمكن تنفيذ العملية على نفس المستخدم',
      AppLanguageKeys.notEnoughPoints: 'النقاط غير كافية',
      AppLanguageKeys.notEnoughBalance: 'الرصيد غير كافٍ',
      AppLanguageKeys.reservedUser: 'المستخدم محجوز',
      AppLanguageKeys.haveOperationForDelete: 'لا يمكن الحذف لوجود عمليات مرتبطة',
      AppLanguageKeys.wrongReferralCode: 'كود الإحالة غير صحيح',
      AppLanguageKeys.empty: 'لا توجد بيانات',
      AppLanguageKeys.expired: 'منتهي الصلاحية',
      AppLanguageKeys.couponReachMaxUse: 'تم الوصول للحد الأقصى لاستخدام الكوبون',
      AppLanguageKeys.userReachMaxUseCoupon: 'وصل المستخدم للحد الأقصى لاستخدام الكوبون',
      AppLanguageKeys.pointsFromNewOrder: 'تمت إضافة نقاط من طلب جديد',
      AppLanguageKeys.categoryExist: 'التصنيف موجود بالفعل',
      //End//

      //Api Failures//
      AppLanguageKeys.oopsErrorTryAgain: 'عذراً، حدث خطأ ما، يرجى المحاولة مرة أخرى.',
      AppLanguageKeys.internalServerError: 'خطأ في الخادم الداخلي، يرجى المحاولة لاحقاً.',
      AppLanguageKeys.requestNotFound: 'لم يتم العثور على طلبك، يرجى المحاولة لاحقاً!',
      AppLanguageKeys.badResponseError: 'استجابة غير صحيحة، حدث خطأ ما.',
      AppLanguageKeys.success: 'تمت العملية بنجاح',
      AppLanguageKeys.badRequestError: 'طلب غير صالح',
      AppLanguageKeys.unauthorizedError: 'غير مصرح بالوصول',
      AppLanguageKeys.forbiddenError: 'الوصول مرفوض',
      AppLanguageKeys.methodNotAllowed: 'الطريقة غير مسموح بها',
      AppLanguageKeys.requestTimeout: 'انتهت مهلة الطلب',
      AppLanguageKeys.conflictError: 'حدث تعارض في الطلب',
      AppLanguageKeys.validationError: 'خطأ في التحقق من البيانات',
      AppLanguageKeys.tooManyRequests: 'طلبات كثيرة جداً، حاول لاحقاً',
      AppLanguageKeys.badGateway: 'بوابة غير صالحة',
      AppLanguageKeys.serviceUnavailable: 'الخدمة غير متاحة حالياً',
      AppLanguageKeys.gatewayTimeout: 'انتهت مهلة البوابة',
      AppLanguageKeys.noInternetConnection: 'لا يوجد اتصال بالإنترنت',

      //End//

      //login//
      AppLanguageKeys.fillAllFields: 'من فضلك قم بملء جميع الحقول',
      AppLanguageKeys.enterUsernameAndPassword: 'من فضلك أدخل اسم المستخدم وكلمة المرور',
      //End//

      //Model Messages//
      AppLanguageKeys.changePasswordSuccessfully: 'تم تغيير كلمة المرور بنجاح',
      AppLanguageKeys.checkIfUserExistSuccessfully: 'تم التحقق من وجود المستخدم بنجاح',
      AppLanguageKeys.checkIfUserExistOrNotSuccessfully: 'تم التحقق من وجود المستخدم أو عدمه بنجاح',
      AppLanguageKeys.accountCreatedSuccessfully: 'تم إنشاء الحساب بنجاح',
      AppLanguageKeys.deleteUserSuccessfully: 'تم حذف المستخدم بنجاح',
      AppLanguageKeys.getAppUserInfoSuccessfully: 'تم جلب معلومات مستخدم التطبيق بنجاح',
      AppLanguageKeys.accountLoginSuccessfully: 'تم تسجيل الدخول بنجاح',
      AppLanguageKeys.restoreUserSuccessfully: 'تم استرجاع المستخدم بنجاح',
      AppLanguageKeys.updateUserSuccessfully: 'تم تحديث المستخدم بنجاح',

      AppLanguageKeys.changeCouponStatusSuccessfully: 'تم تغيير حالة الكوبون بنجاح',
      AppLanguageKeys.getCarSuccessfully: 'تم جلب بيانات السيارة بنجاح',
      AppLanguageKeys.getCouponByCodeSuccessfully: 'تم جلب الكوبون بواسطة الكود بنجاح',
      AppLanguageKeys.getStaticsForCouponSuccessfully: 'تم جلب إحصائيات الكوبون بنجاح',
      AppLanguageKeys.uploadCouponSuccessfully: 'تم رفع الكوبون بنجاح',

      AppLanguageKeys.createRateSuccessfully: 'تم إنشاء التقييم بنجاح',
      AppLanguageKeys.deleteRateSuccessfully: 'تم حذف التقييم بنجاح',
      AppLanguageKeys.getProviderDetailsRatesSuccessfully:
          'تم جلب تفاصيل تقييمات مزود الخدمة بنجاح',
      AppLanguageKeys.getProvidersBasicRateSuccessfully:
          'تم جلب التقييم الأساسي لمزود الخدمة بنجاح',
      AppLanguageKeys.updateRateSuccessfully: 'تم تحديث التقييم بنجاح',

      AppLanguageKeys.createServiceSuccessfully: 'تم إنشاء الخدمة بنجاح',
      AppLanguageKeys.uploadServiceSuccessfully: 'تم رفع الخدمة بنجاح',

      AppLanguageKeys.getAdminDashboardStatisticsSuccessfully:
          'تم جلب إحصائيات لوحة تحكم الإدارة بنجاح',
      AppLanguageKeys.getAdminMostRequestedServicesSuccessfully:
          'تم جلب أكثر الخدمات طلباً بنجاح',
      AppLanguageKeys.getCompanyCarGroupChartSuccessfully:
          'تم جلب مخطط مجموعات سيارات الشركة بنجاح',
      AppLanguageKeys.getCompanyGeneralStatisticsSuccessfully:
          'تم جلب الإحصائيات العامة للشركة بنجاح',
      AppLanguageKeys.getMaintenanceReportSuccessfully:
          'تم جلب تقرير الصيانة بنجاح',
      AppLanguageKeys.getProviderHarageMonthlySalesSuccessfully:
          'تم جلب مبيعات حراج مزود الخدمة الشهرية بنجاح',
      AppLanguageKeys.getProviderHarageSalesChartSuccessfully:
          'تم جلب مخطط مبيعات حراج مزود الخدمة بنجاح',
      AppLanguageKeys.getProviderHarageSoldCarsByTypeSuccessfully:
          'تم جلب السيارات المباعة حسب النوع في حراج مزود الخدمة بنجاح',
      AppLanguageKeys.getProviderMainServiceStatisticsSuccessfully:
          'تم جلب إحصائيات الخدمة الرئيسية لمزود الخدمة بنجاح',
      AppLanguageKeys.getProviderOrdersSalesSuccessfully:
          'تم جلب مبيعات طلبات مزود الخدمة بنجاح',
      AppLanguageKeys.getProviderPetrolBranchesSalesSuccessfully:
          'تم جلب مبيعات فروع الوقود لمزود الخدمة بنجاح',
      AppLanguageKeys.getProviderPetrolSalesChartSuccessfully:
          'تم جلب مخطط مبيعات الوقود لمزود الخدمة بنجاح',
      AppLanguageKeys.getProviderServiceStatisticsSuccessfully:
          'تم جلب إحصائيات خدمات مزود الخدمة بنجاح',
      AppLanguageKeys.getProviderTotalRateEmployeeBalanceSuccessfully:
          'تم جلب إجمالي التقييم وعدد الموظفين والرصيد لمزود الخدمة بنجاح',

      AppLanguageKeys.createProductSuccess: 'تم إنشاء المنتج بنجاح',
      AppLanguageKeys.deleteProductSuccess: 'تم حذف المنتج بنجاح',
      AppLanguageKeys.getProductSuccess: 'تم جلب المنتج بنجاح',
      AppLanguageKeys.getProductsSuitableForCarSuccess:
          'تم جلب المنتجات المناسبة للسيارة بنجاح',
      AppLanguageKeys.updateProductSuccess: 'تم تحديث المنتج بنجاح',

      AppLanguageKeys.addBranchSuccess: 'تم إضافة الفرع بنجاح',
      AppLanguageKeys.createExpectedPetrolSpendSuccess:
          'تم إنشاء مصروف الوقود المتوقع بنجاح',
      AppLanguageKeys.createProvServiceSuccess:
          'تم إنشاء خدمة مزود الخدمة بنجاح',
      AppLanguageKeys.createServicePackageSuccess: 'تم إنشاء باقة الخدمة بنجاح',
      AppLanguageKeys.deleteExpectedPetrolSpendSuccess:
          'تم حذف مصروف الوقود المتوقع بنجاح',
      AppLanguageKeys.deleteProvServiceSuccess: 'تم حذف خدمة مزود الخدمة بنجاح',
      AppLanguageKeys.deleteProviderWorkTimeSuccess:
          'تم حذف وقت عمل مزود الخدمة بنجاح',
      AppLanguageKeys.deleteServicePackageSuccess: 'تم حذف باقة الخدمة بنجاح',
      AppLanguageKeys.getBranchEmployeesSuccess: 'تم جلب موظفي الفرع بنجاح',
      AppLanguageKeys.getExpectedPetrolSpendSuccess:
          'تم جلب مصروف الوقود المتوقع بنجاح',
      AppLanguageKeys.getProviderBranchesSuccess:
          'تم جلب فروع مزود الخدمة بنجاح',
      AppLanguageKeys.getProviderServicePackagesSuccess:
          'تم جلب باقات خدمات مزود الخدمة بنجاح',
      AppLanguageKeys.getProviderWorkTimeSuccess:
          'تم جلب أوقات عمل مزود الخدمة بنجاح',
      AppLanguageKeys.getServiceProviderDetailsForAppUserSuccess:
          'تم جلب تفاصيل مزود الخدمة لمستخدم التطبيق بنجاح',
      AppLanguageKeys.getServiceProvidersByServiceIdForAppUserSuccess:
          'تم جلب مزودي الخدمة حسب الخدمة لمستخدم التطبيق بنجاح',
      AppLanguageKeys.updateBranchSuccess: 'تم تحديث الفرع بنجاح',
      AppLanguageKeys.updateExpectedPetrolSpendSuccess:
          'تم تحديث مصروف الوقود المتوقع بنجاح',
      AppLanguageKeys.updateProvServiceSuccess:
          'تم تحديث خدمة مزود الخدمة بنجاح',
      AppLanguageKeys.updateServicePackageSuccess: 'تم تحديث باقة الخدمة بنجاح',
      AppLanguageKeys.uploadProviderWorkTimesSuccess:
          'تم رفع أوقات عمل مزود الخدمة بنجاح',

      AppLanguageKeys.createHarageSuccessfully: 'تم إنشاء الحراج بنجاح',
      AppLanguageKeys.deleteHarageSuccessfully: 'تم حذف الحراج بنجاح',
      AppLanguageKeys.getAllHarageSuccessfully: 'تم جلب جميع الحراجات بنجاح',
      AppLanguageKeys.getHarageSuccessfully: 'تم جلب الحراج بنجاح',
      AppLanguageKeys.updateHarageSuccessfully: 'تم تحديث الحراج بنجاح',

      AppLanguageKeys.cancelOrderSuccessfully: 'تم إلغاء الطلب بنجاح',
      AppLanguageKeys.createOrderSuccessfully: 'تم إنشاء الطلب بنجاح',
      AppLanguageKeys.getCompanyOrdersSuccessfully: 'تم جلب طلبات الشركة بنجاح',
      AppLanguageKeys.getOrderDetailsSuccessfully: 'تم جلب تفاصيل الطلب بنجاح',
      AppLanguageKeys.getOrdersSuccessfully: 'تم جلب الطلبات بنجاح',
      AppLanguageKeys.getProviderOrdersSuccessfully:
          'تم جلب طلبات مزود الخدمة بنجاح',
      AppLanguageKeys.updateOrderOfferStatusSuccessfully:
          'تم تحديث حالة عرض الطلب بنجاح',
      AppLanguageKeys.updateOrderStatusSuccessfully:
          'تم تحديث حالة الطلب بنجاح',

      AppLanguageKeys.addCardSuccessfully: 'تم إضافة البطاقة بنجاح',
      AppLanguageKeys.createPaymentSuccessfully: 'تم إنشاء عملية الدفع بنجاح',
      AppLanguageKeys.getUserCardsSuccessfully: 'تم جلب بطاقات المستخدم بنجاح',
      AppLanguageKeys.getWalletBalanceSuccessfully: 'تم جلب رصيد المحفظة بنجاح',
      AppLanguageKeys.getWalletTransactionsSuccessfully:
          'تم جلب معاملات المحفظة بنجاح',
      AppLanguageKeys.rechargeWalletSuccessfully: 'تم شحن المحفظة بنجاح',
      AppLanguageKeys.removeCardSuccessfully: 'تم حذف البطاقة بنجاح',
      AppLanguageKeys.setDefaultCardSuccessfully:
          'تم تعيين البطاقة الافتراضية بنجاح',

      AppLanguageKeys.assignServiceToEmployeeSuccessfully:
          'تم تعيين الخدمة للموظف بنجاح',
      AppLanguageKeys.getEmployeeServicesSuccessfully:
          'تم جلب خدمات الموظف بنجاح',

      AppLanguageKeys.addTaxSuccessfully: 'تم إضافة الضريبة بنجاح',
      AppLanguageKeys.createCarBrandSuccessfully:
          'تم إنشاء ماركة السيارة بنجاح',
      AppLanguageKeys.createCarModelSuccessfully:
          'تم إنشاء موديل السيارة بنجاح',
      AppLanguageKeys.deleteTaxSuccessfully: 'تم حذف الضريبة بنجاح',
      AppLanguageKeys.getAllPagesAboutSuccessfully:
          'تم جلب جميع صفحات من نحن بنجاح',
      AppLanguageKeys.getCarBrandModelsSuccessfully:
          'تم جلب موديلات ماركة السيارة بنجاح',
      AppLanguageKeys.getServicesSuccessfully: 'تم جلب الخدمات بنجاح',
      AppLanguageKeys.updateCarBrandSuccessfully:
          'تم تحديث ماركة السيارة بنجاح',
      AppLanguageKeys.updateCarModelSuccessfully:
          'تم تحديث موديل السيارة بنجاح',
      AppLanguageKeys.updatePageAboutSuccessfully: 'تم تحديث صفحة من نحن بنجاح',
      AppLanguageKeys.updateTaxSuccessfully: 'تم تحديث الضريبة بنجاح',
      AppLanguageKeys.uploadPointInfoSuccessfully:
          'تم رفع معلومات النقطة بنجاح',

      AppLanguageKeys.getBannersSuccessfully: 'تم جلب البنرات بنجاح',
      AppLanguageKeys.uploadBannersSuccessfully: 'تم رفع البنرات بنجاح',

      AppLanguageKeys.getOtherMessagesSuccessfully:
          'تم جلب الرسائل الأخرى بنجاح',
      AppLanguageKeys.getUserProviderMessagesSuccessfully:
          'تم جلب رسائل مزود الخدمة بنجاح',
      AppLanguageKeys.getWorkTeamChatSuccessfully:
          'تم جلب محادثات فريق العمل بنجاح',
      AppLanguageKeys.makeChatViewedSuccessfully:
          'تم تعيين المحادثة كمقروءة بنجاح',
      AppLanguageKeys.openCloseChatSuccessfully:
          'تم فتح / إغلاق المحادثة بنجاح',
      AppLanguageKeys.sendMessageSuccessfully: 'تم إرسال الرسالة بنجاح',

      AppLanguageKeys.addCarToGroupSuccessfully:
          'تم إضافة السيارة إلى المجموعة بنجاح',
      AppLanguageKeys.addCompanyDriverSuccessfully:
          'تم إضافة سائق الشركة بنجاح',
      AppLanguageKeys.createCarGroupSuccessfully:
          'تم إنشاء مجموعة السيارات بنجاح',
      AppLanguageKeys.deleteCarGroupSuccessfully:
          'تم حذف مجموعة السيارات بنجاح',
      AppLanguageKeys.deleteCompanyDriverSuccessfully:
          'تم حذف سائق الشركة بنجاح',
      AppLanguageKeys.getCarGroupsSuccessfully: 'تم جلب مجموعات السيارات بنجاح',
      AppLanguageKeys.getCompanyDriversSuccessfully:
          'تم جلب سائقي الشركة بنجاح',
      AppLanguageKeys.getDriverDetailsSuccessfully:
          'تم جلب بيانات السائق بنجاح',
      AppLanguageKeys.removeCarFromGroupSuccessfully:
          'تم إزالة السيارة من المجموعة بنجاح',
      AppLanguageKeys.updateCarGroupSuccessfully:
          'تم تحديث مجموعة السيارات بنجاح',
      AppLanguageKeys.updateCompanyDriverSuccessfully:
          'تم تحديث بيانات سائق الشركة بنجاح',

      //End//

      //New Adds ///
      AppLanguageKeys.petroleum: 'البترول',
      AppLanguageKeys.languageKey: 'عربي',
      AppLanguageKeys.dashBoardPageKey: 'الرئيسية',
      AppLanguageKeys.securityPageKey: 'الحمايه',
      AppLanguageKeys.permissionsGroupPageKey: 'احصائيات',
      AppLanguageKeys.usersPermissionsPageKey: 'صلاحيات المستخدمين',
      AppLanguageKeys.userStatisticsPageKey: 'إحصائيات المستخدم',
      AppLanguageKeys.settingsPageKey: 'الإعدادات',
      AppLanguageKeys.companiesPageKey: 'الشركات',
      AppLanguageKeys.generalSettingsPageKey: 'إعدادات عامة',
      AppLanguageKeys.branchesPageKey: 'الفروع',
      AppLanguageKeys.inventoriesPageKey: 'المخازن',
      AppLanguageKeys.banksPageKey: 'البنوك',
      AppLanguageKeys.areasPageKey: 'المناطق',
      AppLanguageKeys.taxesPageKey: 'الضرائب',
      AppLanguageKeys.financialPeriodPageKey: 'الفترة المالية',
      AppLanguageKeys.costCenterPageKey: 'مراكز التكلفة',
      AppLanguageKeys.currenciesPageKey: 'العملات',
      AppLanguageKeys.categoriesPageKey: 'المنتجات',
      AppLanguageKeys.skipKey: 'تخطي',
      AppLanguageKeys.nextKey: 'التالي',
      AppLanguageKeys.startKey: 'البدء',
      AppLanguageKeys.passwordKey: 'كلمة المرور',
      AppLanguageKeys.freeTrialKey: 'التجربة المجانية',
      AppLanguageKeys.loginKey: 'تسجيل الدخول',
      AppLanguageKeys.versionKey: 'النسخة',
      AppLanguageKeys.rememberMeKey: 'تذكرني',
      AppLanguageKeys.okKey: 'موافق',
      AppLanguageKeys.backButtonKey: 'رجوع',
      AppLanguageKeys.addAllRequiredFieldsKey: 'أدخل جميع الحقول المطلوبة',
      AppLanguageKeys.passwordNotMatchKey: 'كلمة المرور غير متطابقة',
      AppLanguageKeys.passwordAtLeastKey:
          'كلمة المرور يجب أن تكون على الأقل 6 أحرف',
      AppLanguageKeys.wrongPasswordKey: 'كلمة المرور خطأ',

      AppLanguageKeys.signUpTitleKey: 'تسجيل حساب جديد',
      AppLanguageKeys.centerNameKey: 'اسم المركز',
      AppLanguageKeys.phoneNumberKey: 'رقم الهاتف',
      AppLanguageKeys.emailKey: 'الايميل',
      AppLanguageKeys.confirmPasswordKey: 'تأكيد كلمة المرور',
      AppLanguageKeys.createAccountKey: 'إنشاء حساب',
      AppLanguageKeys.enterPhoneAndPasswordKey:
          'برجاء ادخال رقم الايميل وكلمة المرور',
      AppLanguageKeys.forgotPasswordKey: 'نسيت كلمة المرور',
      AppLanguageKeys.loginAgainKey: 'تسجيل الدخول',
      AppLanguageKeys.fromKey: 'من',
      AppLanguageKeys.toKey: 'الي',
      AppLanguageKeys.backKey: 'رجوع',
      AppLanguageKeys.mainBranchKey: 'الفرع الرئيسي',
      AppLanguageKeys.editKey: 'تعديل',
      AppLanguageKeys.addNewBranchKey: 'إضافة فرع جديد',
      AppLanguageKeys.facilityManagementKey: 'إدارة المنشأة',
      AppLanguageKeys.addMainBranchKey: 'أضافة فرع رئيسي',
      AppLanguageKeys.branchAddressKey: 'عنوان الفرع',
      AppLanguageKeys.addressDetailsKey: 'تفاصيل العنوان',
      AppLanguageKeys.confirmBranchLocationKey:
          'تأكيد موقع الجغرافي الخاص بالفرع',
      AppLanguageKeys.saveKey: 'حفظ',
      AppLanguageKeys.selectCarModelKey: 'أختر موديل سيارتك',
      AppLanguageKeys.searchCarModelKey: 'يمكنك البحث لاختيار موديل السيارة',
      AppLanguageKeys.continueFacilityDataKey: 'استكمال تسجيل بيانات المنشأة',
      AppLanguageKeys.fillFacilityDataKey: 'قم بملئ بيانات حساب المنشأة ',
      AppLanguageKeys.saturdayKey: 'السبت',
      AppLanguageKeys.sundayKey: 'الاحد',
      AppLanguageKeys.mondayKey: 'الاثنين',
      AppLanguageKeys.tuesdayKey: 'الثلاثاء',
      AppLanguageKeys.wednesdayKey: 'الاربعا',
      AppLanguageKeys.thursdayKey: 'الخميس',
      AppLanguageKeys.fridayKey: 'الجمعة',
      AppLanguageKeys.weekDaysKey: 'ايام الاسبوع',
      AppLanguageKeys.selectWorkDaysKey: 'أختر ايام الاسبوع للعمل في متجرك',
      AppLanguageKeys.availableTimesKey: 'المواعيد المتاحة',
      AppLanguageKeys.selectAvailableTimeKey:
          'أختر الميعاد المتاح لاستقبال الطلبات',
      AppLanguageKeys.facilityIdentityKey: 'هوية المنشأة',
      AppLanguageKeys.attachIdentityKey: 'إرفاق الهوية',
      AppLanguageKeys.imageRequirementsKey:
          'المقاس لا يقل عن (100px ارتفاع * 250px عرض) من نوع ( jpg, jpeg, png , gif ) ولا يتجاوز 5 ميجابيت لكل صوره بحد اقصي 10 صور',
      AppLanguageKeys.facilityNameKey: 'اسم المنشأة',
      AppLanguageKeys.facilityNameENKey: 'أسم المنشأة EN',
      AppLanguageKeys.activityTypeKey: 'نوع النشاط',
      AppLanguageKeys.emailAgainKey: 'الايميل',
      AppLanguageKeys.phoneAgainKey: 'رقم الهاتف',
      AppLanguageKeys.commercialRecordKey: 'السجل التجاري',
      AppLanguageKeys.taxNumberKey: 'رقم الضريبي',
      AppLanguageKeys.shortAddressKey: 'العنوان المختصر',
      AppLanguageKeys.buildingNumberKey: 'رقم المبني',
      AppLanguageKeys.cityKey: 'المدينة',
      AppLanguageKeys.buildingNumberAgainKey: 'رقم المبني',
      AppLanguageKeys.commercialRecordFileKey: 'شهادة سجل تجاري',
      AppLanguageKeys.attachFileKey: 'إرفاق الملف',
      AppLanguageKeys.ownerIdKey: 'بطاقة الهوية او اقامة صاحب الشركة',
      AppLanguageKeys.bankNameKey: 'اسم البنك',
      AppLanguageKeys.beneficiaryNameKey: 'اسم االمستفيد',
      AppLanguageKeys.bankAccountNumberKey: 'رقم حساب البنكي',
      AppLanguageKeys.swiftCodeKey: 'رقم السويفت',
      AppLanguageKeys.ibanNumberKey: 'رقم حساب الدولي الدولي الايبان',
      AppLanguageKeys.addKey: 'أضافة',
      AppLanguageKeys.newModelKey: 'موديل جديد ',
      AppLanguageKeys.carCategoryKey: 'فئة السيارات',
      AppLanguageKeys.nissanKey: 'نيسان',
      AppLanguageKeys.allCategoriesKey: 'جميع الفئات',
      AppLanguageKeys.nissanAllCategoriesKey: 'نيسان (جميع الفئات)',
      AppLanguageKeys.serviceSettingsKey: 'إعدادات  الخدمات',
      AppLanguageKeys.selectModelYearsKey: 'حدد سنوات الموديل ',
      AppLanguageKeys.chooseCategoryKey: 'أختر الفئة ',
      AppLanguageKeys.allCategoriesAgainKey: 'جميع الفئات',
      AppLanguageKeys.addedCarsKey: 'السيارات المضافة 1',
      AppLanguageKeys.modelRangeKey: 'موديل من 2020 الي 2025',
      AppLanguageKeys.porscheKey: 'بورش',
      AppLanguageKeys.mercedesKey: 'مرسيدس',
      AppLanguageKeys.lexusKey: 'لكزس',
      AppLanguageKeys.mercedesAgainKey: 'مرسيدس',
      AppLanguageKeys.nissanQashqaiKey: 'نيسان قشقاي',
      AppLanguageKeys.defineModelsKey:
          'حدد موديل السيارات بناء علي الخدمات التي ستقدمها لعملائك',
      AppLanguageKeys.carModelsKey: 'موديل السيارات',
      AppLanguageKeys.multipleCarsKey: 'يمكنك تحديد سيارات مختلفة في أن واحد',
      AppLanguageKeys.serviceSettingsDetailsKey:
          'اعدادات الخدمات من حيث نوع الخدمة والاسعار والباقات المشتركة',
      AppLanguageKeys.addNewCarKey: 'أضافة سيــارة جديدة',
      AppLanguageKeys.addCarModelKey: 'إضافة موديل سيارة ',
      AppLanguageKeys.facilityDataKey: 'بيانات المنشأة',
      AppLanguageKeys.identityKey: 'الهوية',
      AppLanguageKeys.branchesKey: 'الفروع',
      AppLanguageKeys.workingHoursKey: 'مواعيد العمل',
      AppLanguageKeys.bankAccountKey: 'حساب البنك',
      AppLanguageKeys.facilityManagementAgainKey: 'إدارة المنشأة',
      AppLanguageKeys.facilityAccountKey: 'حساب المنشأة',
      AppLanguageKeys.carModelsTitleKey: 'موديل السيارات',
      AppLanguageKeys.serviceSettingsTitleKey: 'إعدادت الخدمات',
      AppLanguageKeys.nameKey: 'اسم',
      AppLanguageKeys.newUserKey: 'مستخدم جديد',
      AppLanguageKeys.introTextKey:
          'منصتك المثالية للوصول إلى العملاء وزيادة\n حجوزات مركزك بخدمات السيارات',

      AppLanguageKeys.internalMaintenanceKey: 'صيانات داخلية',
      AppLanguageKeys.sparePartsKey: 'قطع غيار',
      AppLanguageKeys.mobileServicesKey: 'خدمات متنقلة',
      AppLanguageKeys.allOrdersKey: 'جميع الطلبات',
      AppLanguageKeys.newOrdersKey: 'الطلبات الجديدة',
      AppLanguageKeys.completedOrdersKey: 'الطلبات المنتهية',
      AppLanguageKeys.createNewOrderKey: 'إنشاء طلب جديد',
      AppLanguageKeys.orderInProgressKey: 'جاري تنفيذ الطلب',
      AppLanguageKeys.waitingForPaymentKey: 'انتظار دفع الفاتورة',
      AppLanguageKeys.serviceDeliveredKey: 'تم تسليم الخدمة',
      AppLanguageKeys.accountBalanceKey: 'رصيد الحسابات',
      AppLanguageKeys.detailsKey: 'تفاصيل',
      AppLanguageKeys.ordersKey: 'الطلبات',
      AppLanguageKeys.internalServicesKey: 'صيانات وخدمات داخلية',
      AppLanguageKeys.ordersCountKey: 'عدد طلب',
      AppLanguageKeys.increasePercentKey: 'زيادة 3%',
      AppLanguageKeys.maintenanceAndRepairKey: 'الصيانة والاصلاح',
      AppLanguageKeys.revenueFromOrderKey: 'ايراد من طلب 10054',
      AppLanguageKeys.jobTitleKey: 'أسم الوظيفة',
      AppLanguageKeys.employeeNameKey: 'محمد عبد الله',
      AppLanguageKeys.requestsCountKey: '120 طلب',
      AppLanguageKeys.topEmployeesKey: 'الموظفون الاعلي أداءا',
      AppLanguageKeys.topOrderReceiversKey:
          'ترتيب الموظفين الاعلي استقبال الطلبات',
      AppLanguageKeys.servicesRatingKey: 'تقييم لكل الخدمات',
      AppLanguageKeys.internalServicesStatsKey: 'احصائية خدمات الداخلية',
      AppLanguageKeys.executeOrderKey: 'تنفيذ الطلب',
      AppLanguageKeys.internalServicesTitleKey: 'خدمات داخلية',
      AppLanguageKeys.maintenanceAndRepairTitleKey: 'صيانة واصلاح',
      AppLanguageKeys.clientNameKey: 'اسم العميل',
      AppLanguageKeys.expectedEndDateKey: 'توقع انتهاء الطلب',
      AppLanguageKeys.notesKey: 'الملاحظات',
      AppLanguageKeys.washingAndCleaningKey: 'غسيل ونظافة',
      AppLanguageKeys.jobNameKey: 'أسم الوظيفة',
      AppLanguageKeys.internalServiceKey: 'خدمات داخلية',
      AppLanguageKeys.newOrdersListKey: 'الطلبات الجديدة',
      AppLanguageKeys.newOrdersFromServicesKey:
          'قائمة الطلبات الجديدة من الخدمات',
      AppLanguageKeys.viewAllKey: 'عرض الكل',
      AppLanguageKeys.orderDateKey: 'تاريخ الطلب',
      AppLanguageKeys.orderDetailsTitleKey: 'تفاصيل الطلب رقم #452',
      AppLanguageKeys.viewAllOrderDetailsKey: 'عرض جميع تفاصيل الطلب',
      AppLanguageKeys.orderStatusKey: 'حالة الطلب',
      AppLanguageKeys.underServiceKey: 'تحت الخدمة',
      AppLanguageKeys.allOrdersListKey: 'جميع الطلبات',
      AppLanguageKeys.ordersListFromServicesKey: 'قائمة الطلبات من الخدمات',
      AppLanguageKeys.invoiceKey: 'الفاتورة',
      AppLanguageKeys.insuranceInstallmentKey: 'قسط التأمين',
      AppLanguageKeys.taxesKey: 'الضرائب',
      AppLanguageKeys.totalKey: 'الأجمالي',
      AppLanguageKeys.insuranceAgainKey: 'قسط التأمين',
      AppLanguageKeys.paidByKey: 'تم دفع بواسطة',
      AppLanguageKeys.orderCompletionKey: 'انتهاء الطلب',
      AppLanguageKeys.internalServicesProfitKey: 'أرباح من خدمات الداخلية',
      AppLanguageKeys.searchKey: 'بحث',
      AppLanguageKeys.filterKey: 'فلتر',
      AppLanguageKeys.servicePriceKey: 'سعر الخدمة',
      AppLanguageKeys.statisticsKey: 'الاحصائيات',
      AppLanguageKeys.maintenanceAndInternalServicesKey: 'صيانات وخدمات داخلية',
      AppLanguageKeys.ordersSectionKey: 'الطلبات',
      AppLanguageKeys.mobileAndTransportServicesKey: 'الخدمات المتنقلة والنقل',
      AppLanguageKeys.sparePartsSectionKey: 'قطع الغيار',
      AppLanguageKeys.carMarketKey: 'حراج سيارات',
      AppLanguageKeys.accountManagementKey: 'أدارة الحسابات',
      AppLanguageKeys.permissionsKey: 'الصلاحيات',
      AppLanguageKeys.notificationsKey: 'الأشعارات',
      AppLanguageKeys.adsKey: 'الاعلانات',
      AppLanguageKeys.reviewsKey: 'التقييمات',
      AppLanguageKeys.socialPagesAndPoliciesKey: 'صفحات التواصل والسياسات',
      AppLanguageKeys.logoutKey: 'تسجيل الخروج',
      AppLanguageKeys.priceKey: '450.00ريال',

      //End///

      ////dashboard////
      AppLanguageKeys.establishmentOrders: 'طلبات المنشأة',

      AppLanguageKeys.waitingForApproval: 'انتظار الموافقة',

      AppLanguageKeys.drivers: 'السائقين',
      AppLanguageKeys.serviceProvider: 'مزود الخدمة',

      AppLanguageKeys.paymentSuccessful: 'تم الدفع بنجاح',

      AppLanguageKeys.orderDelivery: 'تسليم الطلب',
      AppLanguageKeys.contactCustomer: 'تواصل مع العميل',
      AppLanguageKeys.orderArrived: 'تم وصول الطلب',

      AppLanguageKeys.sparePartsOrders: 'طلبات قطع غيار',
      AppLanguageKeys.serviceOrdersList: 'قائمة الطلبات من الخدمات',
      AppLanguageKeys.shippingCompany: 'شركة الشحن',

      AppLanguageKeys.carDetails: 'تفاصيل السيارة',
      AppLanguageKeys.viewAllOrderDetails: 'عرض جميع تفاصيل الطلب',
      AppLanguageKeys.carSpecifications: 'مواصفات السيارة',
      AppLanguageKeys.carSold: 'تم بيع السيارة',

      AppLanguageKeys.carsList:
          'قائمة السيارات من السيارات الحالية والمباعة سابقاً',
      AppLanguageKeys.allCars: 'جميع السيارات',
      AppLanguageKeys.newCars: 'سيارات جديدة',
      AppLanguageKeys.usedCars: 'سيارات مستعملة',
      AppLanguageKeys.carCondition: 'حالة السيارة',
      AppLanguageKeys.messagesCount: 'عدد الرسائل',
      AppLanguageKeys.carPrice: 'سعر السيارة',
      AppLanguageKeys.filter: 'فلتر',
      AppLanguageKeys.usage: 'استعمال',
      AppLanguageKeys.brandNew: 'جديد',

      AppLanguageKeys.yourPerfectPlatform:
          'منصتك المثالية للوصول إلى العملاء وزيادة حجوزات مركزك بخدمات السيارات',
      AppLanguageKeys.employeesLogin: 'تسجيل الدخول للموظفين',
      AppLanguageKeys.enterPhoneAndPassword:
          'برجاء ادخال رقم الهاتف وكلمة المرور',

      AppLanguageKeys.writeYourMessageHere: 'اكتب رسالتك هنا',

      AppLanguageKeys.technicalSupport: 'الدعم الفني',
      AppLanguageKeys.messages: 'الرسائل',
      AppLanguageKeys.teamMembers: 'فريق العمل',
      AppLanguageKeys.membersCount: 'عدد الأعضاء',
      AppLanguageKeys.searchInMessages: 'بحث في الرسائل',

      AppLanguageKeys.employeeNameEn: 'اسم الموظف EN',
      AppLanguageKeys.employeeId: 'رقم الهوية',
      AppLanguageKeys.joiningDate: 'تاريخ الانضمام',
      AppLanguageKeys.address: 'العنوان',

      AppLanguageKeys.commercialRecordCertificate: 'شهادة السجل التجاري',
      AppLanguageKeys.ownerIdOrResidenceCard:
          'بطاقة الهوية أو إقامة صاحب الشركة',
      AppLanguageKeys.establishmentManagement: 'إدارة المنشأة',
      AppLanguageKeys.establishmentData: 'بيانات المنشأة',
      AppLanguageKeys.fillEstablishmentAccountData:
          'قم بملئ بيانات حساب المنشأة',
      AppLanguageKeys.identity: 'الهوية',
      AppLanguageKeys.branches: 'الفروع',
      AppLanguageKeys.workingHours: 'مواعيد العمل',
      AppLanguageKeys.bankAccount: 'حساب البنك',
      AppLanguageKeys.establishmentName: 'أسم المنشأة',
      AppLanguageKeys.establishmentNameEn: 'أسم المنشأة EN',
      AppLanguageKeys.activityType: 'نوع النشاط',
      AppLanguageKeys.commercialRegistration: 'السجل التجاري',
      AppLanguageKeys.taxNumber: 'الرقم الضريبي',
      AppLanguageKeys.shortAddress4Letters: 'العنوان المختصر من 4 حروف',
      AppLanguageKeys.buildingNumber: 'رقم المبني',
      AppLanguageKeys.city: 'المدينة',
      AppLanguageKeys.attachFile: 'إرفاق الملف',
      AppLanguageKeys.ownerIdOrIqama: 'بطاقة الهوية أو إقامة صاحب الشركة',

      AppLanguageKeys.oilProducts: 'منتجات الزيوت',
      AppLanguageKeys.allSoldProducts: 'جميع المنتجات المباعة',
      AppLanguageKeys.allDisplayedProducts: 'جميع المنتجات المعروضة',
      AppLanguageKeys.availableDisplayedList:
          'قائمة المنتجات المعروضة المتاحة للبيع في المحطات',
      AppLanguageKeys.addNewOil: 'إضافة زيت جديد',
      AppLanguageKeys.saleDate: 'تاريخ البيع',
      AppLanguageKeys.productPrice: 'سعر المنتج',

      AppLanguageKeys.allFillingOrders: 'جميع طلبات التعبئة',
      AppLanguageKeys.fillingOrdersSalesForAllBranches:
          'مبيعات من طلبات التعبئة لجميع الفروع',
      AppLanguageKeys.fuelFillingSalesPerBranch: 'مبيعات تعبئة الوقود لكل فرع',
      AppLanguageKeys.addDifferentServices:
          'اضافة خدمات مختلف مع اكثر من باقه مختلفة',
      AppLanguageKeys.specialPackage: 'باقة مميزة',
      AppLanguageKeys.packageName: 'اسم الباقة',
      AppLanguageKeys.packageDescription: 'وصف الخدمات داخل الباقة',
      AppLanguageKeys.servicesIncluded: 'نوع الخدمات من ضمن الباقة',

      AppLanguageKeys.delete: 'حذف',
      AppLanguageKeys.sizesOrDimensions: 'المقاسات او الاحجام',
      AppLanguageKeys.availableQuantity: 'عدد القطع المتاحة',

      AppLanguageKeys.addSparePart: 'إضافة قطع غيار',
      AppLanguageKeys.addSparePartDetails:
          'اضافة قطع غيار من حيث نوع الفئة وتفاصيل المنتج',
      AppLanguageKeys.allCategoriesIncluded: 'شامل لكل الفئات',
      AppLanguageKeys.specificCategory: 'خاص بفئة',
      AppLanguageKeys.partName: 'اسم القطعة',
      AppLanguageKeys.spareCategory: 'فئة الغيار',
      AppLanguageKeys.price: 'السعر',
      AppLanguageKeys.sparePartImage: 'صورة قطعه الغيار',
      AppLanguageKeys.writeText: 'كتابة نص',

      AppLanguageKeys.imageSizeNote:
          'المقاس لا يقل عن (100px ارتفاع * 250px عرض) من نوع (jpg, jpeg, png, gif) ولا يتجاوز 5 ميجابيت لكل صوره بحد اقصي 10 صور',
      AppLanguageKeys.productDetails: 'تفاصيل المنتج',
      AppLanguageKeys.totalPartsInStock: 'اجمالي القطع في المخزون',
      AppLanguageKeys.numberOfSizesIfAvailable: 'عدد المقاسات ان وجدت',

      AppLanguageKeys.mobileServices: 'الخدمات المتنقلة',
      AppLanguageKeys.towTruckRequest: 'طلب سطحة',
      AppLanguageKeys.highwayService: 'خدمة الطرق السريعة',
      AppLanguageKeys.selectCarModelByServices:
          'حدد موديل السيارات بناء علي الخدمات التي ستقدمها لعملائك',
      AppLanguageKeys.multipleCarSelectionNote:
          'يمكنك تحديد سيارات مختلفة في أن واحد',
      AppLanguageKeys.searchCarModel: 'يمكنك البحث لاختيار موديل السيارة',
      AppLanguageKeys.chooseCategory: 'أختر الفئة',
      AppLanguageKeys.selectModelYears: 'حدد سنوات الموديل',
      AppLanguageKeys.carCategory: 'فئة السيارات',
      AppLanguageKeys.addCarModel: 'إضافة موديل سيارة',

      AppLanguageKeys.transferCarToAnotherUser: 'نقل السيارة لمستخدم أخر',
      AppLanguageKeys.yourPassword: 'كلمة المرور الخاص بك',
      AppLanguageKeys.newUserEmailOrPhone:
          'الايميل أو رقم الهاتف للمستخدم الجديد',
      AppLanguageKeys.reasonForTransfer: 'سبب لنقل الحساب',
      AppLanguageKeys.transferNotice:
          'سيتم نقل جميع الصيانات والفواتير السابقة مع عدا الاوراق الشخصية او الرخصة الخاصة بك',
      AppLanguageKeys.completeTransfer: 'اتمام النقل',
      AppLanguageKeys.waitingForNewUserApproval:
          'في انتظار موافقة المستخدم الجديد لنقل السيارة',
      AppLanguageKeys.carTransferredToNewOwner: 'تم نقل السيارة للمالك أخر',
      AppLanguageKeys.transferYourNewCar: 'نقل سيارتك الجديدة',

      AppLanguageKeys.allNotifications: 'جميع الإشعارات',
      AppLanguageKeys.searchFrom: 'بحث من',
      AppLanguageKeys.to: 'الي',
      AppLanguageKeys.allOrders: 'جميع الطلبات',
      AppLanguageKeys.ordersListFromServices: 'قائمة الطلبات من الخدمات',
      AppLanguageKeys.newOrders: 'الطلبات الجديدة',
      AppLanguageKeys.completedOrders: 'الطلبات المنتهية',
      AppLanguageKeys.search: 'بحث',

      AppLanguageKeys.confirm: 'تأكيد',
      AppLanguageKeys.cancel: 'إلغاء',
      AppLanguageKeys.logout: 'تسجيل الخروج',
      AppLanguageKeys.confirmLogout: 'هل تريد تأكيد الخروج؟',
      AppLanguageKeys.oils: 'زيوت',
      AppLanguageKeys.allChanges: 'جميع الغيارات',
      AppLanguageKeys.allReviews: 'جميع التقييمات',
      AppLanguageKeys.reviewsListForAllServices:
          'قائمة التقييمات لجميع الخدمات',
      AppLanguageKeys.totalReviews: 'اجمالي التقييمات',

      AppLanguageKeys.providersTermsAndConditions: '''
1. التسجيل والاعتماد
يشترط تسجيل المركز ببيانات صحيحة ودقيقة.
يحق لـ صن مراجعة واعتماد أو رفض طلب التسجيل دون إبداء الأسباب.
يتحمل المزود مسؤولية تحديث بياناته باستمرار.

2. استخدام المنصة
يلتزم المزود باستخدام المنصة فقط للأغراض المصرح بها (تقديم خدمات صيانة السيارات).
يمنع إساءة استخدام المنصة أو محاولة التلاعب بالأنظمة أو العملاء.
أي مخالفة قد تؤدي إلى إيقاف أو إلغاء الحساب.

3. الطلبات والخدمات
يتعهد المزود بتنفيذ الطلبات المتفق عليها بجودة عالية وفي الوقت المحدد.
الأسعار المقدمة للعملاء يجب أن تكون واضحة وشفافة.
يحق للعميل إلغاء أو تعديل الطلب وفق سياسات الإلغاء المعلنة.

4. الالتزامات المالية
يتم الاتفاق على آلية الدفع والتحصيل من خلال منصة صن.
يتحمل المزود أي التزامات مالية تجاه العملاء نتيجة الإخلال بتنفيذ الخدمة.
قد يتم خصم رسوم خدمة أو عمولات لصالح صن حسب السياسة المعتمدة.

5. التقييمات والمراجعات
يحق للعملاء تقييم الخدمات المقدمة.
تُعتبر التقييمات جزءًا من النظام العام للمنصة ولا يمكن حذفها إلا إذا ثبت مخالفتها للسياسة.

6. المسؤولية
يتحمل المزود المسؤولية الكاملة عن جودة الخدمات المقدمة.
صن ليست مسؤولة عن أي أضرار مباشرة أو غير مباشرة تنتج عن تنفيذ الخدمة، وإنما دورها يقتصر على الوساطة بين المزود والعميل.

7. إنهاء الخدمة
يحق لـ صن إيقاف أو إنهاء حساب المزود عند مخالفة الشروط أو الإضرار بسمعة المنصة.
يحق للمزود طلب إغلاق حسابه في أي وقت بعد تسوية الالتزامات المالية.

8. التعديلات على الشروط
تحتفظ صن بحق تعديل أو تحديث الشروط والأحكام في أي وقت.
يتم إخطار المزودين بالتعديلات عبر المنصة أو البريد الإلكتروني.
''',
      AppLanguageKeys.providersPrivacyPolicy:
          "سياسة الخصوصية لمراكز السيارات (المزودين الخدميين)\n\n1. جمع المعلومات\nنقوم بجمع البيانات الأساسية الخاصة بالمراكز المزودة للخدمة مثل:\n- معلومات المركز (الاسم التجاري – الموقع – نوع الخدمات).\n- بيانات التواصل (الهاتف – البريد الإلكتروني).\n- بيانات الحساب (اسم المستخدم – كلمة المرور).\n\n2. استخدام المعلومات\nتُستخدم المعلومات فقط من أجل:\n- إنشاء الحساب وتفعيله.\n- إدارة الطلبات والخدمات.\n- التواصل بين المركز والعميل.\n- تحسين جودة الخدمة وتجربة الاستخدام.\n\n3. مشاركة المعلومات\nلا تتم مشاركة بيانات المزودين مع أي طرف ثالث خارج نطاق المنصة، إلا إذا كان ذلك مطلوبًا قانونيًا.\nبعض المعلومات مثل اسم المركز والخدمات متاحة للعملاء لتمكينهم من اختيار الخدمة.\n\n4. حماية البيانات\nنلتزم بحماية بيانات المزودين من أي وصول غير مصرح به عبر أنظمة آمنة وتشفير المعلومات الحساسة.\n\n5. حقوق المزود\n- الاطلاع على بياناته المسجلة وتحديثها.\n- طلب حذف الحساب من المنصة.\n- تقديم ملاحظات أو شكاوى بخصوص إدارة البيانات.\n\n6. التعديلات على السياسة\nقد نقوم بتحديث سياسة الخصوصية من وقت لآخر، وسيتم إخطار المزودين عند وجود أي تغييرات جوهرية.",
      AppLanguageKeys.aboutSunIntro:
          "صن هو منصّة رقمية متخصصة في ربط أصحاب السيارات بمراكز الصيانة والخدمات المعتمدة. نهدف إلى تسهيل وصول العملاء إلى خدماتك وزيادة فرص مركزك في النمو، من خلال إدارة الطلبات بشكل منظم واحترافي عبر منصّة موثوقة وسهلة الاستخدام.\n\nمع صن، تحصل مراكز السيارات على:\n- قاعدة عملاء أوسع.\n- إدارة سهلة للطلبات والخدمات.\n- متابعة دقيقة للتقييمات والأداء.\n- فرص أكبر لزيادة الإيرادات وتوسيع النشاط.",

      AppLanguageKeys.contactAndPoliciesPages: 'صفحات التواصل والسياسات',
      AppLanguageKeys.contactUs: 'تواصل معنا',
      AppLanguageKeys.aboutSun: 'عن صن',
      AppLanguageKeys.privacyPolicy: 'سياسة الخصوصية',
      AppLanguageKeys.termsAndConditions: 'الشروط والاحكام',
      AppLanguageKeys.sendUsMessage: 'قم بارسال رسالتك',
      AppLanguageKeys.name: 'الاسم',
      AppLanguageKeys.messageText: 'نص الرسالة',
      AppLanguageKeys.send: 'إرسال',

      AppLanguageKeys.advertisements: 'الاعلانات',
      AppLanguageKeys.bannerImage: 'صورة البنر',
      AppLanguageKeys.bannerSizeNote: 'المقاس المناسب للصورة هو 1108×428 بكسل',
      AppLanguageKeys.uploadImage: 'ارفع صورة (jpg.jpeg.gif.png.webp)',
      AppLanguageKeys.link: 'الرابط',
      AppLanguageKeys.category: 'تصنيف',
      AppLanguageKeys.storeOffers: 'عروض المتجر',
      AppLanguageKeys.durationFromTo: 'المدة من / الي',
      AppLanguageKeys.createBannerAd: 'إنشاء بانر اعلان',

      AppLanguageKeys.monthly: 'شهري',
      AppLanguageKeys.daily: 'يومي',
      AppLanguageKeys.selectTime: 'اختر الوقت',
      AppLanguageKeys.newRequests: 'الطلبات الجديدة',
      AppLanguageKeys.newRequestsList: 'قائمة الطلبات الجديدة من الخدمات',
      AppLanguageKeys.noRequests: 'لا يوجد طلبات حاليا',
      AppLanguageKeys.internalServicesStats: 'احصائية خدمات الداخلية',
      AppLanguageKeys.weekly: 'أسبوعي',
      AppLanguageKeys.internalServicesProfit: 'أرباح من خدمات الداخلية',
      AppLanguageKeys.internalServicesRating: 'تقييم لخدمات الداخلية',
      AppLanguageKeys.afterReceivingRequests: 'بعد استقبال طلبات',
      AppLanguageKeys.jobName: 'أسم الوظيفة',
      AppLanguageKeys.requestStatus: 'حالة الطلب',
      AppLanguageKeys.underService: 'تحت الخدمة',
      AppLanguageKeys.requestDate: 'تاريخ الطلب',
      AppLanguageKeys.servicePrice: 'سعر الخدمة',
      AppLanguageKeys.delivered: 'تم التسليم',
      AppLanguageKeys.requestRejected: 'رفض الطلب',
      AppLanguageKeys.newRequest: 'طلب جديد',

      AppLanguageKeys.addNewUser: 'أضافة مستخدم جديد',
      AppLanguageKeys.userPermissionsSettings:
          'إعدادات صلاحيات المستخدمين داخل النظام',
      AppLanguageKeys.employeeName: 'أسم الموظف',
      AppLanguageKeys.jobTitle: 'اسم الوظيفة',
      AppLanguageKeys.accountStatus: 'حالة الحساب',
      AppLanguageKeys.active: 'مفعل',
      AppLanguageKeys.inactive: 'غير مفعل',
      AppLanguageKeys.picture: 'صورة',
      AppLanguageKeys.uploadPicture: 'رفع صورة',
      AppLanguageKeys.userPermissions: 'صلاحيات المستخدم',
      AppLanguageKeys.statistics: 'الاحصائيات',
      AppLanguageKeys.servicesSettings: 'إعدادات خدمات',
      AppLanguageKeys.carModelSettings: 'إعدادت موديل السيارات',
      AppLanguageKeys.accountManagement: 'ادارة الحسابات',
      AppLanguageKeys.permissionsManagement: 'ادارة الصلاحيات',
      AppLanguageKeys.organizationManagement: 'ادارة المنشأة',
      AppLanguageKeys.permissionsFromServices:
          'صلاحيات من الخدمات التي يحصل عليها المستخدم',
      AppLanguageKeys.maintenanceServices: 'خدمات الصيانة',

      AppLanguageKeys.nissanServiceSettings:
          'اعدادات الخدمات الخاص بالسيارات نيسان',
      AppLanguageKeys.serviceSettingsDetails:
          'اعدادات الخدمات من حيث نوع الخدمة والاسعار والباقات المشتركة',
      AppLanguageKeys.backToSettings: 'رجوع للصفحة الاعدادت',
      AppLanguageKeys.internalServices: ' خدمات داخلية',
      AppLanguageKeys.addServices: 'إضافة الخدمات',
      AppLanguageKeys.mobileAndTransportServices: 'الخدمات المتنقلة والنقل',
      AppLanguageKeys.carSpareParts: 'قطع غيار سيارات',
      AppLanguageKeys.sharedPackages: 'باقات مشتركة',
      AppLanguageKeys.serviceSettings: 'اعدادات الخدمات',
      AppLanguageKeys.addInternalServices: 'أضافة صيانات وخدمات داخلية',
      AppLanguageKeys.allCategories: 'جميع الفئات',
      AppLanguageKeys.unifiedPriceForAll: 'سعر موحد لكل فئات',
      AppLanguageKeys.pricePerCategory: 'سعر لكل فئة',
      AppLanguageKeys.sar: 'ريال سعودي',
      AppLanguageKeys.add: 'إضافة',
      AppLanguageKeys.carWash: 'غسيل سيارات',
      AppLanguageKeys.battery: 'بطارية',
      AppLanguageKeys.back: 'رجوع',
      AppLanguageKeys.save: 'حفظ',
      ////End////

      ////Change the glass////
      AppLanguageKeys.frontGlassReplacement: 'تغيير زجاج امامي',
      AppLanguageKeys.sideGlassReplacement: 'تغيير زجاج جانبي',
      AppLanguageKeys.frontGlass: 'زجاج امامي',
      ////End////

      ////Change tires////
      AppLanguageKeys.tireBalancing: 'ترصيص كفرات',
      AppLanguageKeys.wheelAlignment: 'وزن ازرعة',
      ////End////

      ////Delivery laundry////
      AppLanguageKeys.packages: 'الباقات',
      AppLanguageKeys.goldPackage: 'باقة جولد',
      AppLanguageKeys.premiumPackage: 'باقة بريميم',
      AppLanguageKeys.fullCleaning: 'شامل جميع النظافة',
      AppLanguageKeys.interiorPolishing: 'تلميع داخلي للسيارة',
      AppLanguageKeys.writeNotes: 'أكتب ملاحظاتك او احتياجات من مزودي الخدمة',
      AppLanguageKeys.sendRequest: 'إرسال الطلب',
      AppLanguageKeys.requestAccepted: 'تم قبول الطلب',
      AppLanguageKeys.highwayServiceCompleted:
          'تم الانتهاء من خدمة الطرق السريعة',
      AppLanguageKeys.searchYourAddress: 'بحث عنوانك',
      AppLanguageKeys.confirmCarLocation: 'تأكيد موقع سيارتك',
      AppLanguageKeys.pleaseSelectCarLocation: 'برجاء قم بتتحديد مكان سيارتك',

      ////End////

      ////Car Batteries////
      AppLanguageKeys.glassReplacement: 'تغيير زجاج',
      AppLanguageKeys.hour: 'ساعة',
      AppLanguageKeys.mobile: 'متنقل',
      AppLanguageKeys.sharedServices: 'الخدمات المشتركة',
      AppLanguageKeys.sparePartsAndProducts: 'قطع غيار ومنتجات',
      AppLanguageKeys.reviews: 'التقييمات',
      AppLanguageKeys.viewReviews: 'عرض التقييمات',
      AppLanguageKeys.bookService: 'حجز الخدمة',
      AppLanguageKeys.newItem: 'جديد',
      AppLanguageKeys.selectServices: 'أختيار الخدمات التي تحتاجها',
      AppLanguageKeys.confirmService: 'تأكيد الخدمة',
      AppLanguageKeys.confirmBookingTime: 'تأكيد التوقيت المناسب لحجز خدماتك',
      AppLanguageKeys.selectDay: 'أختيار اليوم',
      AppLanguageKeys.selectHour: 'أختيار الساعة',
      AppLanguageKeys.confirmServiceBooking: 'تأكيد حجز الخدمة',
      AppLanguageKeys.appointment: 'الميعاد',
      AppLanguageKeys.coupon: 'الكوبون',
      AppLanguageKeys.apply: 'تطبيق',
      ////End////

      ////Order list////
      AppLanguageKeys.createNewRequest: 'إنشاء طلب جديد',
      AppLanguageKeys.requestReceived: 'تم الاستلام',
      AppLanguageKeys.onTheWayToYou: 'في الطريق اليك',
      AppLanguageKeys.cancelBooking: 'إلغاء الحجز',
      AppLanguageKeys.rateService: 'تقييم الخدمة',
      AppLanguageKeys.writeComment: 'أكتب تعليق',
      AppLanguageKeys.addYourComment: 'أضف تعليقك',
      ////end////
      ////Request - Service////
      AppLanguageKeys.selectServiceType: 'أختر نوع الخدمة',
      AppLanguageKeys.roadService: 'خدمة الطريق',
      AppLanguageKeys.serviceDetails: 'تفاصيل الخدمة التي تحتاجها',
      AppLanguageKeys.desiredServicePrice: 'سعر الخدمة المرغوب دفعها',
      AppLanguageKeys.serviceCompletionTime: 'متي تريد انهاء الخدمة',
      AppLanguageKeys.selectCurrentLocation: 'تحديد موقعك الحالي',
      AppLanguageKeys.createServiceRequest: 'إنشاء طلب خدمة',
      AppLanguageKeys.saturday: 'السبت',
      AppLanguageKeys.sunday: 'الأحد',
      AppLanguageKeys.monday: 'الاثنين',
      AppLanguageKeys.tuesday: 'الثلاثاء',
      AppLanguageKeys.wednesday: 'الأربعاء',
      AppLanguageKeys.thursday: 'الخميس',
      AppLanguageKeys.friday: 'الجمعة',
      AppLanguageKeys.enterYourData: 'أدخل بياناتك',
      AppLanguageKeys.waitingForOffers: 'في انتظار استقبال العروض',
      AppLanguageKeys.serviceCenterOffers: 'العروض المقدمة من مراكز الخدمة',
      AppLanguageKeys.mobileMaintenanceOffer: 'صيانة متنقلة',
      AppLanguageKeys.repairCenterName: 'أسم مركز الاصلاح',
      AppLanguageKeys.acceptOffer: 'قبول العرض',
      AppLanguageKeys.rejectRequest: 'رفض الطلب',
      AppLanguageKeys.withinOneDay: 'خلال يوم واحد',

      AppLanguageKeys.requestNumber: 'طلب 44121',
      AppLanguageKeys.daysAgo: 'منذ يومين',
      AppLanguageKeys.expectedArrival: 'توقع الوصول',
      AppLanguageKeys.notes: 'الملاحظات',
      AppLanguageKeys.contactMaintenanceRep: 'التواصل مع مندوب الصيانة',
      AppLanguageKeys.maintenanceRep: 'مندوب الصيانة',
      AppLanguageKeys.trackTechnician: 'تتبع الفني',
      AppLanguageKeys.openMap: 'فتح الخريطة',
      AppLanguageKeys.payBill: 'دفع فاتورة',
      AppLanguageKeys.brakeRepair:
          'إصلاح نظام الفرامل (تغيير الفحمات - تيل الفرامل)',
      AppLanguageKeys.electricalRepair:
          'إصلاح عطل كهربائي في الأنوار أو العدادات',
      AppLanguageKeys.totalServices: 'إجمالي الخدمات',
      AppLanguageKeys.mobileService: 'خدمة متنقلة',
      AppLanguageKeys.serviceRequest: 'طلب الخدمة',
      AppLanguageKeys.serviceProvidersArrival: 'وصول مزودي الخدمة',
      AppLanguageKeys.serviceCompleted: 'انتهاء الخدمة',
      AppLanguageKeys.serviceRating: 'تقييم الخدمة',
      AppLanguageKeys.notRatedYet: 'لم يتم تقييم بعد',
      ////End////

      ////Change Car////
      AppLanguageKeys.myCarData: 'بيانات سيارتي',
      AppLanguageKeys.myCar: 'سيارتي',
      AppLanguageKeys.setAsPrimaryCar: 'استخدام سيارة كحساب رئيسي',
      AppLanguageKeys.wifeCar: 'سيارة زوجتي',
      AppLanguageKeys.replaceCarAsAccount: 'استبدال السيارة كحساب',
      AppLanguageKeys.mySecondCar: 'سيارتي الثانية',
      AppLanguageKeys.carBills: 'فواتير السيارة',
      AppLanguageKeys.carOwner: 'صاحب السيارة',
      AppLanguageKeys.carChassisNumber: 'رقم الشاصيه',
      AppLanguageKeys.carLicense: 'رخصة السيارة',
      AppLanguageKeys.carFiles: 'ملفات السيارة',
      AppLanguageKeys.transferCar: 'نقل لمستخدم أخر',
      AppLanguageKeys.deleteCar: 'حذف السيارة',
      ////END////

      ////Wallet- Bonus - Send code to friend////
      AppLanguageKeys.wallet: 'المحفظة',
      AppLanguageKeys.currentBalance: 'رصيد الحالي',
      AppLanguageKeys.rechargeWallet: 'شحن المحفظة',
      AppLanguageKeys.walletTransactionDetails: 'تفاصيل عمليات المحفظة',
      AppLanguageKeys.viewAll: 'عرض الكل',
      AppLanguageKeys.bonusBalance: 'هدية رصيد اضافي',
      AppLanguageKeys.payMaintenanceService: 'دفع خدمة لصيانة اصلاح',
      AppLanguageKeys.rechargeFromVisa: 'شحن رصيد من رقم فيز 555',
      AppLanguageKeys.points: 'النقاط',
      AppLanguageKeys.myPoints: 'جميع نقاطي',
      AppLanguageKeys.pointsDetails: 'تفاصيل النقاط',
      AppLanguageKeys.bonusPoints: 'هدية نقاط',
      AppLanguageKeys.redeemPointsService: 'خصم نقاط لاستخدمها في خدمة',
      AppLanguageKeys.rechargeFromVisaPoints: 'شحن رصيد من رقم فيز 555',
      AppLanguageKeys.inviteFriendText:
          'ارسل الكود لصديقك واحصل علي 50 ريال عند الاشتراك لأول مره',
      AppLanguageKeys.referralCode: 'الكود',
      AppLanguageKeys.copyCode: 'نسخ الكود',
      AppLanguageKeys.shareLink: 'مشاركة الرابط',
      AppLanguageKeys.sendToFriend: 'ارسل لصديقك',
      AppLanguageKeys.codeCopiedSuccessfully: 'تم نسخ الكود بنجاح!',

      ////End////

      ////Warranty////
      AppLanguageKeys.warrantyPeriod: 'لمدة 5 سنوات',
      AppLanguageKeys.warrantyServiceCenters:
          'الاستفادة من ضمان الخدمات عبر مراكزنا المعتمدة',
      AppLanguageKeys.warrantyCarsMarket:
          'ضمان السيارات من بيع وشراء في حراج السيارات',
      AppLanguageKeys.warrantyFreeMaintenance:
          'تقديم خدمات صيانة مجانية طوال فترة الضمان',
      AppLanguageKeys.warrantySubscription: 'اشتراك في الضمان',
      AppLanguageKeys.balanceChargedSuccessfully: 'تم شحن الرصيد بنجاح',
      AppLanguageKeys.showServicesAtApprovedCenters:
          'عرض الخدمات في المراكز المعتمدة',

      ////End////
      ////Profile////
      AppLanguageKeys.notifications: 'الاشعارات',
      AppLanguageKeys.newMessage: 'رسالة جديدة',
      AppLanguageKeys.order255Expired: 'انتهاء طلب 255',
      AppLanguageKeys.onTheWay: 'في الطريق',
      AppLanguageKeys.privacyTitle: 'سياسة الخصوصية',
      AppLanguageKeys.privacyIntro: '''
      في تطبيق "صن"، نولي أهمية قصوى لخصوصية مستخدمينا ونسعى دائمًا لحماية بياناتهم الشخصية. 
      توضح هذه السياسة كيفية جمع واستخدام ومشاركة المعلومات عند استخدامك لخدماتنا.
      
      المعلومات التي نقوم بجمعها
      عند استخدامك لتطبيق صن، قد نقوم بجمع بعض المعلومات اللازمة لتقديم الخدمة، مثل:
      - الاسم الكامل
      - رقم الجوال
      - عنوان البريد الإلكتروني
      - الموقع الجغرافي لتحديد مكان السيارة (بموافقتك)
      - تفاصيل الطلبات السابقة وسجلات الدفع
      
      كيفية استخدام المعلومات
      نستخدم المعلومات التي يتم جمعها من أجل:
      - تقديم خدمات الصيانة بشكل دقيق وفعال
      - التواصل معك بشأن حالة الطلب أو العروض الخاصة
      - تحسين أداء التطبيق وتجربة المستخدم
      - ضمان الأمان ومنع الاستخدام غير المشروع
      
      مشاركة المعلومات
      نحن لا نشارك بياناتك مع أي طرف ثالث خارج نطاق تطبيق "صن" إلا في الحالات التالية:
      - مع مراكز الصيانة المعتمدة لتنفيذ طلباتك
      - مع بوابات الدفع الإلكتروني لإتمام عمليات الدفع
      - إذا تطلب الأمر ذلك قانونيًا أو بطلب من الجهات المختصة
      
      حماية البيانات
      نلتزم بتطبيق أعلى معايير الأمان في حفظ بياناتك، ونستخدم تقنيات حماية متقدمة لضمان عدم الوصول غير المصرح به إلى معلوماتك.
      
      حقوق المستخدم
      يحق لك في أي وقت:
      - طلب نسخة من بياناتك الشخصية
      - تعديل أو تحديث بياناتك
      - طلب حذف حسابك من التطبيق
      
      التعديلات على السياسة
      قد نقوم بتحديث سياسة الخصوصية من وقت لآخر. وسيتم إشعارك بأي تغييرات هامة من خلال التطبيق أو عبر البريد الإلكتروني.
      
      التواصل معنا
      لأي استفسارات تتعلق بسياسة الخصوصية، يمكنك التواصل معنا عبر:
      📧 البريد الإلكتروني: privacy@sun-app.com
      📞 الدعم الفني: 9200XXXXXX
      ''',
      AppLanguageKeys.personalData: 'البيانات الشخصية',
      AppLanguageKeys.username: 'اسم المستخدم',
      AppLanguageKeys.nationality: 'الجنسية',
      AppLanguageKeys.language: 'اللغة',
      AppLanguageKeys.arabic: 'العربية',
      AppLanguageKeys.english: 'الانجليزية',
      AppLanguageKeys.myAddress: 'عنواني',
      AppLanguageKeys.yourCarAddress: 'عنوان سيارتك',
      AppLanguageKeys.addAddress: 'أضافة عنوان',
      AppLanguageKeys.creditCards: 'كروت الأئتمان البنكي',
      AppLanguageKeys.cardName: 'أسم الكارت',
      AppLanguageKeys.cardNumber: 'رقم الكارت',
      AppLanguageKeys.cvv: '3 ارقام CVV',
      AppLanguageKeys.expiryDate: 'تاريخ الانتهاء',
      AppLanguageKeys.addPaymentCard: 'أضافة بطاقه دفع',
      AppLanguageKeys.financialTransactions: 'المعاملات المالية',
      AppLanguageKeys.tires: 'إطارات',
      AppLanguageKeys.qrCode: 'QR code',
      AppLanguageKeys.scanQrCode: 'مسح QR code',
      ////End////

      ////InsuranceNew////
      AppLanguageKeys.selectInsuranceType: 'برجاء تحديد نوع التأمين الخاص بك',
      AppLanguageKeys.integrativeInsurance: 'تأمين تكاملي',
      AppLanguageKeys.carModel: 'موديل السيارة',
      AppLanguageKeys.edit: 'تعديل',
      AppLanguageKeys.sixMonthlyPayments: '6 دفعات شهرية',
      AppLanguageKeys.twelveMonthlyPayments: '12 دفعة شهرية',
      AppLanguageKeys.semiAnnual: 'نصف سنوي',
      AppLanguageKeys.annual: 'سنوي',
      AppLanguageKeys.insuranceAccountRegistration: 'تسجيل حساب التأمين',
      AppLanguageKeys.firstPayment: 'سداد أول دفعة',
      ////End////

      ////Insurance////
      AppLanguageKeys.payment: 'الدفع',
      AppLanguageKeys.insuranceOffers: 'عروض التأمينات (نيسان CVR)',
      AppLanguageKeys.insuranceOffersOnly: 'عروض التأمينات',
      AppLanguageKeys.comprehensiveInsurance: 'تأمين شامل',
      AppLanguageKeys.thirdPartyInsurance: 'تأمين ضد الغير',
      AppLanguageKeys.bestOffer: 'أفضل عرض',
      AppLanguageKeys.scienceInsurance: 'ساينس للتأمينات',
      AppLanguageKeys.annualPayment: 'دفعة سنوية',
      AppLanguageKeys.cooperativeInsurance: 'التعاونية للتأمينات السيارات',
      AppLanguageKeys.enterPolicyData:
          'أدخل بيانات الوثيقة لاظهار الدفعات المستحقة',
      AppLanguageKeys.policyNumber: 'رقم وثيقة التأمين',
      AppLanguageKeys.identityVerification: 'التحقق من الهوية',
      AppLanguageKeys.checkAbsherAccount: 'تحقق في حساب نفاذ الوطني',
      AppLanguageKeys.loginViaAbsher:
          'الدخول الي حساب النفاذ عبر النفاذ الوطني الموحد',
      AppLanguageKeys.nationalIdOrIqama: 'رقم الهوية الوطنية / رقم الإقامة',
      AppLanguageKeys.verifyAbsher: 'التحقق من النفاذ',
      AppLanguageKeys.yourInsuranceData: 'بيانات التأمين الخاصة بك',
      AppLanguageKeys.beneficiaryName: 'اسم المستفيد',
      AppLanguageKeys.insurancePolicyNumber: 'رقم وثيقة التأمين',
      AppLanguageKeys.nationalIdNumber: 'رقم الهوية',
      AppLanguageKeys.carPlateNumber: 'رقم لوحة السيارة',
      AppLanguageKeys.chassisNumber: 'رقم الشاصيه',
      AppLanguageKeys.insuranceType: 'نوع التأمين',
      AppLanguageKeys.insuranceValue: 'قيمة التأمين',
      AppLanguageKeys.installmentValue: 'قيمة القسط',
      AppLanguageKeys.linkInsuranceWithSanad: 'ربط حساب التأمين مع صن',
      AppLanguageKeys.pleaseWait: 'برجاء الانتظار',
      AppLanguageKeys.policyData: 'بيانات بوليصة التأمين',
      AppLanguageKeys.annualPayments: 'الدفعات السنوية',
      AppLanguageKeys.firstInstallment: 'الدفعة الأولى - 20/3',
      AppLanguageKeys.paid: 'تم السداد',
      AppLanguageKeys.details: 'تفاصيل',
      AppLanguageKeys.secondInstallment: 'الدفعة الثانية - 20/5',
      AppLanguageKeys.thirdInstallment: 'الدفعة الثالثة - 20/3',
      AppLanguageKeys.payInstallment: 'سداد القسط',
      AppLanguageKeys.notPaid: 'لم يتم السداد',
      AppLanguageKeys.fourthInstallment: 'الدفعة الرابعة - 20/5',
      AppLanguageKeys.nextInstallmentJuly: 'القسط القادم 7/20',
      AppLanguageKeys.nextInstallmentAugust: 'القسط القادم 8/20',
      AppLanguageKeys.invoice: 'الفاتورة',
      AppLanguageKeys.insuranceInstallment: 'قسط التأمين',
      AppLanguageKeys.taxes: 'الضرائب',
      AppLanguageKeys.total: 'الإجمالي',
      AppLanguageKeys.paymentMethod: 'طريقة الدفع',
      AppLanguageKeys.selectPaymentOptionFirst: 'يرجى اختيار طريقة الدفع أولاً',
      AppLanguageKeys.thirdInstallmentDetails: 'تفاصيل الدفعة الثالثة 20/3',
      AppLanguageKeys.paidBy: 'تم الدفع بواسطة',

      ////END////
      AppLanguageKeys.startNow: 'أبدء الأن',
      AppLanguageKeys.yourCarIsSafeWithSan: 'سيارتك بأمان مع صان',
      AppLanguageKeys.maintenanceAndRepairServices: 'خدمات الصيانة والاصلاح',
      AppLanguageKeys.emergencyService: 'خدمة الطوارئ',
      AppLanguageKeys.buyingAndSellingCars: 'بيع وشراء سيارات',
      AppLanguageKeys.listYourCarInASafeAndReliableAuctionWithSan:
          'اعرض سيارتك في مزاد آمن وموثوق مع صان ',
      AppLanguageKeys.highwayAssistance:
          'المساعدة علي الطريق السريعة  على مدار الساعة اينما كنت ',
      AppLanguageKeys.weSendYouProfessional:
          ' نرسل لك فنيين محترفين يشخصون المشكلة ويصلحونها.',
      AppLanguageKeys.integratedSolutions:
          'حلول متكاملة من الضمان والتأمين لجميع الخدمات في مكان واحد',
      AppLanguageKeys.loginAsAnIndividualOrCompany:
          'قم بتسجيل الدخول كأفراد او شركات',
      AppLanguageKeys.registerAsAnIndividual: 'تسجيل كأفراد',
      AppLanguageKeys.registerAsCompanies: 'تسجيل كشركات',
      AppLanguageKeys.orRegisterVia: 'أو تسجيل عبر',
      AppLanguageKeys.appleAccount: 'حساب أبل',
      AppLanguageKeys.googleAccount: 'جوجل',
      AppLanguageKeys.noAccount: 'ليس لديك حساب',
      AppLanguageKeys.registerHere: 'تسجيل هنا',
      AppLanguageKeys.pleaseEnterYourPhoneNumberAndPassword:
          'برجاء ادخال رقم الهاتف وكلمة المرور',
      AppLanguageKeys.phoneNumber: 'رقم الهاتف',
      AppLanguageKeys.forgotPassword: 'نسيت كلمة المرور',
      AppLanguageKeys.redeemFromHere: "استرد من هنا",
      AppLanguageKeys.loginAsAGuestUser: 'دخول كضيف مستخدم',
      AppLanguageKeys.userName: 'أسم المستخدم',
      AppLanguageKeys.email: 'الايميل',
      AppLanguageKeys.resetPassword: 'إعادة كلمة المرور',
      AppLanguageKeys.createAnAccount: 'إنشاء حساب',
      AppLanguageKeys.accountInformation:
          'برجاء ادخال بيانات الحساب وكلمة المرور',
      AppLanguageKeys.createAnAccountInTheNameOfACompany:
          'انشاء حساب باسم شركة',
      AppLanguageKeys.confirmPin: 'تأكيد الرقم السري',
      AppLanguageKeys.pleaseEnterThePinSentToYourPhoneNumber:
          'برجاء ادخال رقم السري التي تم ارسالها عل رقم الهاتف',
      AppLanguageKeys.iDidNotReceiveAMessage: 'لم اتلقي رسالة',
      AppLanguageKeys.resend: 'إعادة ارسال',
      AppLanguageKeys.yourCarData: 'بيانات سيارتك',
      AppLanguageKeys.toViewYourCarsModelsServicesAndCenters:
          'لاستعراض خدمات ومراكز الموديل سيارتك',
      AppLanguageKeys.chooseTheCategory: 'أختر الفئة ',
      AppLanguageKeys.modelYear: 'سنة الموديل',
      AppLanguageKeys.yourCarName: 'أسم سيارتك',
      AppLanguageKeys.exampleModelName: '(مثال سيارتي الهوندا - سيارة زوجتي )',
      AppLanguageKeys.chooseYourCarModel: 'أختر موديل سيارتك',
      AppLanguageKeys.youCanSearchToSelectYourCarCategory:
          'يمكنك البحث لاختيار فئة سيارتك',
      AppLanguageKeys.profile: 'الملف الشخصي',
      AppLanguageKeys.skipLater: 'تخطي لاحقا',
      AppLanguageKeys.locationServiceDisabled: "خدمة الموقع غير مفعلة",
      AppLanguageKeys.locationNotFound: "المكان غير موجود",
      AppLanguageKeys.yourLocation: 'موقعك الجغرافي',
      AppLanguageKeys.nearbyServices: 'لاستعراض خدمات قريبة منك',
      AppLanguageKeys.maintenanceAndRepair: 'الصيانة والاصلاح',
      AppLanguageKeys.oilChange: 'تغيير الزيوت',
      AppLanguageKeys.highways: 'الطرق السريعة',
      AppLanguageKeys.carElectricity: 'كهرباء سيارات',
      AppLanguageKeys.spareParts: 'قطع الغيار',
      AppLanguageKeys.mobileMaintenance: 'صيانة متنقلة',
      AppLanguageKeys.carAuction: 'حراج سيارات',
      AppLanguageKeys.transportService: 'خدمة النقل',
      AppLanguageKeys.favoriteServices: 'الخدمات المفضلة',
      AppLanguageKeys.selectFavoriteServices:
          'يمكنك تحديد الخدمات المفضلة لدينا',
      AppLanguageKeys.chooseFavoriteServices: 'أختر الخدمات المفضلة',
      AppLanguageKeys.congratulations: 'مبروووووك, لقد حصلت علي',
      AppLanguageKeys.gift: 'هدية',
      AppLanguageKeys.sunWarranty: 'ضمان صن',
      AppLanguageKeys.fiveYearsWarranty: 'لمدة 5 سنوات هدية',
      AppLanguageKeys.showServicesNow: 'عرض الخدمات الأن',
      AppLanguageKeys.sunWarrantyFeatures: 'مميزات ضمان صن',
      AppLanguageKeys.warrantyCenters:
          'الاستفادة من ضمان الخدمات عبر مراكزنا المتعمدة',
      AppLanguageKeys.carWarrantyAuction:
          'ضمان السيارات من بيع وشراء في حراج السيارات',
      AppLanguageKeys.freeMaintenance:
          'تقديم خدمات صيانة مجانية طوال فترة الضمان',
      AppLanguageKeys.home: 'الرئيسية',
      AppLanguageKeys.myOrders: 'طلباتي',
      AppLanguageKeys.map: 'الخريطة',
      AppLanguageKeys.requestService: 'أطلب خدمة',
      AppLanguageKeys.services: 'الخدمات',
      AppLanguageKeys.searchPlaceholder: 'إبحث عن اي خدمة او اسم مركز او أي شئ',
      AppLanguageKeys.tireSpareParts: "قطع غيار الاطارات",
      AppLanguageKeys.discount50: "خصومات 50%",
      AppLanguageKeys.discount: "خصومات",
      AppLanguageKeys.variousServices: "خدمات متنوعة",
      AppLanguageKeys.repairAndMaintenance: "الصيانة والاصلاح",
      AppLanguageKeys.oilServices: "تغيير زيوت",
      AppLanguageKeys.cleaningAndWashing: "غسيل ونظافة",
      AppLanguageKeys.carInsurance: "تأمين السيارة",
      AppLanguageKeys.carMarket: "حراج السيارات",
      AppLanguageKeys.periodicMaintenance: "صيانة دورية",
      AppLanguageKeys.sparePartsService: "قطع غيار",
      AppLanguageKeys.carWarranty: "ضمان السيارات",
      AppLanguageKeys.glass: "زجاج",
      AppLanguageKeys.tireChange: "تغيير الاطارات",
      AppLanguageKeys.batteries: "بطاريات",
      AppLanguageKeys.roadAssistance: "مساعدة الطريق",
      AppLanguageKeys.from: "من",
    },
    'en': {
      //status//
      AppLanguageKeys.serviceNameAr: 'Service Name (Arabic)',
      AppLanguageKeys.serviceNameEn: 'Service Name (English)',
      AppLanguageKeys.notSold: 'Not Sold',
      AppLanguageKeys.sold: 'Sold',
      AppLanguageKeys.newCar: 'New',
      AppLanguageKeys.usedCar: 'Used',
      AppLanguageKeys.newOrderForCompany: 'New Order',
      AppLanguageKeys.rejectedByCompany: 'Rejected by Company',
      AppLanguageKeys.newOrderForProvider: 'New Order',
      AppLanguageKeys.waitingAppointment: 'Waiting Appointment',
      AppLanguageKeys.employeeInRound: 'on the Way',
      AppLanguageKeys.workInProgress: 'in Progress',
      AppLanguageKeys.orderCompleted: 'Completed',
      AppLanguageKeys.rejectedByProvider: 'Rejected by Provider',
      AppLanguageKeys.cancelledByUser: 'Cancelled by User',
      //END//
      //others//
      AppLanguageKeys.oldService: 'Old Service',
      AppLanguageKeys.createService: 'Create Service',
      AppLanguageKeys.restAll: 'Reset All',
      AppLanguageKeys.selectPricingTypeFirst : "Please select the pricing type first",
      AppLanguageKeys.cost: 'Cost',
      AppLanguageKeys.confirmDelete: 'Are you sure you want to delete this item?',
      AppLanguageKeys.description: 'Description',
      AppLanguageKeys.mileage: 'Mileage',
      AppLanguageKeys.carStatus: 'Car Status',
      AppLanguageKeys.emailOrPhoneInvalid: 'Email or phone number is incorrect or inactive',
      AppLanguageKeys.phoneInvalid: 'Phone number is incorrect or inactive',
      AppLanguageKeys.userNotFound: 'User not found',
      AppLanguageKeys.wrongCode: 'Incorrect code',
      AppLanguageKeys.loginFailed: 'Login failed',
      AppLanguageKeys.enterOtp: 'Enter 4 digit code',
      AppLanguageKeys.verify: 'Verify',
      AppLanguageKeys.subscriptionEndDate: 'Subscription End Date',
      AppLanguageKeys.subscriptionStartDate: 'Subscription Start Date',
      AppLanguageKeys.annualPrice: 'Annual Price',
      AppLanguageKeys.monthlyPrice: 'Monthly Price',
      AppLanguageKeys.invoiceServices: 'Invoice Services',
      AppLanguageKeys.transferDate: 'Transfer Date',
      AppLanguageKeys.ordersCommission: 'Orders Commission',
      AppLanguageKeys.netBalance: 'Net Balance',
      AppLanguageKeys.allPayments: 'All Payments',
      AppLanguageKeys.cardPayments: 'Card Payments',
      AppLanguageKeys.cashOnDeliveryPayments: 'Cash on Delivery Payments',
      AppLanguageKeys.packageType: 'Package Type',
      AppLanguageKeys.subscriptionDuration: 'Subscription Duration',
      AppLanguageKeys.subscriptionFee: 'Subscription Fee',
      AppLanguageKeys.nextSubscriptionDate: 'Next Subscription Date',
      AppLanguageKeys.downloadInvoice: 'Download Invoice',
      AppLanguageKeys.transactionNumber: 'Transaction Number',
      AppLanguageKeys.invoiceDate: 'Invoice Date',
      AppLanguageKeys.orderStatus: 'Order Status',
      AppLanguageKeys.transactionDetails: 'Transaction Details',
      AppLanguageKeys.latinName: 'Latin Name',
      AppLanguageKeys.items: 'Items',
      AppLanguageKeys.create: 'Create',
      AppLanguageKeys.carMarketSales: 'Car Market Sales',
      AppLanguageKeys.rejectionReason: 'Reason for Request Rejection',
      AppLanguageKeys.orderInProgress: 'Order in Progress',
      AppLanguageKeys.waitingForInvoicePayment: 'Waiting for Invoice Payment',
      AppLanguageKeys.carsListCurrentAndSold: 'List of current and previously sold cars',
      AppLanguageKeys.soldCars: 'Sold Cars',
      AppLanguageKeys.carList: 'Car List',
      AppLanguageKeys.availableCarsShortList: 'Short List of Available Cars',
      AppLanguageKeys.filling: 'Filling',
      AppLanguageKeys.fillingDate: 'Filling Date',
      AppLanguageKeys.gender: 'Gender',
      AppLanguageKeys.age: 'Age',
      AppLanguageKeys.order: 'Order',
      AppLanguageKeys.authCompanyNameRequired: 'Company name is required',
      AppLanguageKeys.authEmailRequired: 'Email is required',
      AppLanguageKeys.authEnterCorrectEmail: 'Please enter a valid email address',
      AppLanguageKeys.authPasswordRequired: 'Password is required',
      AppLanguageKeys.authWeakPassword: 'Password is too weak',
      AppLanguageKeys.authPhoneNumberRequired: 'Phone number is required',
      AppLanguageKeys.authEnterCorrectPhoneNumber: 'Please enter a valid phone number',
      AppLanguageKeys.createNewPassword: 'Create New Password',
      //end//
      //message api response//
      AppLanguageKeys.passwordsDoNotMatch: 'Passwords do not match',
      AppLanguageKeys.wrongUsername: 'Wrong username',
      AppLanguageKeys.somethingWentWrong: 'Something went wrong',
      AppLanguageKeys.phoneExist: 'Phone number already exists',
      AppLanguageKeys.emailExist: 'Email already exists',
      AppLanguageKeys.emailNotExist: 'Email does not exist',
      AppLanguageKeys.emailOrPhoneExist: 'Email or phone already exists',
      AppLanguageKeys.done: 'Done successfully',
      AppLanguageKeys.notFound: 'Not found',
      AppLanguageKeys.storeNotExist: 'Store does not exist',
      AppLanguageKeys.noUser: 'User not found',
      AppLanguageKeys.wrongPassword: 'Wrong password',
      AppLanguageKeys.notActive: 'Account is not active',
      AppLanguageKeys.sameUser: 'Cannot perform action on the same user',
      AppLanguageKeys.notEnoughPoints: 'Not enough points',
      AppLanguageKeys.notEnoughBalance: 'Not enough balance',
      AppLanguageKeys.reservedUser: 'User is reserved',
      AppLanguageKeys.haveOperationForDelete: 'Cannot delete, related operations exist',
      AppLanguageKeys.wrongReferralCode: 'Wrong referral code',
      AppLanguageKeys.empty: 'No data available',
      AppLanguageKeys.expired: 'Expired',
      AppLanguageKeys.couponReachMaxUse: 'Coupon reached maximum usage',
      AppLanguageKeys.userReachMaxUseCoupon: 'User reached maximum coupon usage',
      AppLanguageKeys.pointsFromNewOrder: 'Points added from new order',
      AppLanguageKeys.categoryExist: 'Category already exists',
      //End//
      //Api Failures//
      AppLanguageKeys.oopsErrorTryAgain: 'Oops! There was an error, please try again.',
      AppLanguageKeys.internalServerError: 'Internal server error, please try later.',
      AppLanguageKeys.requestNotFound: 'Your request was not found, please try later!',
      AppLanguageKeys.badResponseError: 'Bad response, something went wrong.',
      AppLanguageKeys.success: 'Success',
      AppLanguageKeys.badRequestError: 'Bad request',
      AppLanguageKeys.unauthorizedError: 'Unauthorized access',
      AppLanguageKeys.forbiddenError: 'Access forbidden',
      AppLanguageKeys.methodNotAllowed: 'Method not allowed',
      AppLanguageKeys.requestTimeout: 'Request timeout',
      AppLanguageKeys.conflictError: 'Conflict occurred',
      AppLanguageKeys.validationError: 'Validation error',
      AppLanguageKeys.tooManyRequests: 'Too many requests, please try later',
      AppLanguageKeys.badGateway: 'Bad gateway',
      AppLanguageKeys.serviceUnavailable: 'Service unavailable',
      AppLanguageKeys.gatewayTimeout: 'Gateway timeout',
      AppLanguageKeys.noInternetConnection: 'No internet connection',

      //End//

      //login//
      AppLanguageKeys.enterUsernameAndPassword: 'Please enter username and password',
      AppLanguageKeys.fillAllFields: 'Please fill all fields',
      //End//

      //Model Messages//
      AppLanguageKeys.changePasswordSuccessfully: 'Change Password successfully',
      AppLanguageKeys.checkIfUserExistSuccessfully: 'Check If User Exist successfully',
      AppLanguageKeys.checkIfUserExistOrNotSuccessfully: 'Check If User Exist Or Not successfully',
      AppLanguageKeys.accountCreatedSuccessfully: 'Account created successfully',
      AppLanguageKeys.deleteUserSuccessfully: 'Delete User successfully',
      AppLanguageKeys.getAppUserInfoSuccessfully: 'Get App User Info successfully',
      AppLanguageKeys.accountLoginSuccessfully: 'Account Login successfully',
      AppLanguageKeys.restoreUserSuccessfully: 'Restore User successfully',
      AppLanguageKeys.updateUserSuccessfully: 'Update User successfully',

      AppLanguageKeys.changeCouponStatusSuccessfully: 'Change Coupon Status successfully',
      AppLanguageKeys.getCarSuccessfully: 'Get Car successfully',
      AppLanguageKeys.getCouponByCodeSuccessfully: 'Get Coupon By Code successfully',
      AppLanguageKeys.getStaticsForCouponSuccessfully: 'Get Statics For Coupon successfully',
      AppLanguageKeys.uploadCouponSuccessfully: 'Upload Coupon successfully',

      AppLanguageKeys.createRateSuccessfully: 'Create Rate successfully',
      AppLanguageKeys.deleteRateSuccessfully: 'Delete Rate successfully',
      AppLanguageKeys.getProviderDetailsRatesSuccessfully:
          'Get Provider Details Rates successfully',
      AppLanguageKeys.getProvidersBasicRateSuccessfully:
          'Get Providers Basic Rate successfully',
      AppLanguageKeys.updateRateSuccessfully: 'Update Rate successfully',

      AppLanguageKeys.createServiceSuccessfully: 'Create Service successfully',
      AppLanguageKeys.uploadServiceSuccessfully: 'Upload Service successfully',

      AppLanguageKeys.getAdminDashboardStatisticsSuccessfully:
          'Get Admin Dashboard Statistics successfully',
      AppLanguageKeys.getAdminMostRequestedServicesSuccessfully:
          'Get Admin Most Requested Services successfully',
      AppLanguageKeys.getCompanyCarGroupChartSuccessfully:
          'Get Company Car Group Chart successfully',
      AppLanguageKeys.getCompanyGeneralStatisticsSuccessfully:
          'Get Company General Statistics successfully',
      AppLanguageKeys.getMaintenanceReportSuccessfully:
          'Get Maintenance Report successfully',
      AppLanguageKeys.getProviderHarageMonthlySalesSuccessfully:
          'Get Provider Harage Monthly Sales successfully',
      AppLanguageKeys.getProviderHarageSalesChartSuccessfully:
          'Get Provider Harage Sales Chart successfully',
      AppLanguageKeys.getProviderHarageSoldCarsByTypeSuccessfully:
          'Get Provider Harage Sold Cars By Type successfully',
      AppLanguageKeys.getProviderMainServiceStatisticsSuccessfully:
          'Get Provider Main Service Statistics successfully',
      AppLanguageKeys.getProviderOrdersSalesSuccessfully:
          'Get Provider Orders Sales successfully',
      AppLanguageKeys.getProviderPetrolBranchesSalesSuccessfully:
          'Get Provider Petrol Branches Sales successfully',
      AppLanguageKeys.getProviderPetrolSalesChartSuccessfully:
          'Get Provider Petrol Sales Chart successfully',
      AppLanguageKeys.getProviderServiceStatisticsSuccessfully:
          'Get Provider Service Statistics successfully',
      AppLanguageKeys.getProviderTotalRateEmployeeBalanceSuccessfully:
          'Get Provider Total Rate And Employee And Balance successfully',

      AppLanguageKeys.createProductSuccess: 'Create Product successfully',
      AppLanguageKeys.deleteProductSuccess: 'Delete Product successfully',
      AppLanguageKeys.getProductSuccess: 'Get Product successfully',
      AppLanguageKeys.getProductsSuitableForCarSuccess:
          'Get Products Suitable For Car successfully',
      AppLanguageKeys.updateProductSuccess: 'Update Product successfully',

      AppLanguageKeys.addBranchSuccess: 'Add Branch successfully',
      AppLanguageKeys.createExpectedPetrolSpendSuccess:
          'Create Expected Petrol Spend successfully',
      AppLanguageKeys.createProvServiceSuccess:
          'Create Provider Service successfully',
      AppLanguageKeys.createServicePackageSuccess:
          'Create Service Package successfully',
      AppLanguageKeys.deleteExpectedPetrolSpendSuccess:
          'Delete Expected Petrol Spend successfully',
      AppLanguageKeys.deleteProvServiceSuccess:
          'Delete Provider Service successfully',
      AppLanguageKeys.deleteProviderWorkTimeSuccess:
          'Delete Provider Work Time successfully',
      AppLanguageKeys.deleteServicePackageSuccess:
          'Delete Service Package successfully',
      AppLanguageKeys.getBranchEmployeesSuccess:
          'Get Branch Employees successfully',
      AppLanguageKeys.getExpectedPetrolSpendSuccess:
          'Get Expected Petrol Spend successfully',
      AppLanguageKeys.getProviderBranchesSuccess:
          'Get Provider Branches successfully',
      AppLanguageKeys.getProviderServicePackagesSuccess:
          'Get Provider Service Packages successfully',
      AppLanguageKeys.getProviderWorkTimeSuccess:
          'Get Provider Work Time successfully',
      AppLanguageKeys.getServiceProviderDetailsForAppUserSuccess:
          'Get Service Provider Details For App User successfully',
      AppLanguageKeys.getServiceProvidersByServiceIdForAppUserSuccess:
          'Get Service Providers By Service Id For App User successfully',
      AppLanguageKeys.updateBranchSuccess: 'Update Branch successfully',
      AppLanguageKeys.updateExpectedPetrolSpendSuccess:
          'Update Expected Petrol Spend successfully',
      AppLanguageKeys.updateProvServiceSuccess:
          'Update Provider Service successfully',
      AppLanguageKeys.updateServicePackageSuccess:
          'Update Service Package successfully',
      AppLanguageKeys.uploadProviderWorkTimesSuccess:
          'Upload Provider Work Times successfully',

      AppLanguageKeys.createHarageSuccessfully: 'Create Harage successfully',
      AppLanguageKeys.deleteHarageSuccessfully: 'Delete Harage successfully',
      AppLanguageKeys.getAllHarageSuccessfully: 'Get All Harage successfully',
      AppLanguageKeys.getHarageSuccessfully: 'Get Harage successfully',
      AppLanguageKeys.updateHarageSuccessfully: 'Update Harage successfully',

      AppLanguageKeys.cancelOrderSuccessfully: 'Cancel Order successfully',
      AppLanguageKeys.createOrderSuccessfully: 'Create Order successfully',
      AppLanguageKeys.getCompanyOrdersSuccessfully:
          'Get Company Orders successfully',
      AppLanguageKeys.getOrderDetailsSuccessfully:
          'Get Order Details successfully',
      AppLanguageKeys.getOrdersSuccessfully: 'Get Orders successfully',
      AppLanguageKeys.getProviderOrdersSuccessfully:
          'Get Provider Orders successfully',
      AppLanguageKeys.updateOrderOfferStatusSuccessfully:
          'Update Order Offer Status successfully',
      AppLanguageKeys.updateOrderStatusSuccessfully:
          'Update Order Status successfully',

      AppLanguageKeys.addCardSuccessfully: 'Add Card successfully',
      AppLanguageKeys.createPaymentSuccessfully: 'Create Payment successfully',
      AppLanguageKeys.getUserCardsSuccessfully: 'Get User Cards successfully',
      AppLanguageKeys.getWalletBalanceSuccessfully:
          'Get Wallet Balance successfully',
      AppLanguageKeys.getWalletTransactionsSuccessfully:
          'Get Wallet Transactions successfully',
      AppLanguageKeys.rechargeWalletSuccessfully:
          'Recharge Wallet successfully',
      AppLanguageKeys.removeCardSuccessfully: 'Remove Card successfully',
      AppLanguageKeys.setDefaultCardSuccessfully:
          'Set Default Card successfully',

      AppLanguageKeys.assignServiceToEmployeeSuccessfully:
          'Assign Service To Employee successfully',
      AppLanguageKeys.getEmployeeServicesSuccessfully:
          'Get Employee Services successfully',

      AppLanguageKeys.addTaxSuccessfully: 'Add Tax successfully',
      AppLanguageKeys.createCarBrandSuccessfully:
          'Create Car Brand successfully',
      AppLanguageKeys.createCarModelSuccessfully:
          'Create Car Model successfully',
      AppLanguageKeys.deleteTaxSuccessfully: 'Delete Tax successfully',
      AppLanguageKeys.getAllPagesAboutSuccessfully:
          'Get All Pages About successfully',
      AppLanguageKeys.getCarBrandModelsSuccessfully:
          'Get Car Brand Models successfully',
      AppLanguageKeys.getServicesSuccessfully: 'Get Services successfully',
      AppLanguageKeys.updateCarBrandSuccessfully:
          'Update Car Brand successfully',
      AppLanguageKeys.updateCarModelSuccessfully:
          'Update Car Model successfully',
      AppLanguageKeys.updatePageAboutSuccessfully:
          'Update Page About successfully',
      AppLanguageKeys.updateTaxSuccessfully: 'Update Tax successfully',
      AppLanguageKeys.uploadPointInfoSuccessfully:
          'Upload Point Info successfully',

      AppLanguageKeys.getBannersSuccessfully: 'Get Banners successfully',
      AppLanguageKeys.uploadBannersSuccessfully: 'Upload Banners successfully',

      AppLanguageKeys.getOtherMessagesSuccessfully:
          'Get Other Messages successfully',
      AppLanguageKeys.getUserProviderMessagesSuccessfully:
          'Get User Provider Messages successfully',
      AppLanguageKeys.getWorkTeamChatSuccessfully:
          'Get Work Team Chat successfully',
      AppLanguageKeys.makeChatViewedSuccessfully:
          'Make Chat Viewed successfully',
      AppLanguageKeys.openCloseChatSuccessfully:
          'Open / Close Chat successfully',
      AppLanguageKeys.sendMessageSuccessfully: 'Send Message successfully',

      AppLanguageKeys.addCarToGroupSuccessfully:
          'Add Car To Group successfully',
      AppLanguageKeys.addCompanyDriverSuccessfully:
          'Add Company Driver successfully',
      AppLanguageKeys.createCarGroupSuccessfully:
          'Create Car Group successfully',
      AppLanguageKeys.deleteCarGroupSuccessfully:
          'Delete Car Group successfully',
      AppLanguageKeys.deleteCompanyDriverSuccessfully:
          'Delete Company Driver successfully',
      AppLanguageKeys.getCarGroupsSuccessfully: 'Get Car Groups successfully',
      AppLanguageKeys.getCompanyDriversSuccessfully:
          'Get Company Drivers successfully',
      AppLanguageKeys.getDriverDetailsSuccessfully:
          'Get Driver Details successfully',
      AppLanguageKeys.removeCarFromGroupSuccessfully:
          'Remove Car From Group successfully',
      AppLanguageKeys.updateCarGroupSuccessfully:
          'Update Car Group successfully',
      AppLanguageKeys.updateCompanyDriverSuccessfully:
          'Update Company Driver successfully',

      //End//
      //New Adds///
      AppLanguageKeys.petroleum: 'Petroleum',
      AppLanguageKeys.languageKey: 'English',
      AppLanguageKeys.dashBoardPageKey: 'Dashboard',
      AppLanguageKeys.securityPageKey: 'Security',
      AppLanguageKeys.permissionsGroupPageKey: 'Permissions Group',
      AppLanguageKeys.usersPermissionsPageKey: 'Users Permissions',
      AppLanguageKeys.userStatisticsPageKey: 'User Statistics',
      AppLanguageKeys.settingsPageKey: 'Settings',
      AppLanguageKeys.companiesPageKey: 'Companies',
      AppLanguageKeys.generalSettingsPageKey: 'General Settings',
      AppLanguageKeys.branchesPageKey: 'Branches',
      AppLanguageKeys.inventoriesPageKey: 'Inventories',
      AppLanguageKeys.banksPageKey: 'Banks',
      AppLanguageKeys.areasPageKey: 'Areas',
      AppLanguageKeys.taxesPageKey: 'Taxes',
      AppLanguageKeys.financialPeriodPageKey: 'Financial Period',
      AppLanguageKeys.costCenterPageKey: 'Cost Center',
      AppLanguageKeys.currenciesPageKey: 'Currencies',
      AppLanguageKeys.categoriesPageKey: 'Categories',
      AppLanguageKeys.skipKey: 'Skip',
      AppLanguageKeys.nextKey: 'Next',
      AppLanguageKeys.startKey: 'Start',
      AppLanguageKeys.passwordKey: 'Password',
      AppLanguageKeys.loginKey: 'Login',
      AppLanguageKeys.freeTrialKey: 'Free Trial',
      AppLanguageKeys.versionKey: 'Version',
      AppLanguageKeys.rememberMeKey: 'Remember Me',
      AppLanguageKeys.okKey: 'Ok',
      AppLanguageKeys.backButtonKey: 'Back',
      AppLanguageKeys.addAllRequiredFieldsKey: 'Add All Required Fields',
      AppLanguageKeys.passwordNotMatchKey: 'Password Not Match',
      AppLanguageKeys.passwordAtLeastKey: 'Password At Least 6 Digits',
      AppLanguageKeys.wrongPasswordKey: 'Wrong Password',

      AppLanguageKeys.signUpTitleKey: 'Create a new account',
      AppLanguageKeys.centerNameKey: 'Center name',
      AppLanguageKeys.phoneNumberKey: 'Phone number',
      AppLanguageKeys.emailKey: 'Email',
      AppLanguageKeys.confirmPasswordKey: 'Confirm password',
      AppLanguageKeys.createAccountKey: 'Create account',
      AppLanguageKeys.enterPhoneAndPasswordKey:
          'Please enter your phone number and password',
      AppLanguageKeys.forgotPasswordKey: 'Forgot password',
      AppLanguageKeys.loginAgainKey: 'Login',
      AppLanguageKeys.fromKey: 'From',
      AppLanguageKeys.toKey: 'To',
      AppLanguageKeys.backKey: 'Back',
      AppLanguageKeys.mainBranchKey: 'Main branch',
      AppLanguageKeys.editKey: 'Edit',
      AppLanguageKeys.addNewBranchKey: 'Add new branch',
      AppLanguageKeys.facilityManagementKey: 'Facility management',
      AppLanguageKeys.addMainBranchKey: 'Add main branch',
      AppLanguageKeys.branchAddressKey: 'Branch address',
      AppLanguageKeys.addressDetailsKey: 'Address details',
      AppLanguageKeys.confirmBranchLocationKey:
          'Confirm branch geographic location',
      AppLanguageKeys.saveKey: 'Save',
      AppLanguageKeys.selectCarModelKey: 'Select your car api_functions',
      AppLanguageKeys.searchCarModelKey:
          'You can search to choose the car api_functions',
      AppLanguageKeys.continueFacilityDataKey:
          'Continue filling facility information',
      AppLanguageKeys.fillFacilityDataKey:
          'Fill in your facility account information',
      AppLanguageKeys.saturdayKey: 'Saturday',
      AppLanguageKeys.sundayKey: 'Sunday',
      AppLanguageKeys.mondayKey: 'Monday',
      AppLanguageKeys.tuesdayKey: 'Tuesday',
      AppLanguageKeys.wednesdayKey: 'Wednesday',
      AppLanguageKeys.thursdayKey: 'Thursday',
      AppLanguageKeys.fridayKey: 'Friday',
      AppLanguageKeys.weekDaysKey: 'Week days',
      AppLanguageKeys.selectWorkDaysKey: 'Select working days for your store',
      AppLanguageKeys.availableTimesKey: 'Available times',
      AppLanguageKeys.selectAvailableTimeKey:
          'Select an available time to receive orders',
      AppLanguageKeys.facilityIdentityKey: 'Facility identity',
      AppLanguageKeys.attachIdentityKey: 'Attach identity',
      AppLanguageKeys.imageRequirementsKey:
          'Size must be at least (100px height * 250px width) of type (jpg, jpeg, png, gif) and not exceed 5 MB per image, up to 10 images maximum',
      AppLanguageKeys.facilityNameKey: 'Facility name',
      AppLanguageKeys.facilityNameENKey: 'Facility name (EN)',
      AppLanguageKeys.activityTypeKey: 'Activity type',
      AppLanguageKeys.emailAgainKey: 'Email',
      AppLanguageKeys.phoneAgainKey: 'Phone number',
      AppLanguageKeys.commercialRecordKey: 'Commercial registration',
      AppLanguageKeys.taxNumberKey: 'Tax number',
      AppLanguageKeys.shortAddressKey: 'Short address (4 letters)',
      AppLanguageKeys.buildingNumberKey: 'Building number',
      AppLanguageKeys.cityKey: 'City',
      AppLanguageKeys.buildingNumberAgainKey: 'Building number',
      AppLanguageKeys.commercialRecordFileKey:
          'Commercial registration certificate',
      AppLanguageKeys.attachFileKey: 'Attach file',
      AppLanguageKeys.ownerIdKey: 'Owner ID or residence card',
      AppLanguageKeys.bankNameKey: 'Bank name',
      AppLanguageKeys.beneficiaryNameKey: 'Beneficiary name',
      AppLanguageKeys.bankAccountNumberKey: 'Bank account number',
      AppLanguageKeys.swiftCodeKey: 'SWIFT code',
      AppLanguageKeys.ibanNumberKey: 'IBAN number',
      AppLanguageKeys.addKey: 'Add',
      AppLanguageKeys.newModelKey: 'New api_functions',
      AppLanguageKeys.carCategoryKey: 'Car category',
      AppLanguageKeys.nissanKey: 'Nissan',
      AppLanguageKeys.allCategoriesKey: 'All categories',
      AppLanguageKeys.nissanAllCategoriesKey: 'Nissan (All categories)',
      AppLanguageKeys.serviceSettingsKey: 'Service settings',
      AppLanguageKeys.selectModelYearsKey: 'Select api_functions years',
      AppLanguageKeys.chooseCategoryKey: 'Choose category',
      AppLanguageKeys.allCategoriesAgainKey: 'All categories',
      AppLanguageKeys.addedCarsKey: 'Added cars 1',
      AppLanguageKeys.modelRangeKey: 'Models from 2020 to 2025',
      AppLanguageKeys.porscheKey: 'Porsche',
      AppLanguageKeys.mercedesKey: 'Mercedes',
      AppLanguageKeys.lexusKey: 'Lexus',
      AppLanguageKeys.mercedesAgainKey: 'Mercedes',
      AppLanguageKeys.nissanQashqaiKey: 'Nissan Qashqai',
      AppLanguageKeys.defineModelsKey:
          'Specify car models based on the services you provide to your customers',
      AppLanguageKeys.carModelsKey: 'Car models',
      AppLanguageKeys.multipleCarsKey: 'You can select multiple cars at once',
      AppLanguageKeys.serviceSettingsDetailsKey:
          'Service settings for type, prices, and packages',
      AppLanguageKeys.addNewCarKey: 'Add new car',
      AppLanguageKeys.addCarModelKey: 'Add car api_functions',
      AppLanguageKeys.facilityDataKey: 'Facility information',
      AppLanguageKeys.identityKey: 'Identity',
      AppLanguageKeys.branchesKey: 'Branches',
      AppLanguageKeys.workingHoursKey: 'Working hours',
      AppLanguageKeys.bankAccountKey: 'Bank account',
      AppLanguageKeys.facilityManagementAgainKey: 'Facility management',
      AppLanguageKeys.facilityAccountKey: 'Facility account',
      AppLanguageKeys.carModelsTitleKey: 'Car models',
      AppLanguageKeys.serviceSettingsTitleKey: 'Service settings',
      AppLanguageKeys.nameKey: 'Name',
      AppLanguageKeys.newUserKey: 'New user',
      AppLanguageKeys.introTextKey:
          'Your ideal platform to reach customers and increase your center bookings for car services',

      AppLanguageKeys.internalMaintenanceKey: 'Internal Maintenance',
      AppLanguageKeys.sparePartsKey: 'Spare Parts',
      AppLanguageKeys.mobileServicesKey: 'Mobile Services',
      AppLanguageKeys.allOrdersKey: 'All Orders',
      AppLanguageKeys.newOrdersKey: 'New Orders',
      AppLanguageKeys.completedOrdersKey: 'Completed Orders',
      AppLanguageKeys.createNewOrderKey: 'Create New Order',
      AppLanguageKeys.orderInProgressKey: 'Order In Progress',
      AppLanguageKeys.waitingForPaymentKey: 'Waiting for Invoice Payment',
      AppLanguageKeys.serviceDeliveredKey: 'Service Delivered',
      AppLanguageKeys.accountBalanceKey: 'Account Balance',
      AppLanguageKeys.detailsKey: 'Details',
      AppLanguageKeys.ordersKey: 'Orders',
      AppLanguageKeys.internalServicesKey: 'Internal Maintenance & Services',
      AppLanguageKeys.ordersCountKey: 'Orders Count',
      AppLanguageKeys.increasePercentKey: 'Increase 3%',
      AppLanguageKeys.maintenanceAndRepairKey: 'Maintenance & Repair',
      AppLanguageKeys.revenueFromOrderKey: 'Revenue from Order #10054',
      AppLanguageKeys.jobTitleKey: 'Job Title',
      AppLanguageKeys.employeeNameKey: 'Mohamed Abdallah',
      AppLanguageKeys.requestsCountKey: '120 Orders',
      AppLanguageKeys.topEmployeesKey: 'Top Performing Employees',
      AppLanguageKeys.topOrderReceiversKey: 'Top Employees by Order Intake',
      AppLanguageKeys.servicesRatingKey: 'Service Ratings Overview',
      AppLanguageKeys.internalServicesStatsKey: 'Internal Services Statistics',
      AppLanguageKeys.executeOrderKey: 'Execute Order',
      AppLanguageKeys.internalServicesTitleKey: 'Internal Services',
      AppLanguageKeys.maintenanceAndRepairTitleKey: 'Maintenance & Repair',
      AppLanguageKeys.clientNameKey: 'Client Name',
      AppLanguageKeys.expectedEndDateKey: 'Expected Completion Date',
      AppLanguageKeys.notesKey: 'Notes',
      AppLanguageKeys.washingAndCleaningKey: 'Washing & Cleaning',
      AppLanguageKeys.jobNameKey: 'Job Title',
      AppLanguageKeys.internalServiceKey: 'Internal Services',
      AppLanguageKeys.newOrdersListKey: 'New Orders',
      AppLanguageKeys.newOrdersFromServicesKey: 'New Orders from Services',
      AppLanguageKeys.viewAllKey: 'View All',
      AppLanguageKeys.orderDateKey: 'Order Date',
      AppLanguageKeys.orderDetailsTitleKey: 'Order Details #452',
      AppLanguageKeys.viewAllOrderDetailsKey: 'View All Order Details',
      AppLanguageKeys.orderStatusKey: 'Order Status',
      AppLanguageKeys.underServiceKey: 'Under Service',
      AppLanguageKeys.allOrdersListKey: 'All Orders',
      AppLanguageKeys.ordersListFromServicesKey: 'Orders List from Services',
      AppLanguageKeys.invoiceKey: 'Invoice',
      AppLanguageKeys.insuranceInstallmentKey: 'Insurance Installment',
      AppLanguageKeys.taxesKey: 'Taxes',
      AppLanguageKeys.totalKey: 'Total',
      AppLanguageKeys.insuranceAgainKey: 'Insurance Installment',
      AppLanguageKeys.paidByKey: 'Paid By',
      AppLanguageKeys.orderCompletionKey: 'Order Completion',
      AppLanguageKeys.internalServicesProfitKey:
          'Profit from Internal Services',
      AppLanguageKeys.searchKey: 'Search',
      AppLanguageKeys.filterKey: 'Filter',
      AppLanguageKeys.servicePriceKey: 'Service Price',
      AppLanguageKeys.statisticsKey: 'Statistics',
      AppLanguageKeys.maintenanceAndInternalServicesKey:
          'Maintenance & Internal Services',
      AppLanguageKeys.ordersSectionKey: 'Orders',
      AppLanguageKeys.mobileAndTransportServicesKey:
          'Mobile & Transport Services',
      AppLanguageKeys.sparePartsSectionKey: 'Spare Parts',
      AppLanguageKeys.carMarketKey: 'Car Market',
      AppLanguageKeys.accountManagementKey: 'Account Management',
      AppLanguageKeys.permissionsKey: 'Permissions',
      AppLanguageKeys.notificationsKey: 'Notifications',
      AppLanguageKeys.adsKey: 'Advertisements',
      AppLanguageKeys.reviewsKey: 'Reviews',
      AppLanguageKeys.socialPagesAndPoliciesKey: 'Social Pages & Policies',
      AppLanguageKeys.logoutKey: 'Logout',
      AppLanguageKeys.priceKey: '450.00 SAR',
      //End//

      ////dashboard////
      AppLanguageKeys.establishmentOrders: 'Establishment Orders',

      AppLanguageKeys.waitingForApproval: 'Waiting for Approval',

      AppLanguageKeys.drivers: 'Drivers',

      AppLanguageKeys.serviceProvider: 'Service Provider',

      AppLanguageKeys.paymentSuccessful: 'Payment Successful',

      AppLanguageKeys.orderDelivery: 'Order Delivery',
      AppLanguageKeys.contactCustomer: 'Contact Customer',
      AppLanguageKeys.orderArrived: 'Order Has Arrived',

      AppLanguageKeys.sparePartsOrders: 'Spare Parts Orders',
      AppLanguageKeys.serviceOrdersList: 'Orders List from Services',
      AppLanguageKeys.shippingCompany: 'Shipping Company',

      AppLanguageKeys.carDetails: 'Car Details',
      AppLanguageKeys.viewAllOrderDetails: 'View All Order Details',
      AppLanguageKeys.carSpecifications: 'Car Specifications',
      AppLanguageKeys.carSold: 'Car Sold',

      AppLanguageKeys.filter: 'Filter',
      AppLanguageKeys.carsList:
          'Cars list of current and previously sold vehicles',
      AppLanguageKeys.allCars: 'All Cars',
      AppLanguageKeys.newCars: 'New Cars',
      AppLanguageKeys.usedCars: 'Used Cars',
      AppLanguageKeys.carCondition: 'Car Condition',
      AppLanguageKeys.messagesCount: 'Number of Messages',
      AppLanguageKeys.carPrice: 'Car Price',
      AppLanguageKeys.usage: 'Used',
      AppLanguageKeys.brandNew: 'New',

      AppLanguageKeys.yourPerfectPlatform:
          'Your perfect platform to reach customers and increase your car center bookings',
      AppLanguageKeys.employeesLogin: 'Employee Login',
      AppLanguageKeys.enterPhoneAndPassword:
          'Please enter phone number and password',

      AppLanguageKeys.writeYourMessageHere: 'Write your message here',

      AppLanguageKeys.technicalSupport: 'Technical Support',
      AppLanguageKeys.messages: 'Messages',
      AppLanguageKeys.teamMembers: 'Team Members',
      AppLanguageKeys.membersCount: 'Number of Members',
      AppLanguageKeys.searchInMessages: 'Search in Messages',

      AppLanguageKeys.employeeNameEn: 'Employee Name (EN)',
      AppLanguageKeys.employeeId: 'ID',
      AppLanguageKeys.joiningDate: 'Joining Date',
      AppLanguageKeys.address: 'Address',

      AppLanguageKeys.commercialRecordCertificate:
          'Commercial Registration Certificate',
      AppLanguageKeys.ownerIdOrResidenceCard: 'Owner ID or Residence Card',
      AppLanguageKeys.establishmentManagement: 'Establishment Management',
      AppLanguageKeys.establishmentData: 'Establishment Data',
      AppLanguageKeys.fillEstablishmentAccountData:
          'Fill in the establishment account data',
      AppLanguageKeys.identity: 'Identity',
      AppLanguageKeys.branches: 'Branches',
      AppLanguageKeys.workingHours: 'Working Hours',
      AppLanguageKeys.bankAccount: 'Bank Account',
      AppLanguageKeys.establishmentName: 'Establishment Name',
      AppLanguageKeys.establishmentNameEn: 'Establishment Name (EN)',
      AppLanguageKeys.activityType: 'Activity Type',
      AppLanguageKeys.commercialRegistration: 'Commercial Registration',
      AppLanguageKeys.taxNumber: 'Tax Number',
      AppLanguageKeys.shortAddress4Letters: 'Short Address (4 Letters)',
      AppLanguageKeys.buildingNumber: 'Building Number',
      AppLanguageKeys.city: 'City',
      AppLanguageKeys.attachFile: 'Attach File',
      AppLanguageKeys.ownerIdOrIqama: 'Owner ID or Residence Card',
      AppLanguageKeys.oilProducts: 'Oil Products',
      AppLanguageKeys.allSoldProducts: 'All Sold Products',
      AppLanguageKeys.allDisplayedProducts: 'All Displayed Products',
      AppLanguageKeys.availableDisplayedList:
          'Displayed Products Available for Sale at Stations',
      AppLanguageKeys.addNewOil: 'Add New Oil',
      AppLanguageKeys.saleDate: 'Sale Date',
      AppLanguageKeys.productPrice: 'Product Price',
      AppLanguageKeys.allFillingOrders: 'All Filling Orders',
      AppLanguageKeys.fillingOrdersSalesForAllBranches:
          'Sales from Filling Orders for All Branches',
      AppLanguageKeys.fuelFillingSalesPerBranch:
          'Fuel Filling Sales Per Branch',
      AppLanguageKeys.addDifferentServices:
          'Add different services with multiple package types',
      AppLanguageKeys.specialPackage: 'Special Package',
      AppLanguageKeys.packageName: 'Package Name',
      AppLanguageKeys.packageDescription:
          'Description of services in the package',
      AppLanguageKeys.servicesIncluded: 'Services included in the package',

      AppLanguageKeys.delete: 'Delete',
      AppLanguageKeys.sizesOrDimensions: 'Sizes or Dimensions',
      AppLanguageKeys.availableQuantity: 'Available Quantity',

      AppLanguageKeys.addSparePart: 'Add Spare Part',
      AppLanguageKeys.addSparePartDetails:
          'Add spare parts by category type and product details',
      AppLanguageKeys.allCategoriesIncluded: 'Included for all categories',
      AppLanguageKeys.specificCategory: 'Specific to category',
      AppLanguageKeys.partName: 'Part Name',
      AppLanguageKeys.spareCategory: 'Spare Category',
      AppLanguageKeys.price: 'Price',
      AppLanguageKeys.sparePartImage: 'Spare Part Image',
      AppLanguageKeys.writeText: 'Write Text',
      AppLanguageKeys.imageSizeNote:
          'Image size must not be less than (100px height * 250px width), formats (jpg, jpeg, png, gif), max 5MB per image, up to 10 images.',
      AppLanguageKeys.productDetails: 'Product Details',
      AppLanguageKeys.totalPartsInStock: 'Total Parts in Stock',
      AppLanguageKeys.numberOfSizesIfAvailable:
          'Number of Sizes (if available)',

      AppLanguageKeys.mobileServices: 'Mobile Services',
      AppLanguageKeys.towTruckRequest: 'Tow Truck Request',
      AppLanguageKeys.highwayService: 'Highway Service',
      AppLanguageKeys.selectCarModelByServices:
          'Select car models based on the services you offer to your customers',
      AppLanguageKeys.multipleCarSelectionNote:
          'You can select multiple cars at once',
      AppLanguageKeys.searchCarModel: 'You can search to select your car api_functions',
      AppLanguageKeys.chooseCategory: 'Choose Category',
      AppLanguageKeys.selectModelYears: 'Select Model Years',
      AppLanguageKeys.carCategory: 'Car Category',
      AppLanguageKeys.addCarModel: 'Add Car Model',

      AppLanguageKeys.transferCarToAnotherUser: 'Transfer Car to Another User',
      AppLanguageKeys.yourPassword: 'Your Password',
      AppLanguageKeys.newUserEmailOrPhone: 'Email or Phone of New User',
      AppLanguageKeys.reasonForTransfer: 'Reason for Account Transfer',
      AppLanguageKeys.transferNotice:
          'All previous maintenance and invoices will be transferred except your personal documents or license.',
      AppLanguageKeys.completeTransfer: 'Complete Transfer',
      AppLanguageKeys.waitingForNewUserApproval:
          'Waiting for new user approval to transfer the car',
      AppLanguageKeys.carTransferredToNewOwner:
          'Car has been transferred to a new owner',
      AppLanguageKeys.transferYourNewCar: 'Transfer Your New Car',

      AppLanguageKeys.allNotifications: 'All Notifications',
      AppLanguageKeys.searchFrom: 'Search From',
      AppLanguageKeys.to: 'To',
      AppLanguageKeys.allOrders: 'All Orders',
      AppLanguageKeys.ordersListFromServices: 'Orders list from services',
      AppLanguageKeys.newOrders: 'New Orders',
      AppLanguageKeys.completedOrders: 'Completed Orders',
      AppLanguageKeys.search: 'Search',
      AppLanguageKeys.confirm: 'Confirm',
      AppLanguageKeys.cancel: 'Cancel',
      AppLanguageKeys.logout: 'Logout',

      AppLanguageKeys.confirmLogout: 'Do you want to confirm logout_dashboard?',
      AppLanguageKeys.oils: 'Oils',
      AppLanguageKeys.allChanges: 'All Changes',
      AppLanguageKeys.allReviews: 'All Reviews',
      AppLanguageKeys.reviewsListForAllServices:
          'Reviews list for all services',
      AppLanguageKeys.totalReviews: 'Total Reviews',
      AppLanguageKeys.providersTermsAndConditions: '''
1. Registration and Approval  
The service center must register with accurate and valid information.  
Sun reserves the right to review, approve, or reject any registration request without stating reasons.  
The provider is responsible for keeping their information updated.  

2. Use of the Platform  
The provider agrees to use the platform only for authorized purposes (offering car maintenance services).  
Misuse of the platform or attempts to manipulate the system or customers are strictly prohibited.  
Any violation may result in account suspension or termination.  

3. Orders and Services  
The provider commits to delivering the agreed services with high quality and within the specified time.  
Prices offered to customers must be clear and transparent.  
Customers have the right to cancel or modify their orders according to the published cancellation policy.  

4. Financial Obligations  
Payment and collection mechanisms are managed through the Sun platform.  
The provider is responsible for any financial obligations toward customers resulting from service failure.  
Service fees or commissions may be deducted by Sun according to the approved policy.  

5. Ratings and Reviews  
Customers have the right to rate the provided services.  
Ratings are part of the platform’s public system and cannot be deleted unless they violate the policy.  

6. Liability  
The provider bears full responsibility for the quality of services provided.  
Sun is not responsible for any direct or indirect damages resulting from service execution; its role is limited to mediation between the provider and the customer.  

7. Termination of Service  
Sun reserves the right to suspend or terminate a provider’s account in case of violations or harm to the platform’s reputation.  
The provider may request account closure at any time after settling financial obligations.  

8. Amendments to the Terms  
Sun reserves the right to modify or update these terms and conditions at any time.  
Providers will be notified of any major changes via the platform or email.
''',
      AppLanguageKeys.providersPrivacyPolicy:
          "Privacy Policy for Car Service Providers\n\n1. Information Collection\nWe collect essential data related to service provider centers such as:\n- Center information (trade name – location – type of services).\n- Contact details (phone – email).\n- Account information (username – password).\n\n2. Use of Information\nThe collected information is used only for:\n- Creating and activating accounts.\n- Managing orders and services.\n- Facilitating communication between the center and the customer.\n- Improving service quality and user experience.\n\n3. Information Sharing\nWe do not share provider data with any third party outside the platform unless legally required.\nSome information, such as the center name and offered services, is visible to customers to help them choose services.\n\n4. Data Protection\nWe are committed to protecting provider data from unauthorized access through secure systems and encryption of sensitive information.\n\n5. Provider Rights\n- Access and update their registered data.\n- Request account deletion from the platform.\n- Submit feedback or complaints regarding data management.\n\n6. Policy Updates\nWe may update the privacy policy from time to time, and providers will be notified of any significant changes.",
      AppLanguageKeys.aboutSunIntro:
          "Sun is a digital platform that connects car owners with certified maintenance and service centers. We aim to make it easier for customers to reach your services and help your center grow by managing requests efficiently and professionally through a trusted, user-friendly platform.\n\nWith Sun, car centers get:\n- A wider customer base.\n- Easy management of orders and services.\n- Accurate tracking of reviews and performance.\n- Greater opportunities to increase revenue and expand operations.",
      AppLanguageKeys.contactAndPoliciesPages: 'Contact & Policy Pages',
      AppLanguageKeys.contactUs: 'Contact Us',
      AppLanguageKeys.aboutSun: 'About Sun',
      AppLanguageKeys.privacyPolicy: 'Privacy Policy',
      AppLanguageKeys.termsAndConditions: 'Terms and Conditions',
      AppLanguageKeys.sendUsMessage: 'Send Us Your Message',
      AppLanguageKeys.name: 'Name',
      AppLanguageKeys.messageText: 'Message Text',
      AppLanguageKeys.send: 'Send',

      AppLanguageKeys.advertisements: 'Advertisements',
      AppLanguageKeys.bannerImage: 'Banner Image',
      AppLanguageKeys.bannerSizeNote:
          'Recommended image size is 1108×428 pixels',
      AppLanguageKeys.uploadImage: 'Upload Image (jpg, jpeg, gif, png, webp)',
      AppLanguageKeys.link: 'Link',
      AppLanguageKeys.category: 'Category',
      AppLanguageKeys.storeOffers: 'Store Offers',
      AppLanguageKeys.durationFromTo: 'Duration From / To',
      AppLanguageKeys.createBannerAd: 'Create Banner Ad',

      AppLanguageKeys.monthly: 'Monthly',
      AppLanguageKeys.daily: 'Daily',
      AppLanguageKeys.selectTime: 'Select Time',
      AppLanguageKeys.newRequests: 'New Requests',
      AppLanguageKeys.newRequestsList: 'List of new service requests',
      AppLanguageKeys.noRequests: 'No requests currently',
      AppLanguageKeys.internalServicesStats: 'Internal Services Statistics',
      AppLanguageKeys.weekly: 'Weekly',
      AppLanguageKeys.internalServicesProfit: 'Profits from Internal Services',
      AppLanguageKeys.internalServicesRating: 'Rating for Internal Services',
      AppLanguageKeys.afterReceivingRequests: 'After Receiving Requests',
      AppLanguageKeys.jobName: 'Job Name',
      AppLanguageKeys.requestStatus: 'Request Status',
      AppLanguageKeys.underService: 'Under Service',
      AppLanguageKeys.requestDate: 'Request Date',
      AppLanguageKeys.servicePrice: 'Service Price',
      AppLanguageKeys.delivered: 'Delivered',
      AppLanguageKeys.requestRejected: 'Request Rejected',
      AppLanguageKeys.newRequest: 'New Request',

      AppLanguageKeys.addNewUser: 'Add New User',
      AppLanguageKeys.userPermissionsSettings:
          'User permissions_user Settings in the System',
      AppLanguageKeys.employeeName: 'Employee Name',
      AppLanguageKeys.jobTitle: 'Job Title',
      AppLanguageKeys.accountStatus: 'Account Status',
      AppLanguageKeys.active: 'Active',
      AppLanguageKeys.inactive: 'Inactive',
      AppLanguageKeys.picture: 'Picture',
      AppLanguageKeys.uploadPicture: 'Upload Picture',
      AppLanguageKeys.userPermissions: 'User permissions_user',
      AppLanguageKeys.statistics: 'Statistics',
      AppLanguageKeys.servicesSettings: 'Services Settings',
      AppLanguageKeys.carModelSettings: 'Car Model Settings',
      AppLanguageKeys.accountManagement: 'Account Management',
      AppLanguageKeys.permissionsManagement: 'permissions_user Management',
      AppLanguageKeys.organizationManagement: 'Organization Management',
      AppLanguageKeys.permissionsFromServices:
          'permissions_user from Services available to the user',
      AppLanguageKeys.maintenanceServices: 'Maintenance Services',

      AppLanguageKeys.nissanServiceSettings: 'Nissan Car Service Settings',
      AppLanguageKeys.serviceSettingsDetails:
          'Service settings by type, prices, and shared packages',
      AppLanguageKeys.backToSettings: 'Back to Settings Page',
      AppLanguageKeys.internalServices: 'Internal Maintenance & Services',
      AppLanguageKeys.addServices: 'Add Services',
      AppLanguageKeys.mobileAndTransportServices: 'Mobile & Transport Services',
      AppLanguageKeys.carSpareParts: 'Car Spare Parts',
      AppLanguageKeys.sharedPackages: 'Shared Packages',
      AppLanguageKeys.serviceSettings: 'Service Settings',
      AppLanguageKeys.addInternalServices:
          'Add Internal Maintenance & Services',
      AppLanguageKeys.allCategories: 'All Categories',
      AppLanguageKeys.unifiedPriceForAll: 'Unified Price for All Categories',
      AppLanguageKeys.pricePerCategory: 'Price per Category',
      AppLanguageKeys.sar: 'SAR',
      AppLanguageKeys.add: 'Add',
      AppLanguageKeys.carWash: 'Car Wash',
      AppLanguageKeys.battery: 'Battery',
      AppLanguageKeys.back: 'Back',
      AppLanguageKeys.save: 'Save',
      ////End////

      ////Change the glass////
      AppLanguageKeys.frontGlassReplacement: 'Front Glass Replacement',
      AppLanguageKeys.sideGlassReplacement: 'Side Glass Replacement',
      AppLanguageKeys.frontGlass: 'Front Glass',
      ////End////

      ////Change tires////
      AppLanguageKeys.tireBalancing: 'Tire Balancing',
      AppLanguageKeys.wheelAlignment: 'Wheel Alignment',
      ////End////

      ////Delivery laundry////
      AppLanguageKeys.packages: 'Packages',
      AppLanguageKeys.goldPackage: 'Gold Package',
      AppLanguageKeys.premiumPackage: 'Premium Package',
      AppLanguageKeys.fullCleaning: 'Full Cleaning Included',
      AppLanguageKeys.interiorPolishing: 'Interior Car Polishing',
      AppLanguageKeys.writeNotes:
          'Write your notes or needs for service providers',
      AppLanguageKeys.sendRequest: 'Send Request',
      AppLanguageKeys.requestAccepted: 'Request Accepted',
      AppLanguageKeys.highwayServiceCompleted: 'Highway Service Completed',
      AppLanguageKeys.searchYourAddress: 'Search Your Address',
      AppLanguageKeys.confirmCarLocation: 'Confirm Your Car Location',
      AppLanguageKeys.pleaseSelectCarLocation:
          'Please select your car location',
      ////End////

      ////Car Batteries////
      AppLanguageKeys.glassReplacement: 'Glass Replacement',
      AppLanguageKeys.hour: 'Hour',
      AppLanguageKeys.mobile: 'Mobile',
      AppLanguageKeys.sharedServices: 'Shared Services',
      AppLanguageKeys.sparePartsAndProducts: 'Spare Parts & Products',
      AppLanguageKeys.reviews: 'Reviews',
      AppLanguageKeys.viewReviews: 'View Reviews',
      AppLanguageKeys.bookService: 'Book Service',
      AppLanguageKeys.newItem: 'New',
      AppLanguageKeys.selectServices: 'Select the services you need',
      AppLanguageKeys.confirmService: 'Confirm Service',
      AppLanguageKeys.confirmBookingTime:
          'Confirm the suitable time to book your services',
      AppLanguageKeys.selectDay: 'Select Day',
      AppLanguageKeys.selectHour: 'Select Hour',
      AppLanguageKeys.confirmServiceBooking: 'Confirm Service Booking',
      AppLanguageKeys.appointment: 'Appointment',
      AppLanguageKeys.coupon: 'Coupon',
      AppLanguageKeys.apply: 'Apply',
      ////End////

      ////Order list////
      AppLanguageKeys.createNewRequest: 'Create New Request',
      AppLanguageKeys.requestReceived: 'Request Received',
      AppLanguageKeys.onTheWayToYou: 'On the Way to You',
      AppLanguageKeys.cancelBooking: 'Cancel Booking',
      AppLanguageKeys.rateService: 'Rate Service',
      AppLanguageKeys.writeComment: 'Write Comment',
      AppLanguageKeys.addYourComment: 'Add Your Comment',
      ////end////

      ////Request - Service////
      AppLanguageKeys.selectServiceType: 'Select Service Type',
      AppLanguageKeys.roadService: 'Roadside Service',
      AppLanguageKeys.serviceDetails: 'Service Details Needed',
      AppLanguageKeys.desiredServicePrice: 'Desired Service Price',
      AppLanguageKeys.serviceCompletionTime:
          'When do you want the service completed?',
      AppLanguageKeys.selectCurrentLocation: 'Select Your Current Location',
      AppLanguageKeys.createServiceRequest: 'Create Service Request',
      AppLanguageKeys.saturday: 'Saturday',
      AppLanguageKeys.sunday: 'Sunday',
      AppLanguageKeys.monday: 'Monday',
      AppLanguageKeys.tuesday: 'Tuesday',
      AppLanguageKeys.wednesday: 'Wednesday',
      AppLanguageKeys.thursday: 'Thursday',
      AppLanguageKeys.friday: 'Friday',
      AppLanguageKeys.enterYourData: 'Enter your data',
      AppLanguageKeys.waitingForOffers: 'Waiting to receive offers',
      AppLanguageKeys.serviceCenterOffers: 'Offers from Service Centers',
      AppLanguageKeys.mobileMaintenanceOffer: 'Mobile Maintenance',
      AppLanguageKeys.repairCenterName: 'Repair Center Name',
      AppLanguageKeys.acceptOffer: 'Accept Offer',
      AppLanguageKeys.rejectRequest: 'Reject Request',
      AppLanguageKeys.withinOneDay: 'Within One Day',
      AppLanguageKeys.requestNumber: 'Request 44121',
      AppLanguageKeys.daysAgo: '2 days ago',
      AppLanguageKeys.expectedArrival: 'Expected Arrival',
      AppLanguageKeys.notes: 'Notes',
      AppLanguageKeys.contactMaintenanceRep: 'Contact Maintenance Rep',
      AppLanguageKeys.maintenanceRep: 'Maintenance Rep',
      AppLanguageKeys.trackTechnician: 'Track Technician',
      AppLanguageKeys.openMap: 'Open Map',
      AppLanguageKeys.payBill: 'Pay Bill',
      AppLanguageKeys.brakeRepair:
          'Brake System Repair (Brake Pads Replacement)',
      AppLanguageKeys.electricalRepair:
          'Electrical Repair (Lights or Dashboard)',
      AppLanguageKeys.totalServices: 'Total Services',
      AppLanguageKeys.mobileService: 'Mobile Service',
      AppLanguageKeys.serviceRequest: 'Service Request',
      AppLanguageKeys.serviceProvidersArrival: 'Service Providers Arrival',
      AppLanguageKeys.serviceCompleted: 'Service Completed',
      AppLanguageKeys.serviceRating: 'Service Rating',
      AppLanguageKeys.notRatedYet: 'Not Rated Yet',
      ////End////

      ////Change Car////
      AppLanguageKeys.myCarData: 'My Car Data',
      AppLanguageKeys.myCar: 'My Car',
      AppLanguageKeys.setAsPrimaryCar: 'Use Car as Primary Account',
      AppLanguageKeys.wifeCar: 'My Wife\'s Car',
      AppLanguageKeys.replaceCarAsAccount: 'Replace Car as Account',
      AppLanguageKeys.mySecondCar: 'My Second Car',
      AppLanguageKeys.carBills: 'Car Bills',
      AppLanguageKeys.carOwner: 'Car Owner',
      AppLanguageKeys.carChassisNumber: 'Chassis Number',
      AppLanguageKeys.carLicense: 'Car License',
      AppLanguageKeys.carFiles: 'Car Files',
      AppLanguageKeys.transferCar: 'Transfer to another user',
      AppLanguageKeys.deleteCar: 'Delete Car',
      ////END////

      ////Wallet- Bonus - Send code to friend////
      AppLanguageKeys.wallet: 'Wallet',
      AppLanguageKeys.currentBalance: 'Current Balance',
      AppLanguageKeys.rechargeWallet: 'Recharge Wallet',
      AppLanguageKeys.walletTransactionDetails: 'Wallet Transaction Details',
      AppLanguageKeys.viewAll: 'View All',
      AppLanguageKeys.bonusBalance: 'Bonus Balance',
      AppLanguageKeys.payMaintenanceService: 'Pay Maintenance Service',
      AppLanguageKeys.rechargeFromVisa: 'Recharge from Visa No. 555',
      AppLanguageKeys.points: 'Points',
      AppLanguageKeys.myPoints: 'My Points',
      AppLanguageKeys.pointsDetails: 'Points Details',
      AppLanguageKeys.bonusPoints: 'Bonus Points',
      AppLanguageKeys.redeemPointsService: 'Redeem Points for Service',
      AppLanguageKeys.rechargeFromVisaPoints: 'Recharge from Visa No. 555',
      AppLanguageKeys.inviteFriendText:
          'Send the code to your friend and get 50 SAR on their first subscription',
      AppLanguageKeys.referralCode: 'Code',
      AppLanguageKeys.copyCode: 'Copy Code',
      AppLanguageKeys.shareLink: 'Share Link',
      AppLanguageKeys.sendToFriend: 'Send to Friend',
      AppLanguageKeys.codeCopiedSuccessfully: 'Code copied successfully!',

      ////End////

      ////Warranty////
      AppLanguageKeys.warrantyPeriod: 'For 5 years',
      AppLanguageKeys.warrantyServiceCenters:
          'Benefit from warranty services through our authorized centers',
      AppLanguageKeys.warrantyCarsMarket:
          'Car warranty for buying and selling in the car market',
      AppLanguageKeys.warrantyFreeMaintenance:
          'Free maintenance services throughout the warranty period',
      AppLanguageKeys.warrantySubscription: 'Warranty Subscription',
      AppLanguageKeys.balanceChargedSuccessfully:
          'Balance charged successfully',
      AppLanguageKeys.showServicesAtApprovedCenters:
          'Show services at approved centers',

      ////End////

      ////Profile////
      AppLanguageKeys.notifications: 'Notifications',
      AppLanguageKeys.newMessage: 'New Message',
      AppLanguageKeys.order255Expired: 'Order 255 Expired',
      AppLanguageKeys.onTheWay: 'On the Way to You',
      AppLanguageKeys.privacyTitle: 'Privacy Policy',
      AppLanguageKeys.privacyIntro: '''
      At "Sun" app, we place the utmost importance on the privacy of our users and always strive to protect their personal data. 
      This policy explains how information is collected, used, and shared when you use our services.
      
      Information We Collect
      When using Sun App, we may collect some necessary information to provide the service, such as:
      - Full Name
      - Mobile Number
      - Email Address
      - Location (with your permission, to identify the car location)
      - Order history and payment records
      
      How We Use the Information
      We use the collected information to:
      - Provide maintenance services accurately and efficiently
      - Communicate with you regarding order status or special offers
      - Improve app performance and user experience
      - Ensure security and prevent unauthorized use
      
      Information Sharing
      We do not share your data with any third party outside the "Sun" app except in the following cases:
      - With authorized maintenance centers to fulfill your requests
      - With online payment gateways to complete transactions
      - When legally required or requested by authorities
      
      Data Protection
      We are committed to applying the highest security standards to protect your data and use advanced protection technologies to prevent unauthorized access.
      
      User Rights
      You have the right at any time to:
      - Request a copy of your personal data
      - Modify or update your data
      - Request to delete your account from the app
      
      Policy Changes
      We may update the privacy policy from time to time. You will be notified of any major changes via the app or email.
      
      Contact Us
      For any inquiries regarding the privacy policy, you can contact us via:
      📧 Email: privacy@sun-app.com
      📞 Support: 9200XXXXXX
      ''',
      AppLanguageKeys.personalData: 'Personal Data',
      AppLanguageKeys.username: 'Username',
      AppLanguageKeys.nationality: 'Nationality',
      AppLanguageKeys.language: 'Language',
      AppLanguageKeys.arabic: 'Arabic',
      AppLanguageKeys.english: 'English',
      AppLanguageKeys.myAddress: 'My Address',
      AppLanguageKeys.yourCarAddress: 'Your Car Address',
      AppLanguageKeys.addAddress: 'Add Address',
      AppLanguageKeys.creditCards: 'Bank Credit Cards',
      AppLanguageKeys.cardName: 'Card Name',
      AppLanguageKeys.cardNumber: 'Card Number',
      AppLanguageKeys.cvv: '3-digit CVV',
      AppLanguageKeys.expiryDate: 'Expiry Date',
      AppLanguageKeys.addPaymentCard: 'Add Payment Card',
      AppLanguageKeys.financialTransactions: 'Financial Transactions',
      AppLanguageKeys.tires: 'Tires',
      AppLanguageKeys.qrCode: 'QR Code',
      AppLanguageKeys.scanQrCode: 'Scan QR Code',
      ////End////

      ////InsuranceNew////
      AppLanguageKeys.selectInsuranceType: 'Please select your insurance type',
      AppLanguageKeys.integrativeInsurance: 'Integrative Insurance',
      AppLanguageKeys.carModel: 'Car Model',
      AppLanguageKeys.edit: 'Edit',
      AppLanguageKeys.sixMonthlyPayments: '6 Monthly Payments',
      AppLanguageKeys.twelveMonthlyPayments: '12 Monthly Payments',
      AppLanguageKeys.semiAnnual: 'Semi-Annual',
      AppLanguageKeys.annual: 'Annual',
      AppLanguageKeys.insuranceAccountRegistration:
          'Insurance Account Registration',
      AppLanguageKeys.firstPayment: 'First Payment',

      ////End////

      ////Insurance////
      AppLanguageKeys.payment: 'Payment',
      AppLanguageKeys.insuranceOffers: 'Insurance Offers (Nissan CVR)',
      AppLanguageKeys.insuranceOffersOnly: 'Insurance Offers',
      AppLanguageKeys.comprehensiveInsurance: 'Comprehensive Insurance',
      AppLanguageKeys.thirdPartyInsurance: 'Third Party Insurance',
      AppLanguageKeys.bestOffer: 'Best Offer',
      AppLanguageKeys.scienceInsurance: 'Science Insurance',
      AppLanguageKeys.annualPayment: 'Annual Payment',
      AppLanguageKeys.cooperativeInsurance: 'Cooperative Car Insurance',
      AppLanguageKeys.enterPolicyData:
          'Enter policy details to show due payments',
      AppLanguageKeys.policyNumber: 'Insurance Policy Number',
      AppLanguageKeys.identityVerification: 'Identity Verification',
      AppLanguageKeys.checkAbsherAccount: 'Check Absher Account',
      AppLanguageKeys.loginViaAbsher:
          'Login via Absher Unified National Access',
      AppLanguageKeys.nationalIdOrIqama: 'National ID / Iqama Number',
      AppLanguageKeys.verifyAbsher: 'Verify Absher',
      AppLanguageKeys.yourInsuranceData: 'Your Insurance Data',
      AppLanguageKeys.beneficiaryName: 'Beneficiary Name',
      AppLanguageKeys.insurancePolicyNumber: 'Insurance Policy Number',
      AppLanguageKeys.nationalIdNumber: 'National ID Number',
      AppLanguageKeys.carPlateNumber: 'Car Plate Number',
      AppLanguageKeys.chassisNumber: 'Chassis Number',
      AppLanguageKeys.insuranceType: 'Insurance Type',
      AppLanguageKeys.insuranceValue: 'Insurance Value',
      AppLanguageKeys.installmentValue: 'Installment Value',
      AppLanguageKeys.linkInsuranceWithSanad:
          'Link Insurance Account with SANAD',
      AppLanguageKeys.pleaseWait: 'Please wait',
      AppLanguageKeys.policyData: 'Policy Data',
      AppLanguageKeys.annualPayments: 'Annual Payments',
      AppLanguageKeys.firstInstallment: 'First Installment - 20/3',
      AppLanguageKeys.paid: 'Paid',
      AppLanguageKeys.details: 'Details',
      AppLanguageKeys.secondInstallment: 'Second Installment - 20/5',
      AppLanguageKeys.thirdInstallment: 'Third Installment - 20/3',
      AppLanguageKeys.payInstallment: 'Pay Installment',
      AppLanguageKeys.notPaid: 'Not Paid',
      AppLanguageKeys.fourthInstallment: 'Fourth Installment - 20/5',
      AppLanguageKeys.nextInstallmentJuly: 'Next Installment 7/20',
      AppLanguageKeys.nextInstallmentAugust: 'Next Installment 8/20',
      AppLanguageKeys.invoice: 'Invoice',
      AppLanguageKeys.insuranceInstallment: 'Insurance Installment',
      AppLanguageKeys.taxes: 'Taxes',
      AppLanguageKeys.total: 'Total',
      AppLanguageKeys.paymentMethod: 'Payment Method',
      AppLanguageKeys.selectPaymentOptionFirst:
          'Please select a payment option first',
      AppLanguageKeys.thirdInstallmentDetails: 'Third Installment Details 20/3',
      AppLanguageKeys.paidBy: 'Paid by',

      ////End////
      AppLanguageKeys.startNow: 'Start now',
      AppLanguageKeys.yourCarIsSafeWithSan: 'Your car is safe with San',
      AppLanguageKeys.maintenanceAndRepairServices:
          'Maintenance and repair services',
      AppLanguageKeys.emergencyService: 'Emergency service',
      AppLanguageKeys.buyingAndSellingCars: 'Buying and selling cars',
      AppLanguageKeys.listYourCarInASafeAndReliableAuctionWithSan:
          'List your car in a safe and reliable auction with San',
      AppLanguageKeys.highwayAssistance:
          '24/7 Highway Assistance Wherever You Are',
      AppLanguageKeys.weSendYouProfessional:
          'We send you professional technicians who diagnose and fix the problem.',
      AppLanguageKeys.integratedSolutions:
          'Integrated solutions for warranty and insurance for all services in one place',
      AppLanguageKeys.loginAsAnIndividualOrCompany:
          'Log in as an individual or company',
      AppLanguageKeys.registerAsAnIndividual: 'Register as an individual',
      AppLanguageKeys.registerAsCompanies: 'Register as companies',
      AppLanguageKeys.orRegisterVia: 'Or register via',
      AppLanguageKeys.appleAccount: 'Apple account',
      AppLanguageKeys.googleAccount: 'Google',
      AppLanguageKeys.noAccount: "You don't have an account",
      AppLanguageKeys.registerHere: 'Register here',
      AppLanguageKeys.pleaseEnterYourPhoneNumberAndPassword:
          'Please enter your phone number and password',
      AppLanguageKeys.phoneNumber: 'Phone number',
      AppLanguageKeys.forgotPassword: 'Forgot password',
      AppLanguageKeys.redeemFromHere: "Redeem from here",
      AppLanguageKeys.loginAsAGuestUser: 'Login as a guest user',
      AppLanguageKeys.userName: 'User name',
      AppLanguageKeys.email: 'Email',
      AppLanguageKeys.resetPassword: 'Reset password',
      AppLanguageKeys.createAnAccount: 'Create an account',
      AppLanguageKeys.accountInformation:
          'Please enter account information and password',
      AppLanguageKeys.createAnAccountInTheNameOfACompany:
          'Create an account in the name of a company',
      AppLanguageKeys.confirmPin: 'Confirm pin',
      AppLanguageKeys.pleaseEnterThePinSentToYourPhoneNumber:
          'Please enter the pin sent to your phone number',
      AppLanguageKeys.iDidNotReceiveAMessage: 'I did not receive a message',
      AppLanguageKeys.resend: 'Resend',
      AppLanguageKeys.yourCarData: 'your car data',
      AppLanguageKeys.toViewYourCarsModelsServicesAndCenters:
          "To view your car's api_functions's services and centers",
      AppLanguageKeys.chooseTheCategory: "Choose the category",
      AppLanguageKeys.modelYear: "Model year",
      AppLanguageKeys.yourCarName: "Your car name",
      AppLanguageKeys.exampleModelName: "(Example: My Honda - My wife's car)",
      AppLanguageKeys.chooseYourCarModel: 'Choose your car api_functions',
      AppLanguageKeys.youCanSearchToSelectYourCarCategory:
          'You can search to select your car category',
      AppLanguageKeys.profile: 'Profile',
      AppLanguageKeys.skipLater: 'Skip later',
      AppLanguageKeys.locationServiceDisabled: "Location service disabled",
      AppLanguageKeys.locationNotFound: "Location not found",
      AppLanguageKeys.yourLocation: 'Your location',
      AppLanguageKeys.nearbyServices: 'Browse nearby services',
      AppLanguageKeys.maintenanceAndRepair: 'Maintenance and repair',
      AppLanguageKeys.oilChange: 'Oil change',
      AppLanguageKeys.highways: 'Highways',
      AppLanguageKeys.carElectricity: 'Car electricity',
      AppLanguageKeys.spareParts: 'Spare parts',
      AppLanguageKeys.mobileMaintenance: 'Mobile maintenance',
      AppLanguageKeys.carAuction: 'Car auction',
      AppLanguageKeys.transportService: 'Transport service',
      AppLanguageKeys.favoriteServices: 'Favorite services',
      AppLanguageKeys.selectFavoriteServices:
          'You can select your favorite services',
      AppLanguageKeys.chooseFavoriteServices: 'Choose favorite services',
      AppLanguageKeys.congratulations: 'Congratulations, you got',
      AppLanguageKeys.gift: 'Gift',
      AppLanguageKeys.sunWarranty: 'Sun warranty',
      AppLanguageKeys.fiveYearsWarranty: '5 years warranty gift',
      AppLanguageKeys.showServicesNow: 'Show services now',
      AppLanguageKeys.sunWarrantyFeatures: 'Sun warranty features',
      AppLanguageKeys.warrantyCenters:
          'Benefit from warranty at our authorized centers',
      AppLanguageKeys.carWarrantyAuction:
          'Car warranty for buy/sell in car auction',
      AppLanguageKeys.freeMaintenance:
          'Free maintenance during warranty period',
      AppLanguageKeys.home: 'Home',
      AppLanguageKeys.myOrders: 'My orders',
      AppLanguageKeys.map: 'Map',
      AppLanguageKeys.requestService: 'Request a service',
      AppLanguageKeys.services: 'Services',
      AppLanguageKeys.searchPlaceholder:
          'Search for any service, center name, or anything',
      AppLanguageKeys.tireSpareParts: "Tire spare parts",
      AppLanguageKeys.discount50: "50% discount",
      AppLanguageKeys.discount: "discount",
      AppLanguageKeys.variousServices: "Various services",
      AppLanguageKeys.repairAndMaintenance: "Repair and maintenance",
      AppLanguageKeys.oilServices: "Oil services",
      AppLanguageKeys.cleaningAndWashing: "Cleaning and washing",
      AppLanguageKeys.carInsurance: "Car insurance",
      AppLanguageKeys.carMarket: "Car market",
      AppLanguageKeys.periodicMaintenance: "Periodic maintenance",
      AppLanguageKeys.sparePartsService: "Spare parts service",
      AppLanguageKeys.carWarranty: "Car warranty",
      AppLanguageKeys.glass: "Glass",
      AppLanguageKeys.tireChange: "Tire change",
      AppLanguageKeys.batteries: "Batteries",
      AppLanguageKeys.roadAssistance: "Road assistance",
      AppLanguageKeys.from: "from",
    },
  };

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String translate(String key) {
    return _localizedValues[locale.languageCode]![key] ?? key;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return supportedLocales.contains(locale);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
