import '../../../../../../features/notifications/data/model/get_user_new_notification_model/get_user_new_notification_model.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final List<NotificationModel> notifications;

  NotificationSuccess(this.notifications);
}

class NotificationNewSuccess extends NotificationState {
  final NotificationModel notification;

  NotificationNewSuccess(this.notification);
}

class NotificationError extends NotificationState {
  final String message;

  NotificationError(this.message);
}