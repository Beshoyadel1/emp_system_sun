import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:emp_system_sun/core/language/language_constant.dart';
import 'package:emp_system_sun/core/pages_widgets/general_widgets/snakbar.dart';
import 'package:emp_system_sun/core/theming/colors.dart';
import 'package:emp_system_sun/core/theming/fonts.dart';
import 'package:emp_system_sun/core/theming/text_styles.dart';
import 'package:emp_system_sun/features/auth_page/presentation/auth_gate.dart';
import 'package:emp_system_sun/features/auth_page/data/request/login_request/login_request.dart';
import 'package:emp_system_sun/features/auth_page/presentation/pages/check_email_exist/check_email_exist_page.dart';
import 'package:flutter/material.dart';
import 'package:emp_system_sun/core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_state.dart';
import 'package:emp_system_sun/features/auth_page/presentation/pages/login_page/login_widgets/login_button_widget.dart';
import 'package:emp_system_sun/features/auth_page/presentation/pages/login_page/login_widgets/user_text_field_widget.dart';
import 'package:flutter/cupertino.dart';

class LoginWidget extends StatelessWidget {
   LoginWidget({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextInAppWidget(
            text: AppLanguageKeys.loginKey,
            textSize: 20,
            fontWeightIndex: FontSelectionData.boldFontFamily,
          ),

          UserTextFieldWidget(
            controller: userNameController,
            type: UserFieldType.email,
            text: AppLanguageKeys.email,
          ),

          UserTextFieldWidget(
            controller: passwordController,
            type: UserFieldType.password,
            text: AppLanguageKeys.password,
          ),

          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {

              if (state is AuthAuthenticated) {
                Navigator.pushReplacement(
                  context,
                  NavigateToPageWidget(const AuthGate()),
                );
              }

              if (state is AuthLoginError) {
                AppSnackBar.showError(state.message);
              }
            },
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final isLoading = state is AuthLoginLoading;

                return LoginButtonWidget(
                  text: AppLanguageKeys.login,
                  isLoading: isLoading,
                  onPressed: isLoading
                      ? null
                      : () {

                    if (!_formKey.currentState!.validate()) return;

                    final loginRequest = LoginRequest(
                      user: userNameController.text.trim(),
                      password: passwordController.text.trim(),
                      type: UserType.employeeUser,
                    );

                    context.read<AuthCubit>().login(loginRequest);

                  },
                );
              },
            ),
          ),
          InkWell(
            onTap: () {
              context.read<AuthCubit>().showRestPassword();
              Navigator.push(
                context,
                NavigateToPageWidget(
                     const CheckEmailExistPage()
                ),
              );
            },
            child: const TextInAppWidget(
              text: AppLanguageKeys.forgotPasswordKey,
              textSize: 14,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              textColor: AppColors.darkColor,
            ),
          ),
        ],
      ),
    );
  }
}