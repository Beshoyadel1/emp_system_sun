import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theming/auth_local_storage.dart';
import '../../../../../../features/notifications/data/datasource/get_user_new_notification_datasource/get_user_new_notification_datasource.dart';
import '../../../../../../features/notifications/data/datasource/get_user_notification_datasource/get_user_notification_datasource.dart';
import '../../../../../../features/notifications/data/datasource/make_notification_viewed_datasource/make_notification_viewed_datasource.dart';
import '../../../../../../features/notifications/data/model/get_user_new_notification_model/get_user_new_notification_model.dart';
import '../../../../../../features/notifications/data/request/get_user_new_notification_request/get_user_new_notification_request.dart';
import '../../../../../../features/notifications/presentation/bloc/notification_cubit/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  NotificationModel? newNotification;

  List<NotificationModel> notifications = [];

  int get unreadCount =>
      notifications.where((e) => e.isViewed == false).length;

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
    if (isClosed) return;

    safeEmit(NotificationLoading());

    try {
      final user = await AuthLocalStorage.getUser();

      if (user == null) {
        safeEmit(NotificationError("User not found"));
        return;
      }

      _pageNumber = 1;

      final userResponse = await getUserNotificationFunction(
        request: GetUserNewNotificationRequest(
          userId: user.userid ?? 0,
          userType: user.type ?? 0,
          pageNumber: _pageNumber,
          pageSize: _pageSize,
        ),
      );

      final globalResponse = await getUserNotificationFunction(
        request: GetUserNewNotificationRequest(
          userId: 0,
          userType: user.type ?? 0,
          pageNumber: _pageNumber,
          pageSize: _pageSize,
        ),
      );

      notifications = [
        ...userResponse.data,
        ...globalResponse.data,
      ];

      notifications = {
        for (final item in notifications) item.id!: item,
      }.values.toList();

      notifications.sort(
            (a, b) => b.date!.compareTo(a.date!),
      );

      totalCount = userResponse.totalCount + globalResponse.totalCount;

      pageCount = userResponse.pageCount > globalResponse.pageCount
          ? userResponse.pageCount
          : globalResponse.pageCount;

      hasMore = _pageNumber < pageCount;

      safeEmit(NotificationSuccess(notifications));
    } catch (e) {
      safeEmit(NotificationError(e.toString()));
    }
  }

  Future<void> getUserNewNotification() async {
    if (isClosed) return;

    safeEmit(NotificationLoading());

    try {
      final user = await AuthLocalStorage.getUser();

      if (user == null) {
        safeEmit(NotificationError("User not found"));
        return;
      }

      newNotification = await getUserNewNotificationFunction(
        request: GetUserNewNotificationRequest(
          userId: user.userid ?? 0,
          userType: user.type ?? 0,
        ),
      );

      if (isClosed) return;

      safeEmit(NotificationNewSuccess(newNotification!));
    } catch (e) {
      if (isClosed) return;
      safeEmit(NotificationError(e.toString()));
    }
  }

  Future<void> makeNotificationViewed() async {
    if (isClosed) return;

    try {
      final user = await AuthLocalStorage.getUser();

      if (user == null) {
        safeEmit(NotificationError("User not found"));
        return;
      }

      await makeNotificationViewedFunction(
        request: GetUserNewNotificationRequest(
          userId: user.userid ?? 0,
          userType: user.type ?? 0,
        ),
      );

      if (isClosed) return;

      await getUserNotification();
    } catch (e) {
      if (isClosed) return;
      safeEmit(NotificationError(e.toString()));
    }
  }

  Future<void> loadMore() async {
    if (!hasMore || isLoadingMore) return;

    isLoadingMore = true;

    try {
      final user = await AuthLocalStorage.getUser();

      if (user == null) return;

      _pageNumber++;

      final userResponse = await getUserNotificationFunction(
        request: GetUserNewNotificationRequest(
          userId: user.userid ?? 0,
          userType: user.type ?? 0,
          pageNumber: _pageNumber,
          pageSize: _pageSize,
        ),
      );

      final globalResponse = await getUserNotificationFunction(
        request: GetUserNewNotificationRequest(
          userId: 0,
          userType: user.type ?? 0,
          pageNumber: _pageNumber,
          pageSize: _pageSize,
        ),
      );

      notifications.addAll(userResponse.data);
      notifications.addAll(globalResponse.data);

      notifications = {
        for (final item in notifications) item.id!: item,
      }.values.toList();

      notifications.sort(
            (a, b) => b.date!.compareTo(a.date!),
      );

      hasMore = _pageNumber < pageCount;

      safeEmit(NotificationSuccess(notifications));
    } finally {
      isLoadingMore = false;
    }
  }

}