import '../../../../../../features/notifications/domain/repository/notification_repository/notification_repository.dart';
import '../../../../auth_page/data/datasource/login_datasource/login_repository.dart';

class NotificationRepositoryImpl
    implements NotificationRepository {

  @override
  Future<dynamic> getCurrentUser() async {
    return await AuthLocalStorage.getUser();
  }
}