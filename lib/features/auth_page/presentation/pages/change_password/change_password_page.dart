import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/core/language/language.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../features/auth_page/presentation/bloc/auth_cubit/auth_cubit.dart';
import '../../../../../features/auth_page/presentation/bloc/auth_cubit/auth_state.dart';
import '../../../../../features/auth_page/presentation/pages/login_page/login_widgets/login_button_widget.dart';
import '../../../../../features/auth_page/presentation/pages/login_page/login_widgets/login_image.dart';
import '../../../../../features/auth_page/presentation/pages/login_page/login_widgets/user_text_field_widget.dart';

class ChangePasswordPage extends StatefulWidget {
  final String email;
  final bool returnToAccount;

  const ChangePasswordPage({
    super.key,
    required this.email,
    this.returnToAccount = false,
  });

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  late GlobalKey<FormState> formKey;
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  final _confirmFieldKey = GlobalKey<FormFieldState<String>>();
  String? _languageCode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final code = Localizations.localeOf(context).languageCode;
    if (_languageCode != null && code != _languageCode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        for (final key in [_passwordFieldKey, _confirmFieldKey]) {
          if (key.currentState?.hasError == true) key.currentState!.validate();
        }
      });
    }
    _languageCode = code;
  }

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
    if (widget.returnToAccount &&
        context.read<AuthCubit>().state is ChangePasswordLoading) {
      return;
    }
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
          updateStoredPassword: widget.returnToAccount,
        );
  }

  Widget _accountPasswordField({
    required TextEditingController controller,
    required bool isVisible,
    required bool isSaving,
    required VoidCallback toggleVisibility,
    bool isConfirm = false,
  }) {
    return TextFormField(
      key: isConfirm ? _confirmFieldKey : _passwordFieldKey,
      controller: controller,
      enabled: !isSaving,
      obscureText: !isVisible,
      autocorrect: false,
      enableSuggestions: false,
      validator: (value) {
        final localizations = AppLocalizations.of(context);
        if (value == null || value.trim().isEmpty) {
          return localizations.translate(AppLanguageKeys.authPasswordRequired);
        }
        if (isConfirm && value.trim() != passwordController.text.trim()) {
          return localizations.translate(AppLanguageKeys.passwordsDoNotMatch);
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.whiteColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkGreyColor),
        ),
        suffixIcon: IconButton(
          onPressed: isSaving ? null : toggleVisibility,
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }

  Widget _buildAccountPage() {
    final navigator = Navigator.of(context);
    void returnToAccount() => navigator.popUntil((route) => route.isFirst);

    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is ChangePasswordSuccess || current is ChangePasswordError,
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          AppSnackBar.showSuccess(state.message);
          returnToAccount();
        } else if (state is ChangePasswordError) {
          AppSnackBar.showError(state.message);
        }
      },
      builder: (context, state) {
        final isSaving = state is ChangePasswordLoading;
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop && !isSaving) returnToAccount();
          },
          child: Scaffold(
            backgroundColor: AppColors.scaffoldColor,
            appBar: AppBar(
              backgroundColor: AppColors.scaffoldColor,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const BackButtonIcon(),
                onPressed: isSaving ? null : returnToAccount,
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Form(
                    key: formKey,
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextInAppWidget(
                          text: AppLanguageKeys.changePassword,
                          textSize: 22,
                          textColor: AppColors.darkColor,
                          fontWeightIndex: FontSelectionData.boldFontFamily,
                        ),
                        const TextInAppWidget(
                          text: AppLanguageKeys.password,
                          textSize: 20,
                          textColor: AppColors.darkColor,
                        ),
                        _accountPasswordField(
                          controller: passwordController,
                          isVisible: _passwordVisible,
                          isSaving: isSaving,
                          toggleVisibility: () => setState(() {
                            _passwordVisible = !_passwordVisible;
                          }),
                        ),
                        const TextInAppWidget(
                          text: AppLanguageKeys.confirmPasswordKey,
                          textSize: 20,
                          textColor: AppColors.darkColor,
                        ),
                        _accountPasswordField(
                          controller: confirmPasswordController,
                          isConfirm: true,
                          isVisible: _confirmPasswordVisible,
                          isSaving: isSaving,
                          toggleVisibility: () => setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
                          }),
                        ),
                        LoginButtonWidget(
                          text: AppLanguageKeys.save,
                          isLoading: isSaving,
                          onPressed: isSaving ? null : _changePassword,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.returnToAccount) return _buildAccountPage();
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
