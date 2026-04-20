import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/auth_page/auth_cubit/auth_state.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../core/language/language.dart';
import '../../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../features/auth_page/auth_cubit/auth_cubit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/countries.dart';


enum UserFieldType {
  normal,
  email,
  phone,
  name,
  password,
}

class UserTextFieldWidget extends StatelessWidget {
  const UserTextFieldWidget({
    super.key,
    required this.controller,
    this.text,
    this.type = UserFieldType.normal,
    this.borderRadius,
    this.readOnly,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String? text;
  final UserFieldType type;
  final BorderRadius? borderRadius;
  final bool? readOnly;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    if (type == UserFieldType.phone) {
      return SizedBox(
        width: isMobile ? double.infinity : 500,
        child: PhoneTextField(
          controller: controller,
          aboveText: text,
          borderRadius: 10,
          validator: context.read<AuthCubit>().phoneValidator,
        ),
      );
    }

    return SizedBox(
      width: isMobile ? double.infinity : 500,
      child: BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (previous, current) =>
        current is AuthPasswordVisibilityChanged,
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();

          final bool isPasswordField =
              type == UserFieldType.password;

          return TextFormFieldWidget(
            textFormController: controller,
            text: text ?? '',
            isColumn: true,
            readOnly: readOnly,
            maxLines: isPasswordField ? 1 : maxLines,
            validator: _getValidator(cubit),
            inputFormatters: _getFormatters(),
            textSize: isMobile ? 14 : 16,
            fontWeightIndex:
            FontSelectionData.semiBoldFontFamily,
            borderColor: AppColors.lightGreyColor,
            fillColor: AppColors.whiteColor,
            enabledBorderRadius:
            borderRadius ??
                const BorderRadius.all(Radius.circular(10)),

            obscureText: isPasswordField
                ? !cubit.isPasswordVisible
                : false,

            suffixIcon: isPasswordField
                ? (cubit.isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off
            )
                : null,

            suffixOnPressed: isPasswordField
                ? () {
              cubit.togglePasswordVisibility();
            }
                : null,
          );
        },
      ),
    );
  }

  FormFieldValidator<String>? _getValidator(AuthCubit cubit) {
    switch (type) {
      case UserFieldType.email:
        return cubit.emailValidator;

      case UserFieldType.name:
        return cubit.nameValidator;

      case UserFieldType.password:
        return cubit.passwordValidator;

      default:
        return null;
    }
  }

  List<TextInputFormatter>? _getFormatters() {
    if (type == UserFieldType.email) {
      return [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ];
    }
    return null;
  }
}


class PhoneTextField extends StatefulWidget {
  const PhoneTextField({
    super.key,
    required this.controller,
    this.validator,
    this.aboveText,
    this.isReadOnly = false,
    this.borderRadius,
  });

  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String? aboveText;
  final bool isReadOnly;
  final double? borderRadius;

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  String initialCountry = 'SA';
  String initialNumber = '';

  @override
  void initState() {
    super.initState();
    final parsed = parsePhoneNumber(widget.controller.text);
    initialCountry = parsed['countryCode']!;
    initialNumber = parsed['number']!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.aboveText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: TextInAppWidget(
              text: widget.aboveText!,
              textSize: 14,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              //textColor: AppColors.darkColor,
            ),
          ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: IntlPhoneField(
            initialCountryCode: initialCountry,
            initialValue: initialNumber,
            readOnly: widget.isReadOnly,
            keyboardType: TextInputType.number,
            languageCode: Localizations.localeOf(context).languageCode,

            invalidNumberMessage:
            AppLocalizations.of(context)
                .translate(AppLanguageKeys.authEnterCorrectPhoneNumber),

            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],

            validator: (phone) {
              final local = AppLocalizations.of(context);

              if (phone == null || phone.number.isEmpty) {
                return local.translate(
                    AppLanguageKeys.authPhoneNumberRequired);
              }

              return null;
            },

            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.whiteColor,
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(widget.borderRadius ?? 12),
              ),
            ),

            onChanged: (phone) {

              widget.controller.text = removePlusFromPhone(phone.completeNumber);
            },
          ),


        )
      ],
    );
  }
  String removePlusFromPhone(String phone) {
    if (phone.startsWith('+')) {
      return phone.substring(1);
    } else {
      return phone;
    }
  }

  Map<String, String> parsePhoneNumber(String phone) {
    if (phone.trim().isEmpty) {
      return {'countryCode': 'SA', 'number': ''};
    }

    String normalized = phone.trim();
    if (!normalized.startsWith('+')) {
      normalized = '+$normalized';
    }

    for (final country in countries) {
      final dialCode = '+${country.dialCode}';
      if (normalized.startsWith(dialCode)) {
        return {
          'countryCode': country.code,
          'number': normalized.substring(dialCode.length),
        };
      }
    }

    return {
      'countryCode': 'SA',
      'number': normalized.replaceAll('+', ''),
    };
  }
}
