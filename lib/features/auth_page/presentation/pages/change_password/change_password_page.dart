import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../features/auth_page/data/request/change_password_request/change_password_request.dart';
import '../../../../../features/auth_page/presentation/bloc/auth_cubit/auth_cubit.dart';
import '../../../../../features/auth_page/presentation/bloc/auth_cubit/auth_state.dart';
import '../../../../../features/auth_page/presentation/pages/login_page/login_widgets/login_button_widget.dart';
import '../../../../../features/auth_page/presentation/pages/login_page/login_widgets/login_image.dart';
import '../../../../../features/auth_page/presentation/pages/login_page/login_widgets/user_text_field_widget.dart';

class ChangePasswordPage extends StatefulWidget {
  final String email;

  const ChangePasswordPage({
    super.key,
    required this.email,
  });

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();

    passwordController = TextEditingController();

    confirmPasswordController = TextEditingController();

    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  // =========================================================
  // CHANGE PASSWORD
  // =========================================================

  void _changePassword() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final password = passwordController.text.trim();

    final confirmPassword = confirmPasswordController.text.trim();

    // =======================================================
    // CHECK PASSWORD MATCH
    // =======================================================

    if (password != confirmPassword) {
      AppSnackBar.showError(
        AppLanguageKeys.passwordsDoNotMatch,
      );

      return;
    }

    // =======================================================
    // CALL API
    // =======================================================

    context.read<AuthCubit>().changePassword(
      user: widget.email,
      password: password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // ===================================================
          // FORM
          // ===================================================

          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: AppBar(
                    backgroundColor: AppColors.blueColor,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            spacing: 10,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // =================================
                              // PASSWORD
                              // =================================

                              const TextInAppWidget(
                                text: AppLanguageKeys.password,
                                textColor: AppColors.darkColor,
                                textSize: 20,
                                fontWeightIndex:
                                FontSelectionData.semiBoldFontFamily,
                              ),

                              UserTextFieldWidget(
                                type: UserFieldType.password,
                                controller: passwordController,
                              ),

                              // =================================
                              // CONFIRM PASSWORD
                              // =================================

                              const TextInAppWidget(
                                text: AppLanguageKeys.confirmPasswordKey,
                                textColor: AppColors.darkColor,
                                textSize: 20,
                                fontWeightIndex:
                                FontSelectionData.semiBoldFontFamily,
                              ),

                              UserTextFieldWidget(
                                type: UserFieldType.password,
                                controller: confirmPasswordController,
                              ),

                              // =================================
                              // BUTTON
                              // =================================

                              BlocConsumer<AuthCubit, AuthState>(
                                listenWhen: (
                                    previous,
                                    current,
                                    ) =>
                                current is ChangePasswordSuccess ||
                                    current is ChangePasswordError,
                                listener: (
                                    context,
                                    state,
                                    ) {
                                  // =========================
                                  // SUCCESS
                                  // =========================

                                  if (state is ChangePasswordSuccess) {
                                    AppSnackBar.showSuccess(
                                      state.message,
                                    );
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }

                                  // =========================
                                  // ERROR
                                  // =========================

                                  if (state is ChangePasswordError) {
                                    AppSnackBar.showError(
                                      state.message,
                                    );
                                  }
                                },
                                builder: (
                                    context,
                                    state,
                                    ) {
                                  final isLoading =
                                  state is ChangePasswordLoading;

                                  return LoginButtonWidget(
                                    text: AppLanguageKeys.send,
                                    isLoading: isLoading,
                                    onPressed:
                                    isLoading ? null : _changePassword,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ===================================================
          // IMAGE
          // ===================================================

          if (MediaQuery.of(context).size.width > ValuesOfAllApp.mobileWidth)
            const LoginImage(),
        ],
      ),
    );
  }
}