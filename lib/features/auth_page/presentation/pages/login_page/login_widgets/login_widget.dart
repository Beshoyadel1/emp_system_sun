import '../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import '../../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../features/auth_page/data/request/login_request/login_request.dart';
import '../../../../../../features/auth_page/presentation/auth_gate.dart';
import '../../../../../../features/auth_page/presentation/bloc/auth_cubit/auth_cubit.dart';
import '../../../../../../features/auth_page/presentation/bloc/auth_cubit/auth_state.dart';
import '../../../../../../features/auth_page/presentation/pages/check_email_exist/check_email_exist_page.dart';
import '../../../../../../features/auth_page/presentation/pages/login_page/login_widgets/login_button_widget.dart';
import '../../../../../../features/auth_page/presentation/pages/login_page/login_widgets/user_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();

    userNameController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: formKey,
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

          BlocConsumer<AuthCubit, AuthState>(
            listenWhen: (previous, current) =>
            current is AuthLoginSuccess ||
                current is AuthLoginError,

            listener: (context, state) {
              if (state is AuthLoginSuccess) {
                AppSnackBar.showSuccess(
                  AppLanguageKeys.success,
                );

                Navigator.pushReplacement(
                  context,
                  NavigateToPageWidget(
                    const AuthGate(),
                  ),
                );
              }

              if (state is AuthLoginError) {
                AppSnackBar.showError(
                  state.message,
                );
              }
            },

            buildWhen: (previous, current) =>
            current is AuthLoginLoading ||
                previous is AuthLoginLoading,

            builder: (context, state) {
              final isLoading = state is AuthLoginLoading;

              return LoginButtonWidget(
                text: AppLanguageKeys.login,
                isLoading: isLoading,
                onPressed: isLoading
                    ? null
                    : () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  final loginRequest = LoginRequest(
                    user: userNameController.text.trim(),
                    password: passwordController.text.trim(),
                    type: UserType.employeeUser,
                  );

                  context
                      .read<AuthCubit>()
                      .login(loginRequest);
                },
              );
            },
          ),

          InkWell(
            onTap: () {
              Navigator.push(
                context,
                NavigateToPageWidget(
                  const CheckEmailExistPage(),
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