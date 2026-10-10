import '../../../../../../core/cubit/app_cubit/app_cubit.dart';
import '../../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/core/setup_git_it.dart';
import 'package:emp_system_sun/features/notifications/data/model/notification_payload.dart';
import 'package:emp_system_sun/features/internal_services/data/model/get_provider_orders_model/order_model.dart';
import 'package:emp_system_sun/features/order_status_design/presentation/pages/order_details/order_details.dart';
import 'package:emp_system_sun/features/technical_support/presentation/bloc/employee_chat_cubit/employee_chat_cubit.dart';
import 'package:emp_system_sun/features/technical_support/presentation/pages/mobile_chat_page.dart';
import 'package:emp_system_sun/features/notifications/presentation/pages/notifications_page/notifications_page.dart';
import 'package:emp_system_sun/features/cars_haraj_page/presentation/ui/page_details_harag/page_details_harag.dart';

class NotificationNavigationService {
  const NotificationNavigationService();

  void openPayload(NotificationPayload payload) {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    if (payload.isOrder && payload.orderId != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => OrderDetails(
                order: OrderModel(id: payload.orderId)
                    .applyPatch(payload.orderPatch),
              )));
    } else if (payload.kind == NotificationKind.chat ||
        payload.kind == NotificationKind.chatStatus) {
      final harageId = payload.integer('harageid');
      if (harageId != null && harageId > 0) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => PageDetailsHarag(harageId: harageId)));
        return;
      }
      final chat = getIt<EmployeeChatCubit>();
      final id = payload.integer('fromuser');
      final type = payload.integer('fromusertype');
      if (id == null || type == null) {
        openChat();
        return;
      }
      chat.openConversation(
          id, type, payload.get('fromusername')?.toString() ?? '');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => BlocProvider.value(
                value: chat,
                child: const MobileChatPage(),
              )));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const NotificationsPage()));
    }
  }

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
