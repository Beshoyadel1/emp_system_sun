import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:emp_system_sun/features/notifications/data/model/notification_payload.dart';
import 'package:emp_system_sun/features/notifications/data/notification_updates.dart';
import '../../../../../../core/theming/auth_local_storage.dart';
import '../../../../../../features/notifications/data/datasource/get_user_new_notification_datasource/get_user_new_notification_datasource.dart';
import '../../../../../../features/notifications/data/datasource/get_user_notification_datasource/get_user_notification_datasource.dart';
import '../../../../../../features/notifications/data/datasource/make_notification_viewed_datasource/make_notification_viewed_datasource.dart';
import '../../../../../../features/notifications/data/model/get_user_new_notification_model/get_user_new_notification_model.dart';
import '../../../../../../features/notifications/data/request/get_user_new_notification_request/get_user_new_notification_request.dart';
import '../../../../../../features/notifications/presentation/bloc/notification_cubit/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({NotificationUpdates? updates})
      : _updates = updates ?? NotificationUpdates.instance,
        super(NotificationInitial()) {
    _subscription = _updates.stream.listen(receiveNotification);
  }

  final NotificationUpdates _updates;
  late final StreamSubscription<NotificationPayload> _subscription;
  final Set<String> _seen = {};
  final Map<int, int> _localVersions = {};
  int _localId = 0, _revision = 0, _request = 0, _session = 0;
  final Map<int, NotificationModel> _unread = {};
  final Map<int, int> _readVersions = {};
  bool _historyLoaded = false, _unreadLoaded = false;
  Future<void>? _historyRequest, _unreadRequest, _readRequest;

  Future<void> ensureLoaded() async {
    if (isClosed) return;
    await Future.wait([
      if (!_historyLoaded) getUserNotification(),
      if (!_unreadLoaded) getUserNewNotification(),
    ]);
  }

  void receiveNotification(NotificationPayload payload) {
    if (isClosed ||
        payload.kind == NotificationKind.chatStatus ||
        payload.kind == NotificationKind.chat ||
        !_seen.add(payload.key)) {
      return;
    }
    if (_seen.length > 500) _seen.remove(_seen.first);
    final stored = payload.notification;
    final id = payload.notificationId ?? --_localId;
    final index = notifications.indexWhere((n) => n.id == id);
    final previous = index < 0 ? null : notifications[index];
    final notification = NotificationModel(
      id: id,
      title: payload.title,
      latinTitle: NotificationPayload.value(stored, 'latintitle')?.toString(),
      description: payload.body,
      latinDesc: NotificationPayload.value(stored, 'latindesc')?.toString(),
      fromUserId: payload.integer('fromuser'),
      fromUserType: payload.integer('fromusertype'),
      toUserId: payload.integer('touser'),
      toUserType: payload.integer('tousertype'),
      date: payload.sentAt,
      isViewed: previous?.isViewed ?? false,
      payload: payload,
    );
    notifications = [notification, ...notifications.where((n) => n.id != id)];
    _localVersions[id] = ++_revision;
    if (notification.isViewed != true) _unread[id] = notification;
    newNotification = notification;
    if (index < 0) totalCount++;
    safeEmit(NotificationSuccess(List.of(notifications)));
  }

  void reset() {
    _request++;
    _session++;
    _unread.clear();
    _readVersions.clear();
    _historyLoaded = _unreadLoaded = false;
    _historyRequest = _unreadRequest = _readRequest = null;
    _seen.clear();
    _localVersions.clear();
    _localId = 0;
    _revision = 0;
    newNotification = null;
    notifications = [];
    totalCount = 0;
    pageCount = 0;
    _pageNumber = 1;
    hasMore = true;
    isLoadingMore = false;
    safeEmit(NotificationSuccess(const []));
  }

  NotificationModel? newNotification;

  List<NotificationModel> notifications = [];

  int get unreadCount => _unread.length;

  int _pageNumber = 1;
  final int _pageSize = 10;

  bool hasMore = true;
  bool isLoadingMore = false;

  int totalCount = 0;
  int pageCount = 0;

  void safeEmit(NotificationState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  Future<void> getUserNotification() async {
    if (_historyRequest != null) return _historyRequest!;
    final session = _session;
    final pending = _loadHistory();
    _historyRequest = pending;
    try {
      await pending;
    } finally {
      if (session == _session) _historyRequest = null;
    }
  }

  Future<void> _loadHistory() async {
    if (isClosed) return;
    final request = ++_request;
    final revision = _revision;

    safeEmit(NotificationLoading());

    try {
      final user = await AuthLocalStorage.getUser();
      if (isClosed || request != _request) return;

      if (user == null || user.userid == null || user.userid == 0) {
        notifications = [];
        safeEmit(NotificationSuccess(notifications));
        return;
      }

      _pageNumber = 1;

      final userResponse = await getUserNotificationFunction(
        request: GetUserNewNotificationRequest(
          userId: user.userid!,
          userType: user.type ?? 5,
          pageNumber: _pageNumber,
          pageSize: _pageSize,
        ),
      );
      if (isClosed || request != _request) return;
      final pending = notifications
          .where((n) => (_localVersions[n.id] ?? 0) > revision)
          .toList();
      final cached = {for (final n in notifications) n.id: n.payload};
      notifications = [
        ...userResponse.data.map((n) => n.copyWith(
            payload: cached[n.id],
            isViewed:
                (_readVersions[n.id] ?? 0) > revision ? true : n.isViewed)),
        ...pending,
      ];

      notifications = {
        for (final item in notifications)
          if (item.id != null) item.id!: item,
      }.values.toList();

      notifications.removeWhere((n) => n.isChatRelated);
      _historyLoaded = true;
      if (!_unreadLoaded) {
        for (final n in notifications) {
          if (n.id != null && n.isViewed == false) _unread[n.id!] = n;
        }
      }
      notifications.sort(
        (a, b) =>
            (b.date ?? DateTime.now()).compareTo(a.date ?? DateTime.now()),
      );

      totalCount = userResponse.totalCount +
          pending
              .where((n) => !userResponse.data.any((s) => s.id == n.id))
              .length;
      pageCount = userResponse.pageCount;
      hasMore = _pageNumber < pageCount;

      safeEmit(NotificationSuccess(notifications));
    } catch (e) {
      if (isClosed || request != _request) return;
      safeEmit(NotificationError(e.toString()));
    }
  }

  Future<void> getUserNewNotification() async {
    if (isClosed) return;
    if (_unreadRequest != null) return _unreadRequest!;
    final session = _session, revision = _revision;
    final pending = () async {
      try {
        final user = await AuthLocalStorage.getUser();
        if (isClosed || session != _session || (user?.userid ?? 0) <= 0) return;
        final unread = await getUserNewNotificationFunction(
            request: GetUserNewNotificationRequest(
          userId: user!.userid!,
          userType: user.type ?? 5,
        ));
        if (isClosed || session != _session) return;
        final arrived = Map<int, NotificationModel>.fromEntries(_unread.entries
            .where((e) => (_localVersions[e.key] ?? 0) > revision));
        _unread.clear();
        for (final n in unread) {
          if (n.id != null &&
              !n.isChatRelated &&
              n.isViewed != true &&
              (_readVersions[n.id] ?? 0) <= revision) {
            _unread[n.id!] = n;
          }
        }
        _unread.addAll(arrived);
        _unreadLoaded = true;
        newNotification = _unread.isEmpty ? null : _unread.values.first;
        safeEmit(NotificationSuccess(List.of(notifications)));
      } catch (e) {
        if (!isClosed && session == _session) {
          safeEmit(NotificationError(e.toString()));
        }
      }
    }();
    _unreadRequest = pending;
    try {
      await pending;
    } finally {
      if (session == _session) _unreadRequest = null;
    }
  }

  Future<void> makeNotificationViewed() async {
    if (isClosed) return;
    if (_readRequest != null) return _readRequest!;
    final session = _session;
    final previous = Map<int, NotificationModel>.of(_unread);
    if (previous.isEmpty) return;
    final ids = previous.keys.toSet();
    final revision = ++_revision;
    for (final id in ids) {
      _readVersions[id] = revision;
    }
    _unread.removeWhere((id, _) => ids.contains(id));
    notifications = notifications
        .map((n) => ids.contains(n.id) ? n.copyWith(isViewed: true) : n)
        .toList();
    safeEmit(NotificationSuccess(List.of(notifications)));
    final pending = () async {
      try {
        final user = await AuthLocalStorage.getUser();
        if (isClosed || session != _session) return;
        if ((user?.userid ?? 0) <= 0) throw Exception('User not found');
        await makeNotificationViewedFunction(
            request: GetUserNewNotificationRequest(
                userId: user!.userid!, userType: user.type ?? 5));
      } catch (e) {
        if (isClosed || session != _session) return;
        for (final n in previous.entries) {
          if (_readVersions[n.key] != revision) continue;
          _readVersions.remove(n.key);
          _unread.putIfAbsent(n.key, () => n.value);
        }
        notifications = notifications
            .map((n) => previous.containsKey(n.id)
                ? n.copyWith(isViewed: previous[n.id]!.isViewed)
                : n)
            .toList();
        safeEmit(NotificationError(e.toString()));
      }
    }();
    _readRequest = pending;
    try {
      await pending;
    } finally {
      if (session == _session) _readRequest = null;
    }
  }

  Future<void> loadMore() async {
    if (!hasMore || isLoadingMore) return;

    isLoadingMore = true;
    final request = _request;
    final nextPage = _pageNumber + 1;

    try {
      final user = await AuthLocalStorage.getUser();

      if (user == null || user.userid == null || user.userid == 0) return;

      final userResponse = await getUserNotificationFunction(
        request: GetUserNewNotificationRequest(
          userId: user.userid!,
          userType: user.type ?? 5,
          pageNumber: nextPage,
          pageSize: _pageSize,
        ),
      );
      if (isClosed || request != _request) return;
      _pageNumber = nextPage;
      notifications = [
        ...userResponse.data.where((n) => !n.isChatRelated).map((n) =>
            _readVersions.containsKey(n.id) ? n.copyWith(isViewed: true) : n),
        ...notifications
      ];

      notifications = {
        for (final item in notifications)
          if (item.id != null) item.id!: item,
      }.values.toList();

      notifications.sort(
        (a, b) =>
            (b.date ?? DateTime.now()).compareTo(a.date ?? DateTime.now()),
      );

      pageCount = userResponse.pageCount;
      hasMore = _pageNumber < pageCount;

      safeEmit(NotificationSuccess(notifications));
    } catch (_) {
    } finally {
      if (request == _request) isLoadingMore = false;
    }
  }

  @override
  Future<void> close() async {
    _request++;
    await _subscription.cancel();
    return super.close();
  }
}
