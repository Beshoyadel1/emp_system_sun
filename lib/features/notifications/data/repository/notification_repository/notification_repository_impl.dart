import '../../../../../../core/theming/auth_local_storage.dart';
import '../../../../../../features/notifications/domain/repository/notification_repository/notification_repository.dart';

class NotificationRepositoryImpl
    implements NotificationRepository {

  @override
  Future<dynamic> getCurrentUser() async {
    return await AuthLocalStorage.getUser();
  }
}