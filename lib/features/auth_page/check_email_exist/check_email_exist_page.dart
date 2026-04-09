import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/auth_page/change_password/change_password_page.dart';
import '../../../../../core/api_functions/user/check_if_user_exist_model/check_if_user_exist_request.dart';
import '../../../../../core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import '../../../../../features/auth_page/auth_cubit/auth_cubit.dart';
import '../../../../../features/auth_page/auth_cubit/auth_state.dart';
import '../../../../../features/auth_page/login_page/login_widgets/login_button_widget.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../features/auth_page/login_page/login_widgets/login_image.dart';
import '../../../../../features/auth_page/login_page/login_widgets/user_text_field_widget.dart';


class CheckEmailExistPage extends StatefulWidget {
  const CheckEmailExistPage({super.key});
  @override
  State<CheckEmailExistPage> createState() => _CheckEmailExistPageState();
}

class _CheckEmailExistPageState extends State<CheckEmailExistPage> {
  late TextEditingController emailController ;
  late GlobalKey<FormState> checkEmailExistFormKey ;

  @override
  void initState() {
    emailController = TextEditingController();
    checkEmailExistFormKey = GlobalKey<FormState>();
    super.initState();
  }
  @override
  void dispose() {
    emailController.dispose();
    checkEmailExistFormKey.currentState?.dispose();
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
                              key: checkEmailExistFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const  TextInAppWidget(
                                    text: AppLanguageKeys.authEnterCorrectEmail,
                                    textColor: AppColors.darkColor,
                                    textSize: 20,
                                    fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                                  ),
                                  UserTextFieldWidget(type: UserFieldType.email, controller: emailController,),
                                  const SizedBox(height: 10,),
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
                                            NavigateToPageWidget(ChangePasswordPage(
                                              email: emailController.text.trim(),
                                            )),
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
                                          if (!checkEmailExistFormKey.currentState!.validate()) return;

                                          final checkIfUserExistRequest = CheckIfUserExistRequest(
                                            email: emailController.text.trim(),
                                          );
                                          context.read<AuthCubit>().checkEmailExist(checkIfUserExistRequest);
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
