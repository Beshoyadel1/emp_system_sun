import 'package:flutter/material.dart';

import '../../login_page/login_widgets/login_image.dart';
import 'sign_up_mobile_widget.dart';

class SignUpWebWidget extends StatelessWidget {
  const SignUpWebWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: SignUpMobileWidget()),
         LoginImage(),
      ],
    );
  }
}
