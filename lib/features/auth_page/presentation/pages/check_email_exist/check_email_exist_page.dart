import 'package:emp_system_sun/core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import 'package:emp_system_sun/features/auth_page/presentation/pages/otp_page/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_state.dart';
import 'package:emp_system_sun/features/auth_page/presentation/pages/login_page/login_widgets/login_button_widget.dart';
import 'package:emp_system_sun/features/auth_page/presentation/pages/login_page/login_widgets/login_image.dart';
import 'package:emp_system_sun/features/auth_page/presentation/pages/login_page/login_widgets/user_text_field_widget.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/utilies/map_of_all_app.dart';

class CheckEmailExistPage extends StatefulWidget {
  const CheckEmailExistPage({super.key});

  @override
  State<CheckEmailExistPage> createState() => _CheckEmailExistPageState();
}

class _CheckEmailExistPageState extends State<CheckEmailExistPage> {
  late TextEditingController emailController;

  late GlobalKey<FormState> checkEmailExistFormKey;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();

    checkEmailExistFormKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: Row(
          children: [
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
                            autovalidateMode: AutovalidateMode.disabled,
                            key: checkEmailExistFormKey,
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextInAppWidget(
                                  text: AppLanguageKeys.pleaseEnterYourEmail,
                                  textColor: AppColors.darkColor,
                                  textSize: 20,
                                  fontWeightIndex:
                                      FontSelectionData.semiBoldFontFamily,
                                ),
                                UserTextFieldWidget(
                                  type: UserFieldType.email,
                                  controller: emailController,
                                ),
                                BlocConsumer<AuthCubit, AuthState>(
                                  listenWhen: (previous, current) =>
                                      current is CheckIfUserExistOrNotSuccess ||
                                      current
                                          is CheckIfUserExistOrNotNotFound ||
                                      current is CheckIfUserExistOrNotError,
                                  listener: (context, state) {
                                    if (state is CheckIfUserExistOrNotSuccess) {
                                      final cubit = context.read<AuthCubit>();

                                      final email = cubit.verificationEmail;

                                      if (email == null || email.isEmpty) {
                                        AppSnackBar.showError(
                                          AppLanguageKeys.somethingWentWrong,
                                        );
                                        return;
                                      }

                                      Navigator.push(
                                        context,
                                        NavigateToPageWidget(
                                          BlocProvider.value(
                                            value: cubit,
                                            child: OtpPage(
                                              email: email,
                                              purpose:
                                                  OtpPurpose.forgotPassword,
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    if (state
                                        is CheckIfUserExistOrNotNotFound) {
                                      AppSnackBar.showError(
                                        AppLanguageKeys.userNotFound,
                                      );
                                    }

                                    if (state is CheckIfUserExistOrNotError) {
                                      AppSnackBar.showError(
                                        state.error,
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    final bool isLoading =
                                        state is CheckIfUserExistOrNotLoading;

                                    return LoginButtonWidget(
                                      text: AppLanguageKeys.send,
                                      isLoading: isLoading,
                                      onPressed: isLoading
                                          ? null
                                          : () {
                                              // ==========================================
                                              // 1. GET EMAIL
                                              // ==========================================

                                              final email =
                                                  emailController.text.trim();

                                              // ==========================================
                                              // 2. CHECK EMPTY
                                              // ==========================================

                                              if (email.isEmpty) {
                                                AppSnackBar.showError(
                                                  AppLanguageKeys
                                                      .yourEmailIsEmpty,
                                                );
                                                return;
                                              }

                                              // ==========================================
                                              // 3. CHECK GMAIL FORMAT
                                              // ==========================================

                                              final emailRegex = RegExp(
                                                r'^[a-zA-Z0-9._%+-]+@gmail\.com$',
                                              );

                                              if (!emailRegex.hasMatch(email)) {
                                                AppSnackBar.showError(
                                                  AppLanguageKeys
                                                      .pleaseEnterValidEmail,
                                                );
                                                return;
                                              }

                                              context
                                                  .read<AuthCubit>()
                                                  .checkIfUserExistOrNot(
                                                    email: email,
                                                    languageCode:
                                                        Localizations.localeOf(
                                                                context)
                                                            .languageCode,
                                                  );
                                            },
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
            if (MediaQuery.of(context).size.width > ValuesOfAllApp.mobileWidth)
              const LoginImage(),
          ],
        ),
      ),
    );
  }
}
