import 'package:flutter/material.dart';
import '../../../../../core/theming/colors.dart';
import 'login_devices_sizes_widget/login_web_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.scaffoldColor,
        ),
        child: const LoginWebWidget(),
      ),
    );
  }
}
