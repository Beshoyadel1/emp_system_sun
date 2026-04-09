import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../language/language.dart';
import '../language/language_cubit/language_cubit.dart';
import '../setup_git_it.dart';
import '../theming/colors.dart';
import '../theming/fonts.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    required this.textFormController,
    this.textFormWidth,
    this.text,
    this.isValidator,
    this.validator,
    this.enabled,
    this.suffixOnPressed,
    this.suffixIcon,
    this.textWidth,
    this.textSize,
    this.onChanged,
    this.isDatePicker,
    this.onPressedDate,
    this.readOnly,
    this.isDigit,
    this.isDigitDot,
    this.onEditingComplete,
    this.textHeight,
    this.textFormHeight,
    this.fontWeightIndex,
    this.hintText,
    this.textAlign,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIconSize,
    this.prefixIconSize,
    this.prefixOnPressed,
    this.fillColor,
    this.borderColor,
    this.textColor,
    this.contentTextColor,
    this.focusBorderColor,
    this.maxLength,
    this.selectionColor,
    this.focusNode,
    this.nextFocusNode,
    this.maxLines,
    this.inputFormatters,
    this.isColumn,
    this.hintTextColor,
    this.isSpaceAfterText,
    this.obscureText,
    this.enabledBorderRadius,
    this.focusedBorderRadius,
    this.hintTextSize,
    this.prefixIconWidth,
    this.prefixIconHeight,
  });

  final TextEditingController textFormController;
  final FormFieldValidator<String>? validator;

  final String? text;
  final bool? isValidator;
  final bool? enabled;
  final bool? isDigit;
  final bool? isDigitDot;
  final bool? readOnly;
  final void Function()? suffixOnPressed;
  final void Function()? prefixOnPressed;
  final void Function()? onPressedDate;
  final IconData? suffixIcon;
  final double? suffixIconSize;
  final String? prefixIcon;
  final double? prefixIconSize;
  final bool? isDatePicker;
  final double? textWidth;
  final double? textHeight;
  final double? textFormHeight;
  final double? textFormWidth;
  final double? textSize;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final int? fontWeightIndex;
  final String? hintText;
  final Color? hintTextColor;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? textColor;
  final Color? contentTextColor;
  final int? maxLength;
  final Color? selectionColor;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isColumn;
  final bool? isSpaceAfterText;
  final bool? obscureText;
  final BorderRadius? enabledBorderRadius;
  final BorderRadius? focusedBorderRadius;
  final double? hintTextSize;
  final double? prefixIconWidth;
  final double? prefixIconHeight;

  @override
  State<TextFormFieldWidget> createState() =>
      _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  final FocusNode internalFocusNode = FocusNode();
  final LanguageCubit _languageCubit = getIt<LanguageCubit>();

  @override
  void dispose() {
    internalFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.greenColor,
          selectionColor: widget.selectionColor ??
              AppColors.defaultColor.withValues(alpha: 0.4),
        ),
      ),
      child: widget.isColumn == true
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.text != null) widgetText(),
          widgetTextFormField(),
        ],
      )
          : Row(
        children: [
          if (widget.text != null) widgetText(),
          Expanded(child: widgetTextFormField()),
        ],
      ),
    );
  }

  Widget widgetText() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        AppLocalizations.of(context).translate(widget.text ?? ''),
        style: TextStyle(
          fontSize: widget.textSize ??
              (_languageCubit.isAllAppLanguageArabic
                  ? size.width * 0.05
                  : size.width * 0.045),
          fontWeight:
          fontWeightSelection(fontWeightIndex: widget.fontWeightIndex),
          fontFamily: fontSelection(),
          color: widget.textColor ?? AppColors.darkColor,
        ),
      ),
    );
  }

  Widget widgetTextFormField() {
    return SizedBox(
      width: widget.textFormWidth,
      height: widget.textFormHeight,
      child: TextFormField(
        controller: widget.textFormController,
        focusNode: widget.focusNode ?? internalFocusNode,
        readOnly: widget.readOnly ?? false,
        maxLines: widget.maxLines ?? 1,
        obscureText: widget.obscureText ?? false,
        enabled: widget.enabled ?? true,
        maxLength: widget.maxLength,
        textAlign: widget.textAlign ?? TextAlign.start,

        inputFormatters: widget.inputFormatters ??
            [
              if (widget.isDigit == true)
                FilteringTextInputFormatter.allow(RegExp('[0-9]'))
              else if (widget.isDigitDot == true)
                FilteringTextInputFormatter.allow(
                    RegExp(r'^[0-9]+\.?\d{0,4}')),
            ],

        validator: (value) {
          if (widget.validator != null) {
            final result = widget.validator!(value);

            if (result == null) return null;

            return AppLocalizations.of(context).translate(result);
          }

          if (widget.isValidator == true) {
            if (value == null || value.trim().isEmpty) {
              return AppLocalizations.of(context)
                  .translate('this Field Required');
            }
          }

          return null;
        },


        style: TextStyle(
          fontSize: widget.textSize ?? 16,
          fontWeight:
          fontWeightSelection(fontWeightIndex: widget.fontWeightIndex),
          fontFamily: fontSelection(),
          color: widget.contentTextColor ?? AppColors.darkColor,
        ),

        decoration: InputDecoration(
          counterText: widget.maxLength != null ? '' : null,

          errorStyle: const TextStyle(
            fontSize: 12,
            color: AppColors.redColor,
          ),

          filled: true,
          fillColor: widget.fillColor ?? AppColors.greyColor,
          contentPadding:
          widget.contentPadding ?? const EdgeInsets.all(12),

          enabledBorder: OutlineInputBorder(
            borderRadius:
            widget.enabledBorderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.greyColor),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius:
            widget.focusedBorderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide(
              color: widget.focusBorderColor ??
                  widget.borderColor ??
                  AppColors.greenColor,
              width: 1.5,
            ),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
            const BorderSide(color: AppColors.redColor, width: 1.5),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
            const BorderSide(color: AppColors.redColor, width: 1.5),
          ),
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
            icon: Icon(
              widget.suffixIcon,
              size: widget.suffixIconSize ?? 22,
              color: widget.contentTextColor ?? AppColors.darkColor,
            ),
            onPressed: widget.suffixOnPressed,
          )
              : null,

          hintText: AppLocalizations.of(context)
              .translate(widget.hintText ?? ''),
          hintStyle: TextStyle(
            fontSize: widget.hintTextSize ?? 14,
            color: widget.hintTextColor ??
                AppColors.darkColor.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}
