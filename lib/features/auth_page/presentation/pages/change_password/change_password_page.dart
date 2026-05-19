import 'package:emp_system_sun/features/auth_page/data/request/change_password_request/change_password_request.dart';
import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_state.dart';
import 'package:emp_system_sun/features/auth_page/presentation/pages/login_page/login_widgets/login_button_widget.dart';
import 'package:emp_system_sun/features/auth_page/presentation/pages/login_page/login_widgets/login_image.dart';
import 'package:emp_system_sun/features/auth_page/presentation/pages/login_page/login_widgets/user_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/utilies/map_of_all_app.dart';



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
                      child: AppBar(backgroundColor: AppColors.seaBlueColor),
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
                                  BlocListener<AuthCubit, AuthState>(
                                    listener: (context, state) {
                                      if (state is AuthChangePasswordSuccess) {
                                        Navigator.pop(context);
                                        AppSnackBar.showSuccess(AppLanguageKeys.success);
                                      }

                                      if (state is AuthLoginError) {
                                        AppSnackBar.showError(state.message);
                                      }
                                    },
                                    child: BlocBuilder<AuthCubit, AuthState>(
                                      builder: (context, state) {
                                        final isLoading = state is AuthLoginLoading;
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