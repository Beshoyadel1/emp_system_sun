import 'package:flutter/material.dart';

import '../../../../../../core/theming/assets.dart';
import '../../../../../../core/theming/colors.dart';
import '../../auth_form_layout.dart';
import '../login_widgets/login_language_button_widget.dart';
import '../login_widgets/login_widget.dart';

class LoginWebWidget extends StatelessWidget {
  const LoginWebWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthFormLayout(
      header: Container(
        color: AppColors.seaBlueColor,
        height: 30,
        width: double.infinity,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LoginLanguageButtonWidget(),
          Image.asset(
            AppImageKeys.sarLogoEmp,
            height: 50,
            width: 170,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 30),
          const LoginWidget(),
        ],
      ),
    );
  }
}
