import 'package:flutter/material.dart';

import '../../../../../../core/theming/colors.dart';
import '../../auth_form_layout.dart';
import 'sign_up_mobile_widget.dart';

class SignUpWebWidget extends StatelessWidget {
  const SignUpWebWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthFormLayout(
      header: SizedBox(
        height: 40,
        child: AppBar(backgroundColor: AppColors.seaBlueColor),
      ),
      child: const SignUpMobileWidget(),
    );
  }
}
