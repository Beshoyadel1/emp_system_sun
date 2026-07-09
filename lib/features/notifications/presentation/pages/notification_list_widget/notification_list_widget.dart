import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../features/internal_services/presentation/pages/internal_orders/custom_widget/text_empty_view_data.dart';
import '../../../../../../features/notifications/presentation/bloc/notification_cubit/notification_cubit.dart';
import '../../../../../../features/notifications/presentation/bloc/notification_cubit/notification_state.dart';
import '../../../../../../features/notifications/presentation/custom_widget/notification_item.dart';

class NotificationListWidget extends StatelessWidget {
  const NotificationListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state is NotificationLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is NotificationError) {
          return Center(
            child: TextInAppWidget(
              text: state.message,
              textColor: AppColors.redColor,
              textSize: 12,
            ),
          );
        }

        final cubit = context.read<NotificationCubit>();

        if (cubit.notifications.isEmpty) {
          return const TextEmptyViewData();
        }

        final notifications = cubit.notifications;

        return ListView.separated(
          padding: const EdgeInsets.all(15),
          itemCount: notifications.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (_, index) {
            return NotificationItem(
              notification: notifications[index],
            );
          },
        );
      },
    );
  }
}