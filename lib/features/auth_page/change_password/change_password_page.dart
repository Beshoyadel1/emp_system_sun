import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api_functions/user/change_password_model/change_password_request.dart';
import '../../../../../core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import '../../../../../features/auth_page/auth_cubit/auth_cubit.dart';
import '../../../../../features/auth_page/auth_cubit/auth_state.dart';
import '../../../../../features/auth_page/login_page/login_page.dart';
import '../../../../../features/auth_page/login_page/login_widgets/login_button_widget.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../features/auth_page/login_page/login_widgets/login_image.dart';
import '../../../../../features/auth_page/login_page/login_widgets/user_text_field_widget.dart';


class ChangePasswordPage extends StatefulWidget {
  final String email;
  const ChangePasswordPage({super.key,required this.email});
  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late TextEditingController emailController,passwordController,confirmPasswordController ;
  late GlobalKey<FormState> formKey ;

  @override
  void initState() {
   // emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }
  @override
  void dispose() {
   // emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    formKey.currentState?.dispose();
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
                      child: AppBar(backgroundColor: AppColors.orangeColor),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Form(
                              autovalidateMode: AutovalidateMode.disabled,
                              key: formKey,
                              child: Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const  TextInAppWidget(
                                  //   text: AppLanguageKeys.email,
                                  //   textColor: AppColors.darkColor,
                                  //   textSize: 20,
                                  //   fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                                  // ),
                                  // UserTextFieldWidget(type: UserFieldType.email, controller: emailController,),
                                  const  TextInAppWidget(
                                    text: AppLanguageKeys.password,
                                    textColor: AppColors.darkColor,
                                    textSize: 20,
                                    fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                                  ),
                                  UserTextFieldWidget(type: UserFieldType.password, controller: passwordController,),
                                  const  TextInAppWidget(
                                    text: AppLanguageKeys.confirmPasswordKey,
                                    textColor: AppColors.darkColor,
                                    textSize: 20,
                                    fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                                  ),
                                  UserTextFieldWidget(type: UserFieldType.password, controller: confirmPasswordController,),
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
                                            NavigateToPageWidget(const LoginPage()),
                                          );
                                        });
                                      }

                                      if (state is AuthLoginError) {
                                        Future.microtask(() {
                                          AppSnackBar.showError(state.message);
                                        });
                                      }

                                      return LoginButtonWidget(
                                        text: AppLanguageKeys.send,
                                        isLoading: isLoading,
                                        onPressed: isLoading
                                            ? null
                                            : () {
                                          if (!formKey.currentState!.validate()) return;
                                          final password = passwordController.text.trim();
                                          final confirm = confirmPasswordController.text.trim();

                                          if (password != confirm) {
                                            AppSnackBar.showError(
                                                AppLanguageKeys.passwordsDoNotMatch);
                                            return;
                                          }
                                          final changePasswordRequest = ChangePasswordRequest(
                                            user: widget.email,
                                            password:passwordController.text.trim(),
                                          );
                                          context.read<AuthCubit>().changePassword(changePasswordRequest);
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
              if(MediaQuery.of(context).size.width > ValuesOfAllApp.mobileWidth) const LoginImage(),
            ],
          )
      ),
    );
  }
}