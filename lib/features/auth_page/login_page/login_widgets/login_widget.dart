import 'package:flutter/material.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../features/auth_page/check_email_exist/check_email_exist_page.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/api_functions/user/login_model/login_request.dart';
import '../../../../features/auth_page/auth_cubit/auth_cubit.dart';
import '../../../../features/auth_page/auth_cubit/auth_state.dart';
import '../../../../core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../features/store_page/store_page.dart';
import '../../../../core/language/language_constant.dart';
import '../../../../core/theming/fonts.dart';
import '../../../../core/theming/text_styles.dart';
import 'login_button_widget.dart';
import 'user_text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

      BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (previous, current) =>
        current is AuthLoginLoading ||
            current is AuthLoginSuccess ||
            current is AuthLoginError ||
            previous is AuthLoginLoading,

        builder: (context, state) {
          final bool isLoading = state is AuthLoginLoading;

          if (state is AuthLoginSuccess) {
            Future.microtask(() {
              Navigator.of(context).pushReplacement(
                NavigateToPageWidget(const StorePage()),
              );
            });
          }

          if (state is AuthLoginError) {
            Future.microtask(() {
              AppSnackBar.showError(state.message);
            });
          }

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

