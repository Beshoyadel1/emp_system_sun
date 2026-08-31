import 'package:emp_system_sun/core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import 'package:emp_system_sun/core/pages_widgets/general_widgets/snakbar.dart';
import 'package:emp_system_sun/core/theming/colors.dart';
import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:emp_system_sun/features/auth_page/presentation/pages/change_password/change_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/core/language/language_constant.dart';
import 'package:emp_system_sun/core/theming/fonts.dart';
import 'package:emp_system_sun/core/theming/text_styles.dart';
import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_state.dart';
import 'package:flutter/cupertino.dart';

enum OtpPurpose {
  forgotPassword,
  signup,
}

class OtpPage extends StatefulWidget {
  final String email;
  final OtpPurpose purpose;

  const OtpPage({
    super.key,
    required this.email,
    required this.purpose,
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
}


class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> controllers = List.generate(
    4,
        (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(
    4,
        (_) => FocusNode(),
  );

// =========================================================
// INIT
// =========================================================

  @override
  void initState() {
    super.initState();

// Focus first field after page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      focusNodes.first.requestFocus();
    });
  }

// =========================================================
// DISPOSE
// =========================================================

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }

    for (final focusNode in focusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

// =========================================================
// GET OTP
// =========================================================

  String getOtp() {
    return controllers
        .map(
          (controller) => controller.text,
    )
        .join();
  }

// =========================================================
// CLEAR OTP
// =========================================================

  void clearOtp() {
    for (final controller in controllers) {
      controller.clear();
    }

    final cubit = context.read<AuthCubit>();

    cubit.resetOtpError();

    if (mounted) {
      focusNodes.first.requestFocus();
    }
  }

// =========================================================
// VERIFY OTP
// =========================================================

  void _verifyOtp() {
    final code = getOtp();

    if (code.length != 4) {
      final cubit = context.read<AuthCubit>();

      cubit.validateOtp(code);

      return;
    }

    context.read<AuthCubit>().validateOtp(code);
  }

// =========================================================
// HANDLE OTP SUCCESS
// =========================================================

  Future<void> _handleOtpSuccess() async {
    final cubit = context.read<AuthCubit>();

    if (widget.purpose == OtpPurpose.signup) {
      await cubit.completeSignupAfterOtp();
      return;
    }

    final email = cubit.verificationEmail;

    if (email == null || email.trim().isEmpty) {
      AppSnackBar.showError(
        AppLanguageKeys.userNotFound,
      );
      return;
    }

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      NavigateToPageWidget(
        BlocProvider.value(
          value: cubit,
          child: ChangePasswordPage(
            email: email,
          ),
        ),
      ),
    );
  }

// =========================================================
// BUILD
// =========================================================

