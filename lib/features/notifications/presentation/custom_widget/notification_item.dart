import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../features/notifications/data/model/get_user_new_notification_model/get_user_new_notification_model.dart';

class NotificationItem extends StatelessWidget{
  final NotificationModel notification;

  const NotificationItem({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.scaffoldColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.greyColor,
            child:  Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextInAppWidget(
                  text: notification.getTitle(context),
                  textSize: 16,
                  textColor: AppColors.blackColor,
                  fontWeightIndex: FontSelectionData.mediumFontFamily,
                ),

                const SizedBox(height: 6),

                TextInAppWidget(
                  text: notification.getDescription(context),
                  textSize: 13,
                  textColor: AppColors.greyColor,
                ),

                const SizedBox(height: 8),

                TextInAppWidget(
                  text: notification.getFormattedDate(context),
                  textSize: 11,
                  textColor: AppColors.greyColor,
                ),
              ],
            ),
          ),

          if (notification.isViewed == false)
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          
        ],
      ),
    );
  }
}