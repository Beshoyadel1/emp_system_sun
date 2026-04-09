import 'package:emp_system_sun/core/api_functions/user/create_user_model/employee_details_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/api_functions/user/create_user_model/employee_wrapper.dart';
import '../../../../core/api_functions/user/create_user_model/provider_details_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../features/auth_page/auth_cubit/auth_cubit.dart';
import '../../../../features/auth_page/auth_cubit/auth_state.dart';
import '../../../../core/api_functions/user/create_user_model/create_user_request.dart';
import '../../../../core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../features/auth_page/login_page/login_page.dart';
import '../../../../core/language/language_constant.dart';
import '../../../../core/theming/assets.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/fonts.dart';
import '../../../../core/theming/text_styles.dart';
import '../../login_page/login_widgets/login_button_widget.dart';
import '../../login_page/login_widgets/login_language_button_widget.dart';
import '../../login_page/login_widgets/user_text_field_widget.dart';

class SignUpMobileWidget extends StatefulWidget {
  const SignUpMobileWidget({super.key});

  @override
  State<SignUpMobileWidget> createState() => _SignUpMobileWidgetState();
}

class _SignUpMobileWidgetState extends State<SignUpMobileWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: AppBar(backgroundColor: AppColors.secondaryColor),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    const LoginLanguageButtonWidget(),

                    Image.asset(
                      AppImageKeys.sar_logo_emp,
                      height: 50,
                      width: 170,
                      fit: BoxFit.fill,
                    ),

                    const TextInAppWidget(
                      text: AppLanguageKeys.signUpTitleKey,
                      textSize: 25,
                      fontWeightIndex:
                      FontSelectionData.boldFontFamily,
                    ),

                    /// fields
                    UserTextFieldWidget(
                      type: UserFieldType.name,
                      controller: usernameController,
                      text: AppLanguageKeys.userName,
                    ),

                    UserTextFieldWidget(
                      type: UserFieldType.phone,
                      controller: phoneController,
                      text: AppLanguageKeys.phoneNumberKey,
                    ),

                    UserTextFieldWidget(
                      type: UserFieldType.email,
                      controller: emailController,
                      text: AppLanguageKeys.emailKey,
                    ),
                    UserTextFieldWidget(
                      type: UserFieldType.password,
                      controller: passwordController,
                      text: AppLanguageKeys.password,
                    ),
                    UserTextFieldWidget(
                      type: UserFieldType.password,
                      controller: confirmPasswordController,
                      text: AppLanguageKeys.confirmPasswordKey,
                    ),
                    const SizedBox(height: 10),

                    BlocBuilder<AuthCubit, AuthState>(
                      buildWhen: (previous, current) =>
                      current is AuthSignupLoading ||
                          current is AuthSignupSuccess ||
                          current is AuthSignupError ||
                          previous is AuthSignupLoading,
                      builder: (context, state) {
                        final bool isLoading = state is AuthSignupLoading;

                        if (state is AuthSignupSuccess) {
                          Future.microtask(() {
                            Navigator.of(context).pushReplacement(
                              NavigateToPageWidget(const LoginPage()),
                            );
                          });
                        }

                        if (state is AuthSignupError) {
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

                            final password = passwordController.text.trim();
                            final confirm = confirmPasswordController.text.trim();

                            if (password != confirm) {
                              AppSnackBar.showError(
                                  AppLanguageKeys.passwordsDoNotMatch);
                              return;
                            }
                            context.read<AuthCubit>().signup(
                              CreateUserRequest(
                                username: usernameController.text.trim(),
                                phone: phoneController.text.trim(),
                                email: emailController.text.trim(),
                                password: password,
                                type: UserType.employeeUser,
                                employeeWrapper: EmployeeWrapper(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}