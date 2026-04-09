import 'package:emp_system_sun/features/internal_services/custom_widget/notification_design_dashboard/notification_design_dashboard.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';

class AppbarDashboardWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onTap;
  final String? imagePath;

  const AppbarDashboardWidget(
      {super.key, required this.title, this.onTap, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.whiteColor,
      title: TextInAppWidget(
        text: title,
        textSize: 18,
        fontWeightIndex: FontSelectionData.mediumFontFamily,
        textColor: AppColors.darkColor,
      ),
      actions: [
        Builder(
          builder: (context) {
            return InkWell(
              child: Image.asset(AppImageKeys.notify, width: 30),
              onTap: () async {
                final RenderBox button =
                    context.findRenderObject() as RenderBox;
                final RenderBox overlay =
                    Overlay.of(context).context.findRenderObject() as RenderBox;

                final position = RelativeRect.fromRect(
                  Rect.fromPoints(
                    button.localToGlobal(Offset.zero, ancestor: overlay),
                    button.localToGlobal(button.size.bottomRight(Offset.zero),
                        ancestor: overlay),
                  ),
                  Offset.zero & overlay.size,
                );

                await showMenu(
                  context: context,
                  position: position,
                  color: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  items: [
                    PopupMenuItem(
                        enabled: false,
                        padding: EdgeInsets.zero,
                        child: NotificationDesignDashboard()),
                  ],
                );
              },
            );
          },
        ),
        const SizedBox(width: 20),
        Image.asset(imagePath ?? AppImageKeys.person, width: 30),
        const SizedBox(width: 30),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
