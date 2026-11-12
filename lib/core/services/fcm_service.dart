import 'dart:async';
import 'auth_session.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:emp_system_sun/core/api/dio_function/dio_controller.dart';
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
  if (kDebugMode) {
    debugPrint('FCM background: ${message.toMap()}', wrapWidth: 120);
  }
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
}

class FcmService {
  FcmService._();
  static final FcmService instance = FcmService._();
  ({int version, String value})? _deviceToken;
  String? get fcmToken => _deviceToken?.value;
  String _submittedToken = '';
  Future<void> _tokenUpdates = Future.value();
  bool _isInitialized = false, _uiReady = false;
  bool get isInitialized => _isInitialized;
  int _userId = 0, _userType = 0, _session = 0;
  int _authVersion = 0;
  StreamSubscription<String>? _tokenSubscription;
  StreamSubscription<RemoteMessage>? _messageSubscription, _openSubscription;
  void Function()? _stopWebClicks;
  final Set<String> _opened = {};
  final List<({NotificationPayload payload, bool opened})> _pendingDisplay = [];

  static bool get isSupported =>
      kIsWeb ||
      const {
        TargetPlatform.android,
        TargetPlatform.iOS,
        TargetPlatform.macOS,
      }.contains(defaultTargetPlatform);

  Future<void> init({
    required int userId,
    required int userType,
    String loginToken = '',
  }) async {
    final version = AuthSession.version;
    if (_userId != userId || _userType != userType || _authVersion != version) {
      final deviceToken = _deviceToken;
      await disconnect();
      if (!AuthSession.isCurrent(version)) return;
      if (deviceToken?.version == version) _deviceToken ??= deviceToken;
      _userId = userId;
      _userType = userType;
      _submittedToken = loginToken.trim();
    }
    _authVersion = version;
    getIt<EmployeeChatCubit>().configureUser(userId, userType);
    if (!isSupported || _isInitialized) return;
    _syncDeviceToken(version);
    _isInitialized = true;
    final session = _session;
    try {
      final messaging = FirebaseMessaging.instance;
      _stopWebClicks = listenForNotificationClicks((raw) {
        if (session != _session) return;
        if (kDebugMode) {
          final source = raw['sunOpened'] == false ? 'background' : 'opened';
          debugPrint('FCM web $source: $raw', wrapWidth: 120);
        }
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
            opened: raw['sunOpened'] != false);
      });
      _tokenSubscription = messaging.onTokenRefresh.listen((token) {
        if (session == _session) _recordDeviceToken(token, version);
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

  ({int version, Future<String> token})? _pendingGetToken;
  Future<String> getToken({String? vapidKey}) async {
    if (!isSupported) {
      _traceToken('unsupported-platform: ${defaultTargetPlatform.name}');
      return '';
    }
    final version = AuthSession.version;
    final current = _pendingGetToken;
    if (current != null && current.version == version) return current.token;
    final pending = _getDeviceToken(version, vapidKey: vapidKey);
    _pendingGetToken = (version: version, token: pending);
    try {
      return await pending;
    } finally {
      if (identical(_pendingGetToken?.token, pending)) _pendingGetToken = null;
    }
  }

  Future<String> _getDeviceToken(int version, {String? vapidKey}) async {
    var stage = 'permission';
    try {
      final messaging = FirebaseMessaging.instance;
      final settings = await messaging.requestPermission(
          alert: true, badge: true, sound: true);
      if (!AuthSession.isCurrent(version)) return '';
      final status = settings.authorizationStatus;
      _traceToken('permission: ${status.name}');
      if (status != AuthorizationStatus.authorized &&
          status != AuthorizationStatus.provisional) {
        return '';
      }

      if (kIsWeb) {
        stage = 'worker-activation';
        await prepareFcmWorker().timeout(const Duration(seconds: 15));
        if (!AuthSession.isCurrent(version)) return '';
        _traceToken('worker-ready');
      }

      stage = 'get-token';
      final key = (vapidKey ?? FcmConfig.webVapidKey).trim();
      return await messaging
          .getToken(vapidKey: kIsWeb && key.isNotEmpty ? key : null)
          .then((token) {
        if (!AuthSession.isCurrent(version)) return '';
        final current = _deviceToken;
        if (current != null && current.version == version) return current.value;
        // This still runs if the login deadline has already expired.
        final value = _recordDeviceToken(token, version);
        _traceToken(value.isEmpty ? 'get-token-empty' : 'get-token-ready');
        return value;
      }).timeout(const Duration(seconds: 40));
    } on TimeoutException {
      _traceToken('$stage-timeout');
    } on FirebaseException catch (e) {
      _traceToken('$stage-failed: ${e.code}');
    } catch (e) {
      _traceToken('$stage-failed: ${e.runtimeType}');
    }
    return '';
  }

  String _recordDeviceToken(String? token, int version) {
    final value = token?.trim() ?? '';
    if (value.isEmpty || !AuthSession.isCurrent(version)) return '';
    final deviceToken = (version: version, value: value);
    if (_deviceToken != deviceToken) {
      _deviceToken = deviceToken;
      unawaited(_saveDeviceToken(value, version));
    }
    _syncDeviceToken(version);
    return value;
  }

  void _syncDeviceToken(int version) {
    final deviceToken = _deviceToken;
    if (_authVersion != version ||
        _userId <= 0 ||
        _userType <= 0 ||
        deviceToken == null ||
        deviceToken.version != version) {
      return;
    }
    final session = _session;
    final userId = _userId;
    final userType = _userType;
    final value = deviceToken.value;
    _tokenUpdates = _tokenUpdates.then((_) async {
      if (!AuthSession.isCurrent(version) ||
          session != _session ||
          _deviceToken != deviceToken ||
          _submittedToken == value) {
        return;
      }
      try {
        final response = await Network.postDataWithBodyAndParams(
          null,
          {'userId': userId, 'userType': userType, 'fcmToken': value},
          ApiLink.updateFcmToken,
        );
        final body = response.data;
        if (body is Map && (body['success'] ?? body['status']) == false) {
          _traceToken('token-update-rejected');
          return;
        }
        if (AuthSession.isCurrent(version) && session == _session) {
          _submittedToken = value;
          _traceToken('token-update-sent');
        }
      } catch (e) {
        _traceToken('token-update-failed: ${e.runtimeType}');
      }
    });
  }

  Future<void> _saveDeviceToken(String token, int version) async {
    try {
      await AuthLocalStorage.saveFcmToken(token, version: version);
    } catch (e) {
      _traceToken('token-storage-failed: ${e.runtimeType}');
    }
  }

  void _traceToken(String message) {
    if (kDebugMode) debugPrint('[FCM] $message');
  }

  void handleRemoteMessage(RemoteMessage message, {bool opened = false}) {
    if (kDebugMode) {
      final source = opened ? 'opened' : 'foreground';
      debugPrint('FCM $source: ${message.toMap()}', wrapWidth: 120);
    }
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
    if (alert == NotificationAlert.chat ||
        alert == NotificationAlert.soundOnly) {
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
    _deviceToken = null;
    _submittedToken = '';
    _pendingGetToken = null;
    _opened.clear();
    _pendingDisplay.clear();
    NotificationUpdates.instance.reset();
    if (getIt.isRegistered<EmployeeChatCubit>()) {
      getIt<EmployeeChatCubit>().reset();
    }
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
