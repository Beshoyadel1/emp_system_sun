import 'package:emp_system_sun/core/utilies/map_of_all_app.dart';
import 'package:flutter/material.dart';

import '../../login_page/login_widgets/login_image.dart';
import 'sign_up_mobile_widget.dart';

class SignUpWebWidget extends StatelessWidget {
  const SignUpWebWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Expanded(child: SignUpMobileWidget()),
        if(MediaQuery.of(context).size.width > ValuesOfAllApp.mobileWidth) const LoginImage(),
      ],
    );
  }
}
