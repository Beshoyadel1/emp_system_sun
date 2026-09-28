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

      // Request permissions
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

      // Fetch Token
      _fcmToken = await getToken(vapidKey: FcmConfig.webVapidKey);
      if (_fcmToken != null && _fcmToken!.isNotEmpty) {
        await _syncTokenIfUserAvailable(_fcmToken!);
      }

      // Listen for token refresh
      messaging.onTokenRefresh.listen((newToken) {
        _fcmToken = newToken;
        _syncTokenIfUserAvailable(newToken);
      });

      // Foreground message listener
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _handleRemoteMessage(message);
      });

      // Opened from notification listener
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

        if (kIsWeb) {
          try {
            final settings =
                await FirebaseMessaging.instance.getNotificationSettings();
            if (settings.authorizationStatus ==
                AuthorizationStatus.notDetermined) {
              final newSettings =
                  await FirebaseMessaging.instance.requestPermission();
              if (kDebugMode) {
                print(
                    'FCM Web: Requested notification permission => ${newSettings.authorizationStatus}');
              }
            } else if (settings.authorizationStatus ==
                AuthorizationStatus.denied) {
              if (kDebugMode) {
                print(
                    'FCM Web: Notification permission is DENIED by the user/browser.');
              }
            }
          } catch (e) {
            if (kDebugMode) {
              print('FCM Web: Permission check note: $e');
            }
          }
        }

        final token = await FirebaseMessaging.instance
            .getToken(
          vapidKey:
              (kIsWeb && effectiveVapidKey.isNotEmpty) ? effectiveVapidKey : null,
        )
            .timeout(
          const Duration(seconds: 10),
          onTimeout: () => null,
        );

        if (token != null && token.trim().isNotEmpty) {
          _fcmToken = token.trim();
          await AuthLocalStorage.saveFcmToken(_fcmToken!);
          if (kDebugMode) {
            print('FCM: Successfully obtained new token: $_fcmToken');
          }
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

    final user = await AuthLocalStorage.getUser();
    if (user != null &&
        user.fcmToken != null &&
        user.fcmToken!.trim().isNotEmpty) {
      _fcmToken = user.fcmToken!.trim();
      await AuthLocalStorage.saveFcmToken(_fcmToken!);
      return _fcmToken!;
    }

    // Fallback persistent token for desktop / testing
    final fallbackToken = await _getOrCreateFallbackToken();
    _fcmToken = fallbackToken;
    return fallbackToken;
  }

  Future<String> _getOrCreateFallbackToken() async {
    try {
      final saved = await AuthLocalStorage.getFcmToken();
      if (saved != null && saved.trim().isNotEmpty) {
        return saved.trim();
      }
    } catch (_) {}

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomSuffix = (Random().nextInt(900000) + 100000).toString();
    final platformTag =
        kIsWeb ? 'web' : defaultTargetPlatform.name.toLowerCase();
    final generated = 'fcm_${platformTag}_${timestamp}_$randomSuffix';
    await AuthLocalStorage.saveFcmToken(generated);
    return generated;
  }

  Future<void> syncCurrentToken({int? userId, int? userType}) async {
    final user = await AuthLocalStorage.getUser();
    final effectiveUserId = userId ?? user?.userid;
    // Employee UserType: 5
    final effectiveUserType = userType ?? user?.type ?? UserType.employeeUser;

    if (effectiveUserId != null && effectiveUserId > 0) {
      final token = await getToken(vapidKey: FcmConfig.webVapidKey);
      if (token.isNotEmpty) {
        await _syncTokenWithBackend(
          userId: effectiveUserId,
          userType: effectiveUserType,
          token: token,
        );

        final ctx = navigatorKey.currentContext;
        if (ctx != null) {
          try {
            BlocProvider.of<NotificationCubit>(ctx, listen: false).getUserNotification();
          } catch (_) {}
        }
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

      final ctx = navigatorKey.currentContext;
      if (ctx != null) {
        try {
          BlocProvider.of<NotificationCubit>(ctx, listen: false).getUserNotification();
        } catch (_) {}
      }
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
        print(
            'FCM: Successfully synced token with backend for Employee $userId (type $userType)');
      }

      // Automatically subscribe to employee topics if real FCM token
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

      try {
        showBrowserNotification(title.toString(), body.toString());
      } catch (_) {}

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

      // Refresh global NotificationCubit if mounted
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
