import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/auth_page/auth_cubit/auth_cubit.dart';
import '../../.././features/auth_page/auth_cubit/auth_state.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/fonts.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/language/language_constant.dart';

class OtpPage extends StatefulWidget {
  final String email;
  const OtpPage({super.key,required this.email});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> controllers =
  List.generate(4, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
  List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().generateOtp();
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String getOtp() {
    return controllers.map((e) => e.text).join();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthCubit>();
    final isError = cubit.isOtpError;

    return Scaffold(
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

              const TextInAppWidget(
                text: AppLanguageKeys.forgotPasswordKey,
                textSize: 22,
                fontWeightIndex: FontSelectionData.boldFontFamily,
              ),

              const SizedBox(height: 10),

              const TextInAppWidget(
                text: AppLanguageKeys.enterOtp,
                textSize: 14,
                fontWeightIndex: FontSelectionData.regularFontFamily,
                textColor: AppColors.greyColor,
              ),

              const SizedBox(height: 25),

              /// OTP Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 65,
                    height: 65,
                    child: TextField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      keyboardType: TextInputType.number,
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
                          borderSide: BorderSide(
                            color: isError
                                ? AppColors.redColor
                                : AppColors.transparent,
                            width: 2,
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: isError
                                ? AppColors.redColor
                                : AppColors.greyColor200,
                            width: 2,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: isError
                                ? AppColors.redColor
                                : AppColors.orangeColor,
                            width: 2,
                          ),
                        ),
                      ),

                      onChanged: (value) {
                        final cubit = context.read<AuthCubit>();

                        cubit.resetOtpError();

                        if (value.isNotEmpty) {
                          if (index < 3) {
                            focusNodes[index + 1].requestFocus();
                          } else {
                            focusNodes[index].unfocus();
                            Future.delayed(
                                const Duration(milliseconds: 100), () {
                              final code = getOtp();

                              if (code.length == 4) {
                                cubit.validateOtp(code, context, widget.email);
                              }
                            });
                          }
                        } else {
                          if (index > 0) {
                            focusNodes[index - 1].requestFocus();
                          }
                        }
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 25),

              BlocBuilder<AuthCubit, AuthState>(
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

              /// Verify Button (optional backup)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orangeColor,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    final code = getOtp();
                    final cubit = context.read<AuthCubit>();

                    if (code.length != 4) {
                      cubit.isOtpError = true;
                      return;
                    }

                    cubit.validateOtp(code, context,widget.email);
                  },
                  child: const TextInAppWidget(
                    text: AppLanguageKeys.verify,
                    textSize: 14,
                    fontWeightIndex: FontSelectionData.regularFontFamily,
                    textColor: AppColors.whiteColor,
                  ),
                ),
              ),

              const SizedBox(height: 15),


              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final cubit = context.read<AuthCubit>();

                  if (cubit.secondsRemaining == 0) {
                    return TextButton(
                      onPressed: () {
                        cubit.resendOtp();
                      },
                      child: const TextInAppWidget(
                        text: AppLanguageKeys.resend,
                        textSize: 14,
                        fontWeightIndex: FontSelectionData.boldFontFamily,
                        textColor: AppColors.blackColor,
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}