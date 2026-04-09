import 'package:flutter/material.dart';
import '../../../../../../core/theming/assets.dart';
import '../../../../../../core/theming/colors.dart';
import '../login_widgets/login_language_button_widget.dart';
import '../login_widgets/login_widget.dart';
import '../login_widgets/new_user_widget.dart';

class LoginMobileWidget extends StatelessWidget {
  const LoginMobileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: AppColors.secondaryColor,
            height: 30,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LoginLanguageButtonWidget(),
                  Image.asset(
                    AppImageKeys.sar_logo_emp,
                    height: 50,
                    width: 170,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 30),
                   LoginWidget(),
                ],
              ),
            ),
          ),
          const NewUserWidget()
        ],
      ),
    );
  }
}
