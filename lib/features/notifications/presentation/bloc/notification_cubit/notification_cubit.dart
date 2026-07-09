import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../features/auth_page/data/datasource/login_datasource/login_repository.dart';
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

      /// إشعارات المستخدم
      final userNotifications = await getUserNotificationFunction(
        request: GetUserNewNotificationRequest(
          userId: user.userid ?? 0,
          userType: user.type ?? 0,
        ),
      );

      /// إشعارات عامة لنفس النوع (userId = 0)
      final globalNotifications = await getUserNotificationFunction(
        request: GetUserNewNotificationRequest(
          userId: 0,
          userType: user.type ?? 0,
        ),
      );

      /// دمج القائمتين
      notifications = [
        ...userNotifications,
        ...globalNotifications,
      ];

      /// إزالة التكرار حسب الـ ID
      notifications = {
        for (final item in notifications) item.id!: item,
      }.values.toList();

      /// الأحدث أولاً
      notifications.sort(
            (a, b) => b.date!.compareTo(a.date!),
      );

      if (isClosed) return;

      safeEmit(NotificationSuccess(notifications));
    } catch (e) {
      if (isClosed) return;
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
}