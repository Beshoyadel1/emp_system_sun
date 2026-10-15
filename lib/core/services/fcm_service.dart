import 'dart:async';
import 'auth_session.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:emp_system_sun/core/services/browser_notification.dart';
import 'package:emp_system_sun/core/setup_git_it.dart';
import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:emp_system_sun/firebase_options.dart';
import 'package:emp_system_sun/features/notifications/data/model/notification_payload.dart';
import 'package:emp_system_sun/features/notifications/data/model/receive_message_notification_model/receive_message_notification_model.dart';
import 'package:emp_system_sun/features/notifications/data/notification_updates.dart';
import 'package:emp_system_sun/features/notifications/presentation/module/notification_module/notification_module.dart';
import 'package:emp_system_sun/features/technical_support/data/model/chat_events/chat_events.dart';
import 'package:emp_system_sun/features/technical_support/presentation/bloc/employee_chat_cubit/employee_chat_cubit.dart';
import 'notification_clicks.dart';
import 'package:emp_system_sun/features/notifications/presentation/services/notification_alert_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
  debugPrint('FCM background: ${message.messageId}');
}

class FcmService {
  FcmService._();
  static final FcmService instance = FcmService._();
  String? _fcmToken;
  String? get fcmToken => _fcmToken;
  bool _isInitialized = false, _uiReady = false;
  bool get isInitialized => _isInitialized;
  int _userId = 0, _userType = 0, _session = 0;
  int _authVersion = 0;
  StreamSubscription<String>? _tokenSubscription;
  StreamSubscription<RemoteMessage>? _messageSubscription, _openSubscription;
  void Function()? _stopWebClicks;
  AppLifecycleListener? _lifecycleListener;
  bool _wasInBackground = false;
  final Set<String> _opened = {};
  final List<({NotificationPayload payload, bool opened})> _pendingDisplay = [];

  static bool get isSupported =>
      kIsWeb ||
      const {
        TargetPlatform.android,
        TargetPlatform.iOS,
        TargetPlatform.macOS,
      }.contains(defaultTargetPlatform);

  /// Login registers the current token and topics on the backend.
  Future<void> init({required int userId, required int userType}) async {
    final version = AuthSession.version;
    if (_userId != userId || _userType != userType || _authVersion != version) {
      final deviceToken = _fcmToken;
      await disconnect();
      if (!AuthSession.isCurrent(version)) return;
      _fcmToken = deviceToken;
      _userId = userId;
      _userType = userType;
    }
    _authVersion = version;
    getIt<EmployeeChatCubit>().configureUser(userId, userType);
    _lifecycleListener ??= AppLifecycleListener(onStateChange: (state) {
      if (state == AppLifecycleState.paused ||
          state == AppLifecycleState.hidden) {
        _wasInBackground = true;
      } else if (state == AppLifecycleState.resumed && _wasInBackground) {
        _wasInBackground = false;
        if (_userId > 0) ChatEvents.instance.requestSync();
      }
    });
    if (!isSupported || _isInitialized) return;
    _isInitialized = true;
    final session = _session;
    try {
      final messaging = FirebaseMessaging.instance;
      _stopWebClicks = listenForNotificationClicks((raw) {
        if (session != _session) return;
        final notification = NotificationPayload.object(raw['notification']);
        _handlePayload(
            NotificationPayload(
              NotificationPayload.object(raw['data']),
              title: notification['title']?.toString(),
              body: notification['body']?.toString(),
              messageId: (raw['messageId'] ?? raw['fcmMessageId'])?.toString(),
              sentAt: raw['sentTime'] is num
                  ? DateTime.fromMillisecondsSinceEpoch(
                      (raw['sentTime'] as num).toInt())
                  : DateTime.tryParse('${raw['sentAt'] ?? ''}'),
            ),
            opened: true);
      });
      _tokenSubscription = messaging.onTokenRefresh.listen((token) {
        if (session != _session || !AuthSession.isCurrent(version)) return;
        _fcmToken = token;
        // Submit the latest device token at the next login.
        unawaited(AuthLocalStorage.saveFcmToken(token, version: version));
      });
      _messageSubscription = FirebaseMessaging.onMessage.listen((message) {
        if (session == _session) handleRemoteMessage(message, opened: false);
      });
      _openSubscription =
          FirebaseMessaging.onMessageOpenedApp.listen((message) {
        if (session == _session) handleRemoteMessage(message, opened: true);
      });
      final initial = await messaging.getInitialMessage();
      if (session == _session && initial != null) {
        handleRemoteMessage(initial, opened: true);
      }
    } catch (e) {
      debugPrint('FCM init: $e');
      if (session == _session) await _cancelListeners();
    }
  }

  Future<String>? _pendingGetToken;
  Future<String> getToken({String? vapidKey}) async {
    if (!isSupported) return '';
    if (_pendingGetToken != null) return _pendingGetToken!;
    final pending = _getDeviceToken(vapidKey: vapidKey);
    _pendingGetToken = pending;
    try {
      return await pending;
    } finally {
      if (identical(_pendingGetToken, pending)) _pendingGetToken = null;
    }
  }

