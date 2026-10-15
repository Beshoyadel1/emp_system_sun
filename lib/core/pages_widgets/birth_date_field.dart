import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../language/language.dart';
import '../language/language_constant.dart';
import '../theming/colors.dart';
import '../theming/fonts.dart';
import 'text_form_field_widget.dart';

class BirthDateField extends StatefulWidget {
  const BirthDateField({
    super.key,
    required this.value,
    required this.onChanged,
    this.readOnly = false,
    this.width,
  });

  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final bool readOnly;
  final double? width;

  @override
  State<BirthDateField> createState() => _BirthDateFieldState();
}

class _BirthDateFieldState extends State<BirthDateField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateText();
  }

  @override
  void didUpdateWidget(covariant BirthDateField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateText();
  }

  void _updateText() {
    _controller.text = widget.value == null
        ? ''
        : DateFormat('yyyy-MM-dd').format(widget.value!);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickBirthDate() async {
    if (widget.readOnly) return;
    final today = DateUtils.dateOnly(DateTime.now());
    final firstDate = DateTime(1900);
    final value = widget.value;
    final initialDate = value == null
        ? null
        : value.isBefore(firstDate)
            ? firstDate
            : value.isAfter(today)
                ? today
                : DateUtils.dateOnly(value);
    final l10n = AppLocalizations.of(context);
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: today,
      initialDatePickerMode: DatePickerMode.year,
      helpText: l10n.translate(AppLanguageKeys.birthDate),
      cancelText: l10n.translate(AppLanguageKeys.cancel),
      confirmText: l10n.translate(AppLanguageKeys.confirm),
      builder: (context, child) {
        final theme = Theme.of(context);
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: AppColors.orangeColor,
              onPrimary: AppColors.whiteColor,
              secondary: AppColors.seaBlueColor,
              surface: AppColors.whiteColor,
              onSurface: AppColors.darkColor,
            ),
            textTheme: theme.textTheme.apply(
              fontFamily: AppFonts.readexProFontFamily,
            ),
            datePickerTheme: theme.datePickerTheme.copyWith(
              backgroundColor: AppColors.whiteColor,
              headerBackgroundColor: AppColors.orangeColor,
              headerForegroundColor: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (!mounted || widget.readOnly || picked == null) return;
    widget.onChanged(DateUtils.dateOnly(picked));
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    return SizedBox(
      width: widget.width ?? (isMobile ? double.infinity : 500),
      child: TextFormFieldWidget(
        textFormController: _controller,
        text: AppLanguageKeys.birthDate,
        hintText: AppLanguageKeys.selectDate,
        isColumn: true,
        readOnly: true,
        isDatePicker: true,
        onPressedDate: widget.readOnly ? null : _pickBirthDate,
        suffixIcon: Icons.calendar_month_outlined,
        suffixOnPressed: widget.readOnly ? null : _pickBirthDate,
        textSize: 16,
        textFormHeight: 35,
        borderColor: AppColors.darkGreyColor,
        focusBorderColor: AppColors.orangeColor,
        fillColor: AppColors.whiteColor,
      ),
    );
  }
}
