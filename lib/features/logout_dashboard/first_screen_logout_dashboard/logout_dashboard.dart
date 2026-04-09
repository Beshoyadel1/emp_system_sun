import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../../../features/auth_page/login_page/login_page.dart';
import '../../../../../../core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import '../../../../../../features/logout_dashboard/first_screen_logout_dashboard/screens/last_two_button_in_logout_dashboard.dart';
import '../../../../../../features/logout_dashboard/first_screen_logout_dashboard/screens/first_part_in_logout_dashboard.dart';
import '../../../../../../core/theming/colors.dart';

class LogoutDashboard extends StatelessWidget {
  const LogoutDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: 400,
          height: 300,
          decoration: BoxDecoration(
            color: AppColors.scaffoldColor,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 10,
            children: [
              const FirstPartInLogoutDashboard(),
              LastTwoButtonInLogoutDashboard(
                onTapConfirm: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    NavigateToPageWidget(
                      const LoginPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