  Future<String> _getDeviceToken({String? vapidKey}) async {
    final version = AuthSession.version;
    try {
      final messaging = FirebaseMessaging.instance;
      final settings = await messaging.requestPermission(
          alert: true, badge: true, sound: true);
      if (settings.authorizationStatus == AuthorizationStatus.denied) return '';
      final key = vapidKey?.trim() ?? FcmConfig.webVapidKey;
      final token = await messaging
          .getToken(
            vapidKey: kIsWeb && key.isNotEmpty ? key : null,
          )
          .timeout(const Duration(seconds: 10), onTimeout: () => null);
      if (token?.trim().isNotEmpty == true) {
        if (!AuthSession.isCurrent(version)) return '';
        _fcmToken = token!.trim();
        await AuthLocalStorage.saveFcmToken(_fcmToken!, version: version);
        return AuthSession.isCurrent(version) ? token.trim() : '';
      }
    } catch (e) {
      debugPrint('FCM token unavailable: $e');
    }
    // Never submit a fabricated token or one belonging to a different device.
    return '';
  }

  void handleRemoteMessage(RemoteMessage message, {bool opened = false}) {
    _handlePayload(
        NotificationPayload(
          message.data,
          title: message.notification?.title,
          body: message.notification?.body,
          messageId: message.messageId,
          sentAt: message.sentTime,
        ),
        opened: opened);
  }

  void _handlePayload(NotificationPayload payload, {required bool opened}) {
    if (!AuthSession.isCurrent(_authVersion) ||
        _userId <= 0 ||
        !payload.isFor(_userId, _userType)) {
      return;
    }
    try {
      final fresh = NotificationUpdates.instance.add(payload);
      if (fresh && payload.kind == NotificationKind.chat) {
        final data = Map<String, dynamic>.from(payload.data);
        data['message'] ??= payload.body;
        if (NotificationPayload.value(data, 'date') == null) {
          data['date'] = payload.sentAt.toIso8601String();
        }
        ChatEvents.instance.add(ReceiveMessageData.fromJson(data));
      } else if (fresh && payload.kind == NotificationKind.chatStatus) {
        getIt<EmployeeChatCubit>().updateChatStatus(payload);
      }
      if (opened) {
        if (!_opened.add(payload.key)) return;
        if (_opened.length > 500) _opened.remove(_opened.first);
      } else if (!fresh) {
        return;
      }
      if (!_uiReady) {
        _pendingDisplay.add((payload: payload, opened: opened));
        if (_pendingDisplay.length > 20) _pendingDisplay.removeAt(0);
        return;
      }
      _display(payload, opened: opened);
    } catch (e, stack) {
      debugPrint('FCM processing: $e\n$stack');
    }
  }

  void markUiReady() {
    if (_userId <= 0 || !AuthSession.isCurrent(_authVersion)) return;
    _uiReady = true;
    final pending = List.of(_pendingDisplay);
    _pendingDisplay.clear();
    final taps = pending.where((item) => item.opened);
    if (taps.isNotEmpty) {
      _display(taps.last.payload, opened: true);
    } else if (pending.isNotEmpty) {
      for (final item in pending) {
        _display(item.payload, opened: false);
      }
    }
  }

  void _display(NotificationPayload payload, {required bool opened}) {
    final module = NotificationModule.instance;
    final session = _session;
    if (opened) {
      unawaited(() async {
        await module.dialogService.dismiss();
        await module.alertService.stopChat().catchError((Object error) {
          debugPrint('Chat sound: $error');
        });
        if (session != _session || !_uiReady) return;
        module.navigationService.openPayload(payload);
      }()
          .catchError((Object error) {
        debugPrint('Notification click: $error');
      }));
      return;
    }
    final alert = module.alertService
        .alertFor(payload, userId: _userId, userType: _userType);
    if (alert == NotificationAlert.silent) return;
    if (alert == NotificationAlert.chat) {
      unawaited(module.alertService.playChat().catchError((Object error) {
        debugPrint('Chat sound: $error');
      }));
      return;
    }
    final title = payload.title.isEmpty ? 'إشعار جديد' : payload.title;
    showBrowserNotification(title, payload.body, onClick: () {
      if (session == _session) _handlePayload(payload, opened: true);
    });
    unawaited(module.dialogService
        .show(
      title: title,
      subtitle: payload.body,
      onView: () async {
        if (session == _session && _uiReady) {
          module.navigationService.openPayload(payload);
        }
      },
    )
        .catchError((Object error) {
      debugPrint('Notification display: $error');
    }));
  }

  Future<void> _cancelListeners() async {
    _stopWebClicks?.call();
    _stopWebClicks = null;
    await _tokenSubscription?.cancel();
    await _messageSubscription?.cancel();
    await _openSubscription?.cancel();
    _tokenSubscription = null;
    _messageSubscription = null;
    _openSubscription = null;
    _isInitialized = false;
  }

  Future<void> disconnect() async {
    _session++;
    _userId = 0;
    _userType = 0;
    _uiReady = false;
    _fcmToken = null;
    _pendingGetToken = null;
    _opened.clear();
    _pendingDisplay.clear();
    NotificationUpdates.instance.reset();
    if (getIt.isRegistered<EmployeeChatCubit>()) {
      getIt<EmployeeChatCubit>().reset();
    }
    _lifecycleListener?.dispose();
    _lifecycleListener = null;
    _wasInBackground = false;
    ChatEvents.instance.clearActiveHarages();
    await NotificationModule.instance.dialogService.dismiss();
    await NotificationModule.instance.alertService
        .stopChat()
        .catchError((Object error) {
      debugPrint('Chat sound: $error');
    });
    await _cancelListeners();
    // Keep the device registration; login binds it to the next account.
  }
}
