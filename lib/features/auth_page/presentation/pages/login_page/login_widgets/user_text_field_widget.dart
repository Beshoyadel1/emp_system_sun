import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../features/auth_page/presentation/bloc/auth_cubit/auth_cubit.dart';
import '../../../../../../features/auth_page/presentation/bloc/auth_cubit/auth_state.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../../core/theming/colors.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


enum UserFieldType {
  normal,
  email,
  phone,
  name,
  password,
  gender,
  number,
}

class UserTextFieldWidget extends StatelessWidget {
  const UserTextFieldWidget({
    super.key,
    required this.controller,
    this.text,
    this.type = UserFieldType.normal,
    this.readOnly = false,
    this.width
  });

  final TextEditingController controller;
  final String? text;
  final UserFieldType type;
  final bool readOnly;
  final double? width;
  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    Widget child;

    if (type == UserFieldType.phone) {
      if (readOnly) {
        child = TextFormFieldWidget(
          textFormController: controller,
          text: text ?? "",
          isColumn: true,
          readOnly: true,
          textSize: 16,
          borderColor: AppColors.darkGreyColor,
          fillColor: AppColors.whiteColor,
          textFormHeight: 35,
        );
      } else {
        child = PhoneTextField(
          controller: controller,
          aboveText: text,
        );
      }
    }

    else if (type == UserFieldType.gender) {
      child = GenderField(
        controller: controller,
        text: text,
        readOnly: readOnly,
      );
    }
    else if (type == UserFieldType.password) {
      child = BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();

          final isConfirm = text == AppLanguageKeys.confirmPasswordKey;

          final isVisible = isConfirm
              ? cubit.isConfirmPasswordVisible
              : cubit.isPasswordVisible;

          return TextFormFieldWidget(
            textFormController: controller,
            text: text ?? "",
            isColumn: true,
            readOnly: readOnly,
            textSize: 16,
            borderColor: AppColors.darkGreyColor,
            fillColor: AppColors.whiteColor,
            textFormHeight: 35,
            obscureText: !isVisible,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLanguageKeys.enterYourData;
              }
              return null;
            },

            suffixIcon: isVisible
                ? Icons.visibility
                : Icons.visibility_off,

            suffixOnPressed: () {
              if (isConfirm) {
                cubit.toggleConfirmPasswordVisibility();
              } else {
                cubit.togglePasswordVisibility();
              }
            },
          );
        },
      );
    }
    else {
      child = TextFormFieldWidget(
        textFormController: controller,
        text: text ?? "",
        isColumn: true,
        readOnly: readOnly,
        textSize: 16,
        borderColor: AppColors.darkGreyColor,
        fillColor: AppColors.whiteColor,
        textFormHeight: 35,

        isDigit: type == UserFieldType.number,

        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return AppLanguageKeys.enterYourData;
          }

          if (type == UserFieldType.email) {
            final emailRegex = RegExp(
              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
            );

            if (!emailRegex.hasMatch(value.trim())) {
              return "invalid_email";
            }
          }

          if (type == UserFieldType.number) {
            if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
              return "invalid_number";
            }
          }

          return null;
        },
      );
    }

    return SizedBox(
      width:width ?? (isMobile ? double.infinity : 500),
      child: child,
    );
  }
}

class GenderField extends StatefulWidget {
  final TextEditingController controller;
  final String? text;
  final bool readOnly;

  const GenderField({
    super.key,
    required this.controller,
    this.text,
    required this.readOnly,
  });

  @override
  State<GenderField> createState() => _GenderFieldState();
}

class _GenderFieldState extends State<GenderField> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    _setValue();
  }

  @override
  void didUpdateWidget(covariant GenderField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setValue();
  }

  void _setValue() {
    if (widget.controller.text == "0") {
      selectedValue = "0";
    } else if (widget.controller.text == "1") {
      selectedValue = "1";
    } else {
      selectedValue = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.text != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: TextInAppWidget(
              text: widget.text!,
              textSize: 14,
            ),
          ),

        Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.darkGreyColor),
          ),

          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              isExpanded: true,
              hint: const TextInAppWidget(
                text: AppLanguageKeys.selectGender,
                textSize: 14,
              ),
              items: const [
                DropdownMenuItem(
                  value: "0",
                  child: TextInAppWidget(
                    text: AppLanguageKeys.male,
                    textSize: 14,
                  ),
                ),
                DropdownMenuItem(
                  value: "1",
                  child: TextInAppWidget(
                    text: AppLanguageKeys.female,
                    textSize: 14,
                  ),
                ),
              ],
              onChanged: widget.readOnly
                  ? null
                  : (value) {
                setState(() {
                  selectedValue = value;
                  widget.controller.text = value ?? "";
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}


class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    super.key,
    required this.controller,
    this.aboveText,
    this.isReadOnly = false,
  });

  final TextEditingController controller;
  final String? aboveText;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (aboveText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: TextInAppWidget(
              text: aboveText!,
              textSize: 14,
            ),
          ),

        SizedBox(
          height: 60,
          child: IntlPhoneField(
            initialCountryCode: 'SA',
            disableLengthCheck: false,
            readOnly: isReadOnly,
            keyboardType: TextInputType.number,

            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],

            style: const TextStyle(fontSize: 14, height: 1.2),
            dropdownTextStyle: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.whiteColor,

              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.darkGreyColor),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.darkGreyColor),
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            flagsButtonPadding: const EdgeInsets.only(left: 6, right: 4),
            dropdownIconPosition: IconPosition.trailing,

            dropdownIcon: const Icon(Icons.arrow_drop_down, size: 18),

            onChanged: isReadOnly
                ? null
                : (phone) {
              controller.text =
                  phone.completeNumber.replaceFirst("+", "");
            },
          ),
        ),
      ],
    );
  }
}