  @override
  Widget build(BuildContext context) {
    return  BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
      current is AuthOtpSuccess ||
          current is AuthOtpError ||
          current is AuthSignupCompleted ||
          current is AuthSignupError,
      listener: (context, state) {
        if (state is AuthOtpSuccess) {
          _handleOtpSuccess();
          return;
        }

        if (state is AuthSignupCompleted) {
          if (!mounted) return;

          AppSnackBar.showSuccess(
            AppLanguageKeys.success,
          );

          // OTP Page -> Signup Page
          Navigator.of(context).pop();

          // Signup Page -> Login Page
          Navigator.of(context).pop();

          return;
        }


        if (state is AuthSignupError) {
          AppSnackBar.showError(
            state.message,
          );
          return;
        }

        if (state is AuthOtpError) {
          AppSnackBar.showError(
            state.message,
          );
        }
      },
      child:  Scaffold(
        appBar: AppBar(),
        backgroundColor: AppColors.scaffoldColor,
        body: Center(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
// =================================================
// TITLE
// =================================================

                TextInAppWidget(
                  text: widget.purpose == OtpPurpose.signup
                      ? AppLanguageKeys.signUpTitleKey
                      : AppLanguageKeys.forgotPasswordKey,
                  textSize: 22,
                  fontWeightIndex: FontSelectionData.boldFontFamily,
                ),

                const SizedBox(height: 10),

// =================================================
// OTP DESCRIPTION
// =================================================

                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (previous, current) =>
                  current is CheckIfUserExistOrNotSuccess ||
                      current is AuthOtpGenerated ||
                      current is AuthOtpResendSuccess,
                  builder: (context, state) {
                    final cubit = context.read<AuthCubit>();

                    final phone = cubit.verificationPhone;

                    return Column(
                      children: [
                        const TextInAppWidget(
                          text: AppLanguageKeys.enterOtp,
                          textSize: 14,
                          fontWeightIndex: FontSelectionData.regularFontFamily,
                          textColor: AppColors.greyColor,
                        ),
                        const SizedBox(height: 8),
                        if (phone != null && phone.trim().isNotEmpty)
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 5,
                            runSpacing: 5,
                            children: [
                              const TextInAppWidget(
                                text: AppLanguageKeys.codeSentTo,
                                textSize: 13,
                                fontWeightIndex:
                                FontSelectionData.semiBoldFontFamily,
                                textColor: AppColors.darkColor,
                              ),
                              TextInAppWidget(
                                text: phone,
                                textSize: 13,
                                fontWeightIndex:
                                FontSelectionData.semiBoldFontFamily,
                                textColor: AppColors.darkColor,
                              ),
                            ],
                          ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 25),

// =================================================
// OTP INPUTS
// =================================================

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    4,
                        (index) {
                      return SizedBox(
                        width: 65,
                        height: 65,
                        child: BlocBuilder<AuthCubit, AuthState>(
                          buildWhen: (previous, current) =>
                          current is AuthOtpError ||
                              current is AuthOtpReset,
                          builder: (context, state) {
                            final cubit = context.read<AuthCubit>();

                            return TextField(
                              controller: controllers[index],
                              focusNode: focusNodes[index],
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                counterText: "",
                                filled: true,
                                fillColor: AppColors.lightWhiteColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: AppColors.greyColor200,
                                    width: 2,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: cubit.isOtpError
                                        ? AppColors.redColor
                                        : AppColors.greyColor200,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: cubit.isOtpError
                                        ? AppColors.redColor
                                        : AppColors.orangeColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                final cubit = context.read<AuthCubit>();

// Remove OTP error
                                cubit.resetOtpError();

// =================================================
// ENTERED VALUE
// =================================================

                                if (value.isNotEmpty) {
                                  if (index < 3) {
                                    focusNodes[index + 1].requestFocus();
                                  } else {
                                    focusNodes[index].unfocus();

                                    Future.delayed(
                                      const Duration(
                                        milliseconds: 100,
                                      ),
                                          () {
                                        if (!mounted) return;

                                        final code = getOtp();

                                        if (code.length == 4) {
                                          _verifyOtp();
                                        }
                                      },
                                    );
                                  }

                                  return;
                                }

// =================================================
// DELETE
// =================================================

                                if (index > 0) {
                                  focusNodes[index - 1].requestFocus();
                                }
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 25),

// =================================================
// TIMER
// =================================================

                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (previous, current) =>
                  current is AuthOtpGenerated ||
                      current is AuthOtpTimer ||
                      current is AuthOtpExpired ||
                      current is AuthOtpError ||
                      current is AuthOtpSuccess ||
                      current is AuthOtpResendSuccess,
                  builder: (context, state) {
                    final cubit = context.read<AuthCubit>();

                    return TextInAppWidget(
                      text:
                      "00:${cubit.secondsRemaining.toString().padLeft(2, '0')}",
                      textSize: 13,
                      fontWeightIndex: FontSelectionData.boldFontFamily,
                      textColor: AppColors.redColor,
                    );
                  },
                ),

                const SizedBox(height: 25),

// =================================================
// VERIFY BUTTON
// =================================================

                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (previous, current) =>
                    current is AuthOtpSuccess ||
                        current is AuthOtpError,
                    builder: (context, state) {

                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orangeColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed:  _verifyOtp,
                        child:const TextInAppWidget(
                          text: AppLanguageKeys.verify,
                          textSize: 14,
                          fontWeightIndex:
                          FontSelectionData.regularFontFamily,
                          textColor: AppColors.whiteColor,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 15),

// =================================================
// RESEND
// =================================================

                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (previous, current) =>
                  current is AuthOtpGenerated ||
                      current is AuthOtpTimer ||
                      current is AuthOtpExpired ||
                      current is AuthOtpResendSuccess ||
                      current is AuthOtpError,
                  builder: (context, state) {
                    final cubit = context.read<AuthCubit>();

// =================================================
// TIMER STILL RUNNING
// =================================================

                    if (cubit.secondsRemaining > 0) {
                      return const SizedBox();
                    }

// =================================================
// RESEND BUTTON
// =================================================

                    return TextButton(
                      onPressed: () async {
                        clearOtp();

                        await cubit.resendOtp();
                      },
                      child: const TextInAppWidget(
                        text: AppLanguageKeys.resend,
                        textSize: 14,
                        fontWeightIndex: FontSelectionData.boldFontFamily,
                        textColor: AppColors.blackColor,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}