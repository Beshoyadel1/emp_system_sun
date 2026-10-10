import '../../services/dialog_service/dialog_service.dart';
import '../../services/navigation_service/navigation_service.dart';
import '../../services/notification_alert_service.dart';

class NotificationModule {
  NotificationModule._();
  static final NotificationModule instance = NotificationModule._();
  final navigationService = const NotificationNavigationService();
  final dialogService = NotificationDialogService();
  final alertService = const NotificationAlertService();
}
