import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/auth_page/auth_cubit/auth_state.dart';
import '../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../../features/auth_page/auth_cubit/auth_cubit.dart';
import '../../../../../core/theming/colors.dart';
import 'sign_up_sizes_widget/sign_up_mobile_widget.dart';
import 'sign_up_sizes_widget/sign_up_web_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: AppColors.scaffoldColor,
          ),
          child: isMobile
              ?  const SignUpMobileWidget()
              : const SignUpWebWidget(),
        ),
      ),
    );
  }
}
