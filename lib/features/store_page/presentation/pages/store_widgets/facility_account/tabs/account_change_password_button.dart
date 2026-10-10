import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/core/language/language_constant.dart';
import 'package:emp_system_sun/core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import 'package:emp_system_sun/core/pages_widgets/general_widgets/snakbar.dart';
import 'package:emp_system_sun/core/theming/colors.dart';
import 'package:emp_system_sun/core/theming/text_styles.dart';
import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/create_user_request.dart';
import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:emp_system_sun/features/auth_page/presentation/pages/otp_page/otp_page.dart';

class AccountChangePasswordButton extends StatefulWidget {
  const AccountChangePasswordButton({
    super.key,
    required this.user,
    this.enabled = true,
  });

  final CreateUserRequest? user;
  final bool enabled;

  @override
  State<AccountChangePasswordButton> createState() =>
      _AccountChangePasswordButtonState();
}

class _AccountChangePasswordButtonState
    extends State<AccountChangePasswordButton> {
  bool _isChangingPassword = false;
  AuthCubit? _flowCubit;

  @override
  void dispose() {
    final cubit = _flowCubit;
    if (cubit != null && !cubit.isClosed) unawaited(cubit.close());
    super.dispose();
  }

  Future<void> _changePassword() async {
    if (_isChangingPassword) return;

    final email = widget.user?.email?.trim() ?? '';
    final phone = widget.user?.phone?.trim() ?? '';
    if (email.isEmpty) {
      AppSnackBar.showError(AppLanguageKeys.userNotFound);
      return;
    }
    if (phone.isEmpty) {
      AppSnackBar.showError(AppLanguageKeys.phoneNumberNotFoundForThisAccount);
      return;
    }

    setState(() => _isChangingPassword = true);
    // Keep password reset states separate from the logged-in AuthCubit.
    final cubit = AuthCubit();
    _flowCubit = cubit;
    try {
      final sent = await cubit.sendOtp(
        email: email,
        phone: phone,
        purpose: OtpMessagePurpose.passwordReset,
        languageCode: Localizations.localeOf(context).languageCode,
      );
      if (!mounted) return;
      if (!sent) {
        AppSnackBar.showError(AppLanguageKeys.failedToSendVerificationCode);
        return;
      }

      // This route stays on the account navigator until the whole flow ends.
      await Navigator.of(context).push(
        NavigateToPageWidget<void>(
          BlocProvider.value(
            value: cubit,
            child: OtpPage(
              email: email,
              purpose: OtpPurpose.forgotPassword,
              returnToAccount: true,
            ),
          ),
        ),
      );
    } finally {
      if (!cubit.isClosed) await cubit.close();
      _flowCubit = null;
      if (mounted) setState(() => _isChangingPassword = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.orangeColor),
      onPressed: widget.enabled && widget.user != null && !_isChangingPassword
          ? _changePassword
          : null,
      icon: _isChangingPassword
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.lock_outline,
              color: AppColors.whiteColor, size: 18),
      label: const TextInAppWidget(
        text: AppLanguageKeys.changePassword,
        textColor: AppColors.whiteColor,
        textSize: 13,
      ),
    );
  }
}
