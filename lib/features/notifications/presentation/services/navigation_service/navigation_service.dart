import '../../../../../../core/cubit/app_cubit/app_cubit.dart';
import '../../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../../main.dart';


class NotificationNavigationService {
  const NotificationNavigationService();

  void openDashboardOrders() {
    final context = navigatorKey.currentContext;

    if (context == null) return;

    AppCubit.get(context).navigateToPage(
      PagesOfAllApp.dashboardPageNumber,
    );
  }
  void openChat() {
    final context = navigatorKey.currentContext;

    if (context == null) return;

    AppCubit.get(context).navigateToPage(
      PagesOfAllApp.technicalSupportPageNumber,
    );
  }
}