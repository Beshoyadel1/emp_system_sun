# دليل الربط والتطوير الشامل: Firebase، تسجيل الدخول، نظام المحادثات، وجرس الإشعارات
## Comprehensive Guide: Firebase, Login, Chat System & Notification Bell for San Employee System (`emp_system_sun`)

---

## الفهرس / Table of Contents
1. [نظرة عامة والفرق بين نظام المزود والموظف (Overview & Architectural Alignment)](#1-نظرة-عامة-والفرق-بين-نظام-المزود-والموظف)
2. [المرحلة الأولى: تهيئة وربط Firebase والمكتبات المطلوبة (Firebase & Dependencies Setup)](#2-المرحلة-الأولى-تهيئة-وربط-firebase-والمكتبات-المطلوبة)
   - [2.1 تحديث pubspec.yaml](#21-تحديث-pubspecyaml)
   - [2.2 إعدادات الويب (web/firebase-messaging-sw.js و web/index.html)](#22-إعدادات-الويب-webfirebase-messaging-swjs-و-webindexhtml)
   - [2.3 ملف firebase_options.dart](#23-ملف-firebase_optionsdart)
   - [2.4 تعديل وتحديث main.dart](#24-تعديل-وتحديث-maindart)
3. [المرحلة الثانية: البنية التحتية والخدمات الأساسية (Core Infrastructure)](#3-المرحلة-الثانية-البنية-التحتية-والخدمات-الأساسية)
   - [3.1 تحديث روابط وثوابت الـ API (api_constants.dart)](#31-تحديث-روابط-وثوابت-الـ-api-api_constantsdart)
   - [3.2 تحديث التخزين المحلي (auth_local_storage.dart)](#32-تحديث-التخزين-المحلي-auth_local_storagedart)
   - [3.3 خدمات إشعارات المتصفح (Browser Notification Services)](#33-خدمات-إشعارات-المتصفح-browser-notification-services)
   - [3.4 خدمة Firebase Cloud Messaging للموظف (fcm_service.dart)](#34-خدمة-firebase-cloud-messaging-للموظف-fcm_servicedart)
4. [المرحلة الثالثة: تسجيل الدخول وتحديث التوكن (Login Flow & Token Sync)](#4-المرحلة-الثالثة-تسجيل-الدخول-وتحديث-التوكن)
   - [4.1 تعديل نموذج LoginRequest](#41-تعديل-نموذج-loginrequest)
   - [4.2 تحديث AuthCubit لدعم FCM والـ Employee Type](#42-تحديث-authcubit-لدعم-fcm-والـ-employee-type)
   - [4.3 تحديث واجهة تسجيل الدخول (login_widget.dart)](#43-تحديث-واجهة-تسجيل-الدخول-login_widgetdart)
5. [المرحلة الرابعة: نظام المحادثات والدعم الفني للموظف (Modern Responsive Chat System)](#5-المرحلة-الرابعة-نظام-المحادثات-والدعم-الفني-للموظف)
   - [5.1 نماذج المحادثة (employee_chat_model.dart)](#51-نماذج-المحادثة-employee_chat_modeldart)
   - [5.2 تحديث ناقل أحداث الشات الفوري (chat_events.dart)](#52-تحديث-ناقل-أحداث-الشات-الفوري-chat_eventsdart)
   - [5.3 مستودع محادثات الموظف (employee_chat_repository.dart)](#53-مستودع-محادثات-الموظف-employee_chat_repositorydart)
   - [5.4 إدارة حالة المحادثات (EmployeeChatCubit & State)](#54-إدارة-حالة-المحادثات-employeechatcubit--state)
   - [5.5 واجهات المحادثة المتجاوبة (EmployeeChatPage & Widgets)](#55-واجهات-المحادثة-المتجاوبة-employeechatpage--widgets)
   - [5.6 حقن الاعتماديات والمسار (setup_git_it.dart & map_of_all_app.dart)](#56-حقن-الاعتماديات-والمسار-setup_git_itdart--map_of_all_appdart)
6. [المرحلة الخامسة: جرس الإشعارات وصفحة الإشعارات الشاملة (Notification Bell & Page)](#6-المرحلة-الخامسة-جرس-الإشعارات-وصفحة-الإشعارات-الشاملة)
   - [5.1 ويدجت جرس الإشعارات (NotificationBell)](#61-ويدجت-جرس-الإشعارات-notificationbell)
   - [6.2 صفحة الإشعارات الكاملة (NotificationsPage)](#62-صفحة-الإشعارات-الكاملة-notificationspage)
   - [6.3 تحديث AppBar في المتجر / لوحة التحكم (app_bar_for_page.dart)](#63-تحديث-appbar-في-المتجر--لوحة-التحكم-app_bar_for_pagedart)
7. [قائمة الفحص والاختبار (Verification & Testing Checklist)](#7-قائمة-الفحص-والاختبار)

---

## 1. نظرة عامة والفرق بين نظام المزود والموظف

في نظام المزود (`provider_system_sun`) تم تطبيق بنية متكاملة لـ:
1. **Firebase Cloud Messaging (FCM)**: استقبال الإشعارات في الخلفية والواجهة (Foreground & Background)، وحفظ وتحديث التوكن تلقائياً مع السيرفر.
2. **تسجيل الدخول الذكي**: إرسال `fcmToken` مع طلب تسجيل الدخول، والمزامنة الفورية عند الفتح التلقائي (Auto-login)، ومسحه عند تسجيل الخروج.
3. **نظام محادثات احترافي متجاوب (Responsive 3-Panel Chat)**: يدعم شاشات الديسكتوب، التابلت، والموبايل مع تفاعل فوري عبر `ChatEvents` والصوتيات وحساب الرسائل غير المقروءة.
4. **جرس إشعارات عصري (Notification Bell)**: مع شارة عدد الإشعارات غير المقروءة وقائمة منبثقة تفاعلية وصفحة كاملة لعرض التاريخ.

### الفروقات الجوهرية لمواصفات الموظف (`emp_system_sun`):
| الميزة / المعيار | نظام المزود (`provider_system_sun`) | نظام الموظف (`emp_system_sun`) |
| :--- | :--- | :--- |
| **نوع المستخدم (`UserType`)** | `UserType.providerUser` (القيمة `4`) | `UserType.employeeUser` (القيمة `5`) |
| **قناة الاشتراك (`FCM Topic`)** | `provider` و `all` | `employee` و `all` |
| **بيانات المستخدم الإضافية** | `providerDetails` (سجل تجاري، ضريبة، آيبان، إلخ) | `employeeDetails` (المسمى الوظيفي، الفرع، ورقم المزود التابع له `provid`) |
| **نطاق المحادثات وفريق العمل** | المزود يتحدث مع العملاء وفريقه ومسؤولي النظام | الموظف يتحدث مع العملاء، ومزوده المسؤول، وزملائه الفنيين في نفس المنشأة |
| **صلاحيات الدعم والطلبات** | إدارة شاملة لكافة طلبات المنشأة | إدارة الطلبات والمهام المسندة للموظف أو لفرعه |

---

## 2. المرحلة الأولى: تهيئة وربط Firebase والمكتبات المطلوبة

### 2.1 تحديث `pubspec.yaml`
افتح ملف [pubspec.yaml](file:///d:/Flutter-Projects/emp_system_sun/pubspec.yaml) وأضف الحزم التالية تحت قسم `dependencies`:

```yaml
dependencies:
  flutter:
    sdk: flutter

  # ... الحزم الموجودة مسبقاً ...
  
  # Firebase Packages
  firebase_core: ^3.8.1
  firebase_messaging: ^15.1.6
  
  # Utilities for UI & Formatting
  shimmer: ^3.0.0
  intl: ^0.19.0
```

بعد الحفظ، نفّذ الأمر التالي في الطرفية (Terminal):
```bash
flutter pub get
```

---

### 2.2 إعدادات الويب (Web Push Notifications)

#### أ) إنشاء ملف Service Worker: `web/firebase-messaging-sw.js`
أنشئ ملفاً جديداً باسم [firebase-messaging-sw.js](file:///d:/Flutter-Projects/emp_system_sun/web/firebase-messaging-sw.js) وضع به المحتوى التالي (معدل ومخصص لنظام الموظف):

```javascript
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

if (!firebase.apps.length) {
  firebase.initializeApp({
    apiKey: "AIzaSyB8Lixy-XF0V_UCTGCzUz0AEBzLgIP-7ik",
    appId: "1:567407553652:web:d510db5fa139b829b7b521",
    messagingSenderId: "567407553652",
    projectId: "sun-app-6c6af",
    authDomain: "sun-app-6c6af.firebaseapp.com",
    storageBucket: "sun-app-6c6af.firebasestorage.app",
    measurementId: "G-R3BVP1XBXZ",
  });
}

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  console.log("[firebase-messaging-sw.js] Received background message for Employee: ", payload);

  if (payload.notification && (payload.notification.title || payload.notification.body)) {
    return;
  }

  const notificationTitle =
      payload.data?.title || payload.data?.latintitle || "San Employee System";
  const notificationOptions = {
    body:
        payload.data?.body ||
        payload.data?.description ||
        payload.data?.message ||
        "",
    icon: "/favicon.png",
    data: payload.data,
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});

self.addEventListener("notificationclick", (event) => {
  event.notification.close();
  event.waitUntil(
    clients
      .matchAll({ type: "window", includeUncontrolled: true })
      .then((clientList) => {
        for (const client of clientList) {
          if (client.url && "focus" in client) {
            return client.focus();
          }
        }
        if (clients.openWindow) {
          return clients.openWindow("/");
        }
      })
  );
});
```

#### ب) تحديث ملف `web/index.html`
عدّل ملف [index.html](file:///d:/Flutter-Projects/emp_system_sun/web/index.html) لإضافة كود تسجيل الـ Service Worker ودالة عرض الإشعارات الأصلية في المتصفح قبل وسم `</head>` أو في بداية `<body>`:

```html
  <script>
    if ('serviceWorker' in navigator) {
      window.addEventListener('load', function () {
        navigator.serviceWorker.register('/firebase-messaging-sw.js', { scope: '/' }).catch(function (error) {
          console.warn('Firebase Messaging Service Worker registration failed: ', error);
        });
      });
    }

    window.showBrowserNotification = function(title, body) {
      if (!('Notification' in window)) return;
      if (Notification.permission === 'granted') {
        try {
          new Notification(title, { body: body, icon: '/favicon.png' });
        } catch (e) {
          console.warn('Notification display failed: ', e);
        }
      } else if (Notification.permission !== 'denied') {
        Notification.requestPermission().then(function(permission) {
          if (permission === 'granted') {
            try {
              new Notification(title, { body: body, icon: '/favicon.png' });
            } catch (e) {
              console.warn('Notification display failed: ', e);
            }
          }
        });
      }
    };
  </script>
```

---

### 2.3 ملف `lib/firebase_options.dart`
أنشئ ملفاً جديداً باسم [firebase_options.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/firebase_options.dart) يحتوي على إعدادات مشروع Firebase المشترك (`sun-app-6c6af`):

```dart
// File generated for FlutterFire.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      default:
        return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB8Lixy-XF0V_UCTGCzUz0AEBzLgIP-7ik',
    appId: '1:567407553652:web:d510db5fa139b829b7b521',
    messagingSenderId: '567407553652',
    projectId: 'sun-app-6c6af',
    authDomain: 'sun-app-6c6af.firebaseapp.com',
    storageBucket: 'sun-app-6c6af.firebasestorage.app',
    measurementId: 'G-R3BVP1XBXZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVzMyvPlxSNcr1TNJzmts5XdCg4YKTY40',
    appId: '1:567407553652:android:3bebbf4d3f7bda33b7b521',
    messagingSenderId: '567407553652',
    projectId: 'sun-app-6c6af',
    storageBucket: 'sun-app-6c6af.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADbYHlqshr5QBhF4EG6wizEhusFJbRRqY',
    appId: '1:567407553652:ios:4f2ed01919ea4797b7b521',
    messagingSenderId: '567407553652',
    projectId: 'sun-app-6c6af',
    storageBucket: 'sun-app-6c6af.firebasestorage.app',
    iosBundleId: 'com.san.app.sanApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyADbYHlqshr5QBhF4EG6wizEhusFJbRRqY',
    appId: '1:567407553652:ios:4f2ed01919ea4797b7b521',
    messagingSenderId: '567407553652',
    projectId: 'sun-app-6c6af',
    storageBucket: 'sun-app-6c6af.firebasestorage.app',
    iosBundleId: 'com.san.app.sanApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB8Lixy-XF0V_UCTGCzUz0AEBzLgIP-7ik',
    appId: '1:567407553652:web:f6d1d4714fdb64abb7b521',
    messagingSenderId: '567407553652',
    projectId: 'sun-app-6c6af',
    authDomain: 'sun-app-6c6af.firebaseapp.com',
    storageBucket: 'sun-app-6c6af.firebasestorage.app',
    measurementId: 'G-VTQJ6BYFWX',
  );
}
```

---

### 2.4 تعديل وتحديث `lib/main.dart`
قم بتحديث ملف [lib/main.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/main.dart) لتهيئة Firebase وتشغيل مستمع الرسائل في الخلفية:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:emp_system_sun/core/audio_service/audio_service.dart';
import 'package:emp_system_sun/core/services/fcm_service.dart';
import 'package:emp_system_sun/firebase_options.dart';
import 'package:emp_system_sun/features/auth_page/presentation/auth_gate.dart';
import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:emp_system_sun/features/notifications/presentation/bloc/notification_cubit/notification_cubit.dart';
import 'core/cubit/app_cubit/app_cubit.dart';
import 'core/language/language_cubit/language_cubit.dart';
import 'core/language/language_cubit/language_states.dart';
import 'core/language/language.dart';
import 'core/setup_git_it.dart';

final GlobalKey<ScaffoldState> scaffoldKeyDrawer = GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (kIsWeb || (defaultTargetPlatform != TargetPlatform.windows && defaultTargetPlatform != TargetPlatform.linux)) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      if (!kIsWeb) {
        FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      }
    }
  } catch (e) {
    debugPrint("Firebase init note: $e");
  }
  
  setupGetIt();
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NotificationCubit()..getUserNotification(),
        ),
        BlocProvider<LanguageCubit>(
          create: (_) => getIt<LanguageCubit>()..getLanguageFromSharedPreference(),
        ),
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit()..init(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void reassemble() {
    super.reassemble();
    AudioService.instance.stopNotificationSound();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => getIt<AppCubit>(),
      child: BlocBuilder<LanguageCubit, LanguageStates>(
        buildWhen: (previous, current) => current is ChangeAllAppLanguageState,
        builder: (BuildContext context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            scaffoldMessengerKey: scaffoldKey,
            supportedLocales: supportedLocales,
            locale: LanguageCubit.get(context).selectedLanguage,
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            title: 'San Employee System',
            debugShowCheckedModeBanner: false,
            home: const AuthGate(),
          );
        },
      ),
    );
  }
}
```

---

## 3. المرحلة الثانية: البنية التحتية والخدمات الأساسية

### 3.1 تحديث روابط وثوابت الـ API (`lib/core/api/dio_function/api_constants.dart`)
عدّل ملف [api_constants.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/core/api/dio_function/api_constants.dart) لإضافة نقاط النهاية (Endpoints) الخاصة بالإشعارات والـ VAPID Key ومواضيع الإشعارات:

```dart
// أضف داخل كلاس ApiLink:
  static const String subscribeToTopic =
      "${ApiConfig.baseUrlApi}/${ApiConfig.notification}/SubscribeToTopic";
  static const String unsubscribeFromTopic =
      "${ApiConfig.baseUrlApi}/${ApiConfig.notification}/UnsubscribeFromTopic";
  static const String updateFcmToken =
      "${ApiConfig.baseUrlApi}/${ApiConfig.user}/UpdateFcmToken";

// أضف هذه الفئات في نهاية الملف:
class FcmConfig {
  static const String webVapidKey = String.fromEnvironment(
    'FCM_WEB_VAPID_KEY',
    defaultValue:
        'BG3cqTKmSY0BSiXdMxTcitn7rNvFWiQMrevN0TM1_N6h6DBduRg9XGsrIwDVrUDn-E89Itt0GDBBfRyf3YL_dSU',
  );
}

class NotificationTopic {
  static const String customer = "customer";
  static const String company = "company";
  static const String driver = "driver";
  static const String provider = "provider";
  static const String employee = "employee";
  static const String admin = "admin";
}
```

---

### 3.2 تحديث التخزين المحلي (`lib/core/theming/auth_local_storage.dart`)
أضف دوال حفظ واسترجاع توكن الـ FCM داخل [auth_local_storage.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/core/theming/auth_local_storage.dart):

```dart
  static const String fcmTokenKey = "fcm_token";

  static Future<void> saveFcmToken(String token) async {
    await _storage.write(
      key: fcmTokenKey,
      value: token,
    );
  }

  static Future<String?> getFcmToken() async {
    return await _storage.read(key: fcmTokenKey);
  }

  static Future<void> deleteFcmToken() async {
    await _storage.delete(key: fcmTokenKey);
  }
```

---

### 3.3 خدمات إشعارات المتصفح (`lib/core/services/browser_notification*`)
أنشئ مجلد `lib/core/services` وأنشئ الملفات الثلاثة التالية للتعامل مع الويب ومنصات الموبايل بدون تعارض (Conditional Export):

1. **[lib/core/services/browser_notification.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/core/services/browser_notification.dart)**:
```dart
import 'browser_notification_stub.dart'
    if (dart.library.js_interop) 'browser_notification_web.dart';

void showBrowserNotification(String title, String body) {
  showNativeBrowserNotification(title, body);
}
```

2. **[lib/core/services/browser_notification_stub.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/core/services/browser_notification_stub.dart)**:
```dart
void showNativeBrowserNotification(String title, String body) {}
```

3. **[lib/core/services/browser_notification_web.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/core/services/browser_notification_web.dart)**:
```dart
import 'dart:js_interop';

@JS('showBrowserNotification')
external void _showBrowserNotification(JSString title, JSString body);

void showNativeBrowserNotification(String title, String body) {
  try {
    _showBrowserNotification(title.toJS, body.toJS);
  } catch (_) {}
}
```

---

### 3.4 خدمة Firebase Cloud Messaging للموظف (`lib/core/services/fcm_service.dart`)
أنشئ الملف [lib/core/services/fcm_service.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/core/services/fcm_service.dart) مع ضبط التخصيص الكامل للموظف (`UserType.employeeUser` والموضوع `employee`):

```dart
import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:emp_system_sun/core/api/dio_function/dio_controller.dart';
import 'package:emp_system_sun/core/services/browser_notification.dart';
import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:emp_system_sun/features/notifications/presentation/bloc/notification_cubit/notification_cubit.dart';
import 'package:emp_system_sun/features/notifications/presentation/module/notification_module/notification_module.dart';
import 'package:emp_system_sun/main.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('FCM: Background message received: ${message.messageId}');
  }
}

class FcmService {
  FcmService._();

  static final FcmService instance = FcmService._();

  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  static bool get isSupported {
    if (kIsWeb) return true;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return true;
      default:
        return false;
    }
  }

  Future<void> init() async {
    if (!isSupported) {
      if (kDebugMode) {
        print('FCM: Platform not supported. Skipping init.');
      }
      return;
    }

    if (_isInitialized) return;

    try {
      final messaging = FirebaseMessaging.instance;

      // طلب الإذن
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (kDebugMode) {
        print('FCM: Authorization status: ${settings.authorizationStatus}');
      }

      // جلب التوكن
      _fcmToken = await getToken(vapidKey: FcmConfig.webVapidKey);
      if (_fcmToken != null && _fcmToken!.isNotEmpty) {
        await _syncTokenIfUserAvailable(_fcmToken!);
      }

      // الاستماع لتجديد التوكن
      messaging.onTokenRefresh.listen((newToken) {
        _fcmToken = newToken;
        _syncTokenIfUserAvailable(newToken);
      });

      // الاستماع للرسائل في الواجهة (Foreground)
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _handleRemoteMessage(message);
      });

      // الضغط على الإشعار وفتح التطبيق
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _handleRemoteMessage(message);
      });

      _isInitialized = true;
    } catch (e, stack) {
      if (kDebugMode) {
        print('FCM: Initialization error: $e\n$stack');
      }
    }
  }

  Future<String>? _pendingGetToken;

  Future<String> getToken({String? vapidKey}) async {
    if (_pendingGetToken != null) return _pendingGetToken!;
    _pendingGetToken = _internalGetToken(vapidKey: vapidKey);
    try {
      return await _pendingGetToken!;
    } finally {
      _pendingGetToken = null;
    }
  }

  Future<String> _internalGetToken({String? vapidKey}) async {
    if (isSupported) {
      try {
        final effectiveVapidKey = (vapidKey != null && vapidKey.trim().isNotEmpty)
            ? vapidKey.trim()
            : FcmConfig.webVapidKey.trim();

        final token = await FirebaseMessaging.instance
            .getToken(
          vapidKey: (kIsWeb && effectiveVapidKey.isNotEmpty) ? effectiveVapidKey : null,
        )
            .timeout(
          const Duration(seconds: 10),
          onTimeout: () => null,
        );

        if (token != null && token.trim().isNotEmpty) {
          _fcmToken = token.trim();
          await AuthLocalStorage.saveFcmToken(_fcmToken!);
          return _fcmToken!;
        }
      } catch (e) {
        if (kDebugMode) print('FCM getToken note: $e');
      }
    }

    if (_fcmToken != null && _fcmToken!.trim().isNotEmpty) return _fcmToken!;

    final savedToken = await AuthLocalStorage.getFcmToken();
    if (savedToken != null && savedToken.trim().isNotEmpty) {
      _fcmToken = savedToken.trim();
      return _fcmToken!;
    }

    // بديل للأجهزة التي لا تدعم FCM المباشر في بيئة التطوير
    final fallbackToken = await _getOrCreateFallbackToken();
    _fcmToken = fallbackToken;
    return fallbackToken;
  }

  Future<String> _getOrCreateFallbackToken() async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomSuffix = (Random().nextInt(900000) + 100000).toString();
    final platformTag = kIsWeb ? 'web' : defaultTargetPlatform.name.toLowerCase();
    final generated = 'fcm_${platformTag}_${timestamp}_$randomSuffix';
    await AuthLocalStorage.saveFcmToken(generated);
    return generated;
  }

  Future<void> syncCurrentToken({int? userId, int? userType}) async {
    final user = await AuthLocalStorage.getUser();
    final effectiveUserId = userId ?? user?.userid;
    // تخصيص الموظف: UserType.employeeUser (5)
    final effectiveUserType = userType ?? user?.type ?? UserType.employeeUser;

    if (effectiveUserId != null && effectiveUserId > 0) {
      final token = await getToken(vapidKey: FcmConfig.webVapidKey);
      if (token.isNotEmpty) {
        await _syncTokenWithBackend(
          userId: effectiveUserId,
          userType: effectiveUserType,
          token: token,
        );
      }
    }
  }

  Future<void> _syncTokenIfUserAvailable(String token) async {
    if (token.trim().isEmpty) return;
    final user = await AuthLocalStorage.getUser();
    if (user != null && user.userid != null && user.userid! > 0) {
      await _syncTokenWithBackend(
        userId: user.userid!,
        userType: user.type ?? UserType.employeeUser,
        token: token,
      );
    }
  }

  Future<void> _syncTokenWithBackend({
    required int userId,
    required int userType,
    required String token,
  }) async {
    final cleanToken = token.trim();
    if (cleanToken.isEmpty) return;

    try {
      final payload = {
        'userId': userId,
        'UserId': userId,
        'userType': userType,
        'UserType': userType,
        'fcmToken': cleanToken,
        'FcmToken': cleanToken,
        'FCMTOKEN': cleanToken,
      };

      await Network.postDataWithBodyAndParams(
        payload,
        payload,
        ApiLink.updateFcmToken,
      );
      await AuthLocalStorage.saveFcmToken(cleanToken);

      if (kDebugMode) {
        print('FCM: Successfully synced token with backend for Employee $userId (type $userType)');
      }

      // الاشتراك في موضوع إشعارات الموظفين
      if (isSupported && !cleanToken.startsWith('fcm_')) {
        await subscribeToTopic(NotificationTopic.employee, userType: userType);
        await subscribeToTopic('all', userType: userType);
      }
    } catch (e) {
      if (kDebugMode) print('FCM sync error: $e');
    }
  }

  Future<void> subscribeToTopic(String topic, {int? userType}) async {
    final token = _fcmToken ?? await AuthLocalStorage.getFcmToken();
    if (token == null || token.isEmpty || token.startsWith('fcm_')) return;

    if (!kIsWeb) {
      try {
        await FirebaseMessaging.instance.subscribeToTopic(topic);
      } catch (_) {}
    }

    try {
      final body = jsonEncode({
        'fcmToken': token,
        'topic': topic,
        if (userType != null) 'userType': userType,
      });
      await Network.postDataWithBody(body, ApiLink.subscribeToTopic);
    } catch (_) {}
  }

  void _handleRemoteMessage(RemoteMessage message) {
    try {
      final data = Map<String, dynamic>.from(message.data);
      final rawType = (data['type'] ?? data['eventType'] ?? '').toString();
      final normType = rawType.toLowerCase().replaceAll('_', '');

      final title = message.notification?.title ??
          data['title'] ??
          data['latintitle'] ??
          data['ar_title'] ??
          data['en_title'] ??
          data['fromusername'] ??
          data['sender'] ??
          'إشعار جديد للموظف';
      final body = message.notification?.body ??
          data['body'] ??
          data['description'] ??
          data['latindesc'] ??
          data['ar_body'] ??
          data['en_body'] ??
          data['message'] ??
          data['text'] ??
          '';

      showBrowserNotification(title.toString(), body.toString());

      final adaptedPayload = <String, dynamic>{
        'type': rawType,
        'title': title.toString(),
        'body': body.toString(),
        'data': data,
        ...data,
      };

      final isChatPayload = normType == 'chat' ||
          normType == 'receivemessage' ||
          data.containsKey('fromuser') ||
          data.containsKey('fromUser');

      final isNewOrderPayload = normType == 'neworder' ||
          data.containsKey('orderinfo') ||
          data.containsKey('orderInfo');

      final isUpdateOrderStatusPayload = normType == 'updateorderstatus' ||
          normType == 'orderstatus';

      if (isNewOrderPayload) {
        NotificationModule.instance.newOrderHandler.handle([adaptedPayload]);
      } else if (isUpdateOrderStatusPayload) {
        NotificationModule.instance.updateOrderStatusHandler.handle([adaptedPayload]);
        NotificationModule.instance.receiveNotificationHandler.handle([adaptedPayload]);
      } else if (isChatPayload) {
        NotificationModule.instance.receiveMessageHandler.handle([adaptedPayload]);
      } else {
        NotificationModule.instance.receiveNotificationHandler.handle([adaptedPayload]);
      }

      // تحديث جرس الإشعارات في الواجهة فورا
      final ctx = navigatorKey.currentContext;
      if (ctx != null) {
        BlocProvider.of<NotificationCubit>(ctx, listen: false).getUserNotification();
      }
    } catch (e, stack) {
      if (kDebugMode) print('FCM processing error: $e\n$stack');
    }
  }

  Future<void> disconnect() async {
    _isInitialized = false;
    _fcmToken = null;
    await AuthLocalStorage.deleteFcmToken();
  }
}
```

---

## 4. المرحلة الثالثة: تسجيل الدخول وتحديث التوكن

### 4.1 تعديل نموذج `LoginRequest`
عدّل ملف [lib/features/auth_page/data/request/login_request/login_request.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/features/auth_page/data/request/login_request/login_request.dart) ليشمل حقل `fcmToken`:

```dart
class LoginRequest {
  final String user;
  final String password;
  final int type;
  final String? fcmToken;

  LoginRequest({
    required this.user,
    required this.password,
    required this.type,
    this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    final cleanToken = fcmToken?.trim();
    return {
      "USER": user,
      "PASSWORD": password,
      "type": type,
      if (cleanToken != null && cleanToken.isNotEmpty) ...{
        "fcmtoken": cleanToken,
        "fcmToken": cleanToken,
        "FCMTOKEN": cleanToken,
      },
    };
  }
}
```

---

### 4.2 تحديث `AuthCubit` لدعم FCM والـ Employee Type
عدّل ملف [lib/features/auth_page/presentation/bloc/auth_cubit/auth_cubit.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/features/auth_page/presentation/bloc/auth_cubit/auth_cubit.dart):

#### أ) دالة `init()` (Auto Login):
```dart
  Future<void> init() async {
    emit(AuthLoading());

    // تجهيز التوكن في الخلفية مسبقاً
    unawaited(FcmService.instance.getToken(vapidKey: FcmConfig.webVapidKey));

    final localUser = await AuthLocalStorage.getUser();
    final password = await AuthLocalStorage.getPassword();

    if (localUser == null || password == null) {
      emit(AuthUnauthenticated());
      return;
    }

    final fcmToken = await FcmService.instance.getToken(vapidKey: FcmConfig.webVapidKey);

    final result = await loginFunction(
      loginRequest: LoginRequest(
        user: localUser.email!,
        password: password,
        type: UserType.employeeUser, // تخصيص نوع الموظف
        fcmToken: fcmToken.isNotEmpty ? fcmToken : null,
      ),
    );

    if (!result.success || result.user == null) {
      await _forceLogout();
      return;
    }

    final apiUser = result.user!;

    // ربط ومزامنة إشعارات FCM للموظف
    try {
      await FcmService.instance.init();
      await FcmService.instance.syncCurrentToken(
        userId: apiUser.userid,
        userType: apiUser.type ?? UserType.employeeUser,
      );
    } catch (e) {
      debugPrint("FCM Init note: $e");
    }

    // ربط الـ SignalR
    if (!SignalRService.instance.isConnected) {
      await SignalRService.instance.connect(hubUrl: ApiLink.notificationHub);
    }

    await _checkFacilityCompletion(apiUser);
  }
```

#### ب) دالة `login()`:
```dart
  Future<void> login(LoginRequest request) async {
    emit(AuthLoginLoading());

    // التأكد من جلب التوكن الحقيقي قبل إرسال الطلب
    final fcmToken = await FcmService.instance.getToken(vapidKey: FcmConfig.webVapidKey);
    final String? tokenToSend = fcmToken.isNotEmpty
        ? fcmToken
        : ((request.fcmToken != null && request.fcmToken!.isNotEmpty)
            ? request.fcmToken
            : null);

    final effectiveRequest = LoginRequest(
      user: request.user,
      password: request.password,
      type: UserType.employeeUser, // التأكيد على حساب الموظف
      fcmToken: tokenToSend,
    );

    final result = await loginFunction(
      loginRequest: effectiveRequest,
    );

    if (!result.success || result.user == null) {
      emit(AuthLoginError(result.message));
      return;
    }

    final apiUser = result.user!;

    await AuthLocalStorage.saveUser(apiUser);
    await AuthLocalStorage.savePassword(effectiveRequest.password);

    try {
      await FcmService.instance.init();
      await FcmService.instance.syncCurrentToken(
        userId: apiUser.userid,
        userType: apiUser.type ?? UserType.employeeUser,
      );
    } catch (e) {
      debugPrint("FCM Init note: $e");
    }

    if (!SignalRService.instance.isConnected) {
      await SignalRService.instance.connect(hubUrl: ApiLink.notificationHub);
    }

    emit(AuthLoginSuccess(message: result.message));
    await _checkFacilityCompletion(apiUser);
  }
```

#### ج) دالة `_forceLogout()` و `logout()`:
```dart
  Future<void> _forceLogout() async {
    await AuthLocalStorage.clearUser();
    await AuthLocalStorage.clearPassword();

    try {
      await FcmService.instance.disconnect();
    } catch (_) {}

    await SignalRService.instance.disconnect();
    emit(AuthUnauthenticated());
  }

  Future<void> logout(BuildContext context) async {
    emit(AuthLoading());
    await _forceLogout();
  }
```

---

### 4.3 تحديث واجهة تسجيل الدخول (`login_widget.dart`)
في ملف زر تسجيل الدخول (عادة داخل `features/auth_page/presentation/pages/login_page/...`):
عند الضغط على الزر، قم بجلب التوكن وإرفاقه بالطلب:
```dart
final fcmToken = await FcmService.instance.getToken(vapidKey: FcmConfig.webVapidKey);

context.read<AuthCubit>().login(
  LoginRequest(
    user: emailController.text.trim(),
    password: passwordController.text,
    type: UserType.employeeUser,
    fcmToken: fcmToken.isNotEmpty ? fcmToken : null,
  ),
);
```

---

## 5. المرحلة الرابعة: نظام المحادثات والدعم الفني للموظف

في نظام المزود تم إنشاء هيكل محادثة متجاوب حديث ومريح جداً للمستخدمين (مقسم إلى 3 أجزاء على الشاشات الكبيرة وجزئين على الأجهزة اللوحية وقائمة عادية على الموبايل). لنقم بنقله وتهيئته لنظام الموظف:

### 5.1 نماذج المحادثة (`employee_chat_model.dart`)
أنشئ الملف [lib/features/technical_support/data/model/employee_chat_model.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/features/technical_support/data/model/employee_chat_model.dart):
يشمل كلاسات:
- `GetAllMessagesModel`: يمثل كل محادثة (طرف المحادثة، عدد الرسائل غير المقروءة، آخر رسالة، صورة المستخدم).
- `ChatMessageModel`: يمثل الرسالة المنفردة (النص، المرسل، المستقبل، وقت الإرسال، المرفقات).
- `WorkTeamMemberModel`: يمثل أعضاء المنشأة التابع لها الموظف (المزود الرئيسي، المشرف، الفنيين الزملاء).

*(يمكن نسخ هذا الملف مباشرة من [provider_chat_model.dart](file:///d:/Flutter-Projects/provider_system_sun/lib/features/technical_support/data/model/provider_chat_model.dart) فهو موحد تماماً)*.

---

### 5.2 تحديث ناقل أحداث الشات الفوري (`chat_events.dart`)
عدّل ملف [lib/features/technical_support/data/model/chat_events/chat_events.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/features/technical_support/data/model/chat_events/chat_events.dart):
أضف المتغيرات التي تحدد المحادثة المفتوحة حالياً حتى لا يظهر إشعار منبثق للمستخدم أثناء تواجده داخل المحادثة نفسها:

```dart
class ChatEvents {
  ChatEvents._();

  static final ChatEvents instance = ChatEvents._();

  int? activeChatUserId;
  int? activeChatUserType;

  final StreamController<ReceiveMessageData> _controller =
      StreamController<ReceiveMessageData>.broadcast();

  Stream<ReceiveMessageData> get stream => _controller.stream;

  void add(ReceiveMessageData data) {
    _controller.add(data);
  }

  Future<void> dispose() async {
    activeChatUserId = null;
    activeChatUserType = null;
    await _controller.close();
  }
}
```

---

### 5.3 مستودع محادثات الموظف (`employee_chat_repository.dart`)
أنشئ الملف [lib/features/technical_support/data/datasource/employee_chat_repository.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/features/technical_support/data/datasource/employee_chat_repository.dart):

```dart
import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:emp_system_sun/core/api/dio_function/dio_controller.dart';
import '../model/employee_chat_model.dart';

class EmployeeChatRepository {
  const EmployeeChatRepository();

  Future<List<GetAllMessagesModel>> getAllMessages({
    required int userId,
    required int userType,
  }) async {
    final response = await Network.postDataWithBodyAndParams(
      {},
      {'userId': userId, 'userType': userType},
      ApiLink.getUserChats,
    );
    final responseData = response.data;
    if (responseData == null) return [];

    List rawList = [];
    if (responseData is List) {
      rawList = responseData;
    } else if (responseData is Map && responseData['data'] is List) {
      rawList = responseData['data'];
    }

    return rawList
        .whereType<Map>()
        .map((item) => GetAllMessagesModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<List<WorkTeamMemberModel>> getWorkTeam({
    required int userId,
    required int userType,
  }) async {
    final response = await Network.postDataWithBodyAndParams(
      {},
      {'userId': userId, 'user': userId, 'userType': userType},
      ApiLink.getWorkTeamChat,
    );
    final responseData = response.data;
    if (responseData == null) return [];

    List rawList = [];
    if (responseData is List) {
      rawList = responseData;
    } else if (responseData is Map && responseData['data'] is List) {
      rawList = responseData['data'];
    }

    return rawList
        .whereType<Map>()
        .map((item) => WorkTeamMemberModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<List<ChatMessageModel>> getChatMessages({
    required int fromUserId,
    required int fromUserType,
    required int toUserId,
    required int toUserType,
  }) async {
    final response = await Network.postDataWithBodyAndParams(
      {},
      {
        'fromUserId': fromUserId,
        'fromUserType': fromUserType,
        'toUserId': toUserId,
        'toUserType': toUserType,
      },
      ApiLink.getChatMessages,
    );
    final responseData = response.data;
    if (responseData == null) return [];

    List rawList = [];
    if (responseData is List) {
      rawList = responseData;
    } else if (responseData is Map && responseData['data'] is List) {
      rawList = responseData['data'];
    }

    return rawList
        .whereType<Map>()
        .map((item) => ChatMessageModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }
}
```

---

### 5.4 إدارة حالة المحادثات (`EmployeeChatCubit` & `EmployeeChatState`)
أنشئ المجلد `lib/features/technical_support/presentation/bloc/employee_chat_cubit/`:
1. **`employee_chat_state.dart`**: يحتوي على الـ State المماثل لـ [provider_chat_state.dart](file:///d:/Flutter-Projects/provider_system_sun/lib/features/technical_support/presentation/bloc/provider_chat_cubit/provider_chat_state.dart).
2. **`employee_chat_cubit.dart`**:
   - يرث من `Cubit<EmployeeChatState>`.
   - يقوم بضبط `_cachedUserType = UserType.employeeUser`.
   - يستمع لـ `ChatEvents.instance.stream` ويحدث شاشات المحادثة عند وصول أي رسالة لحظياً.
   - يعزف صوت الإشعار القصير عند وصول رسالة جديدة.
   - يحدث عداد الرسائل غير المقروءة.

---

### 5.5 واجهات المحادثة المتجاوبة (`EmployeeChatPage` & Widgets)
انسخ المجلد المساعد للواجهات [widgets/](file:///d:/Flutter-Projects/provider_system_sun/lib/features/technical_support/presentation/pages/widgets) إلى:
`lib/features/technical_support/presentation/pages/widgets/`
ويشمل:
- `chat_conversations_panel.dart`: لوحة قائمة المحادثات والبحث.
- `chat_thread_panel.dart`: لوحة المحادثة الحالية وصندوق كتابة وإرسال الرسائل.
- `chat_work_team_panel.dart`: لوحة زملاء العمل والمنشأة.
- `chat_bubble.dart`: فقاعات الرسائل والتنسيق الزمني وحالة القراءة.
- `chat_thread_header.dart` و `chat_empty_view.dart`.

وأنشئ الصفحة الرئيسية [lib/features/technical_support/presentation/pages/employee_chat_page.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/features/technical_support/presentation/pages/employee_chat_page.dart):

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/setup_git_it.dart';
import '../../../../core/theming/colors.dart';
import '../bloc/employee_chat_cubit/employee_chat_cubit.dart';
import '../bloc/employee_chat_cubit/employee_chat_state.dart';
import 'widgets/chat_conversations_panel.dart';
import 'widgets/chat_thread_panel.dart';
import 'widgets/chat_work_team_panel.dart';

class EmployeeChatPage extends StatefulWidget {
  const EmployeeChatPage({super.key});

  @override
  State<EmployeeChatPage> createState() => _EmployeeChatPageState();
}

class _EmployeeChatPageState extends State<EmployeeChatPage> {
  @override
  void initState() {
    super.initState();
    final cubit = getIt<EmployeeChatCubit>();
    cubit.clearSelectedChat();
    cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<EmployeeChatCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return const _MobileChatLayout();
            } else if (constraints.maxWidth < 1024) {
              return const _TabletChatLayout();
            } else {
              return const _DesktopChatLayout();
            }
          },
        ),
      ),
    );
  }
}

class _DesktopChatLayout extends StatelessWidget {
  const _DesktopChatLayout();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(width: 340, child: ChatConversationsPanel()),
        Expanded(child: ChatThreadPanel()),
        SizedBox(width: 280, child: ChatWorkTeamPanel()),
      ],
    );
  }
}

class _TabletChatLayout extends StatelessWidget {
  const _TabletChatLayout();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(width: 340, child: ChatConversationsPanel()),
        Expanded(child: ChatThreadPanel()),
      ],
    );
  }
}

class _MobileChatLayout extends StatelessWidget {
  const _MobileChatLayout();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeChatCubit, EmployeeChatState>(
      buildWhen: (prev, curr) => prev.selectedChat != curr.selectedChat,
      builder: (context, state) {
        if (state.selectedChat != null) {
          return const ChatThreadPanel();
        }
        return const ChatConversationsPanel();
      },
    );
  }
}
```

---

### 5.6 حقن الاعتماديات والمسار
1. في [lib/core/setup_git_it.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/core/setup_git_it.dart):
```dart
  getIt.registerLazySingleton<EmployeeChatRepository>(
    () => const EmployeeChatRepository(),
  );
  getIt.registerLazySingleton<EmployeeChatCubit>(
    () => EmployeeChatCubit(chatRepository: getIt<EmployeeChatRepository>()),
  );
```

2. في [lib/core/utilies/map_of_all_app.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/core/utilies/map_of_all_app.dart):
استبدل `TechnicalSupportAdminSun()` بـ `EmployeeChatPage()` تحت الرقم `PagesOfAllApp.technicalSupportPageNumber`:
```dart
    const PageNodeModel(
      name: AppLanguageKeys.technicalSupport,
      image: AppImageKeys.users,
      number: PagesOfAllApp.technicalSupportPageNumber,
      page: EmployeeChatPage(),
    ),
```

---

## 6. المرحلة الخامسة: جرس الإشعارات وصفحة الإشعارات الشاملة

### 6.1 ويدجت جرس الإشعارات (`NotificationBell`)
أنشئ المجلد والملف:
[lib/features/notifications/presentation/pages/notification_bell/notification_bell.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/features/notifications/presentation/pages/notification_bell/notification_bell.dart)
*(يمكن الاعتماد على الكود المميز لـ [notification_bell.dart في المزود](file:///d:/Flutter-Projects/provider_system_sun/lib/features/notifications/presentation/pages/notification_bell/notification_bell.dart))*:

**أبرز مزايا الويدجت:**
1. **أيقونة الجرس مع الـ Badge**: حساب عدد الإشعارات غير المقروءة تلقائياً عبر `NotificationCubit.unreadCount`.
2. **قائمة Overlay منبثقة تفاعلية**: تفتح بسلاسة تحت الأيقونة بحجم مناسب للشاشات المختلفة مع مراعاة اتجاه اللغة (RTL/LTR).
3. **عرض ملخص آخر الإشعارات**: مع الوقت، والعنوان، والتفاصيل، ونقطة ملونة تدل على حالة القراءة.
4. **تحديد كمقروء تلقائياً**: استدعاء `cubit.makeNotificationViewed()` عند إغلاق القائمة لتصفير العداد.
5. **زر "عرض الكل / Display All"**: يفتح صفحة الإشعارات الكاملة.

---

### 6.2 صفحة الإشعارات الكاملة (`NotificationsPage`)
أنشئ الملف:
[lib/features/notifications/presentation/pages/notifications_page/notifications_page.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/features/notifications/presentation/pages/notifications_page/notifications_page.dart)
*(يمكن استخدام كود [notifications_page.dart في المزود](file:///d:/Flutter-Projects/provider_system_sun/lib/features/notifications/presentation/pages/notifications_page/notifications_page.dart))*:

**مزايا الصفحة:**
- دعم الـ Infinite Scrolling والتحميل التدريجي عند الوصول لنهاية القائمة (`cubit.loadMore()`).
- واجهة Shimmer Skeleton أثناء التحميل.
- دعم السحب للتحديث (Pull-to-refresh).
- التنسيق الأنيق للتاريخ والوقت مع دعم اللغتين العربية والإنجليزية.

---

### 6.3 تحديث AppBar في المتجر / لوحة التحكم (`app_bar_for_page.dart`)
عدّل ملف [lib/features/store_page/presentation/pages/store_widgets/app_bar_for_page.dart](file:///d:/Flutter-Projects/emp_system_sun/lib/features/store_page/presentation/pages/store_widgets/app_bar_for_page.dart):
استبدل الويدجت القديم `NotificationPopup()` بالويدجت العصري `NotificationBell()`:

```dart
// في السطر 148:
// استبدل:
// const NotificationPopup(),

// بـ:
const NotificationBell(),
```

تأكد من عمل استيراد للويدجت:
```dart
import '../../../../notifications/presentation/pages/notification_bell/notification_bell.dart';
```

---

## 7. قائمة الفحص والاختبار (Verification & Testing Checklist)

للتأكد من نجاح كافة العمليات وتكاملها كالمزود:

1. **فحص الـ Build**:
   ```bash
   flutter pub get
   flutter analyze
   ```
2. **اختبار الإشعارات على الويب (Web Chrome)**:
   - قم بتشغيل التطبيق: `flutter run -d chrome`.
   - افتح نافذة التطبيق واقبل إذن الإشعارات (Allow Notifications).
   - تحقق من الـ Console وتأكد من طباعة: `FCM: Successfully obtained new token: ...`.
3. **اختبار تسجيل الدخول**:
   - أدخل بيانات اعتماد حساب الموظف.
   - تأكد في الـ Network Tab أو Logs من إرسال `fcmToken` داخل الـ Payload مع `type: 5`.
   - تأكد من نجاح طلب `UpdateFcmToken` والاشتراك في الـ Topic `employee`.
4. **اختبار جرس الإشعارات**:
   - إرسال إشعار تجريبي عبر Firebase Console أو السيرفر.
   - التحقق من صدور الصوت وتحديث عداد الجرس الأحمر مباشرة.
   - الضغط على الجرس وفتح القائمة المنسدلة والتأكد من فتح صفحة "عرض الكل".
5. **اختبار صفحة المحادثة**:
   - التوجه إلى "الدعم الفني / Technical Support" من القائمة الجانبية.
   - التأكد من فتح الواجهة الثلاثية المتجاوبة الجديدة وسرد جهات الاتصال وفريق العمل.
   - إرسال واستقبال رسالة نصية والتأكد من وصولها وتحديث المحادثة لحظياً بدون إعادة تحميل الصفحة.
