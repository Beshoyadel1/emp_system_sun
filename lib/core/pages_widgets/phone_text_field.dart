import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../language/language.dart';
import '../language/language_constant.dart';
import '../theming/colors.dart';

/// Displays a national number and keeps the API controller in international
/// digits (without '+'), matching the existing create/update user requests.
class PhoneTextField extends StatefulWidget {
  const PhoneTextField({
    super.key,
    required this.controller,
    this.aboveText,
    this.hintText,
    this.isReadOnly = false,
    this.isRequired = true,
    this.onChanged,
    this.width,
    this.fillColor = AppColors.whiteColor,
    this.borderColor = AppColors.darkGreyColor,
    this.textSize = 14,
    this.borderRadius = 10,
  });

  final TextEditingController controller;
  final String? aboveText;
  final String? hintText;
  final bool isReadOnly;
  final bool isRequired;
  final ValueChanged<String>? onChanged;
  final double? width;
  final Color fillColor;
  final Color borderColor;
  final double textSize;
  final double borderRadius;

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  final _nationalController = TextEditingController();
  final _requiredKey = GlobalKey<FormFieldState<String>>();
  Country _country = countries.firstWhere((country) => country.code == 'SA');
  int _revision = 0;
  bool _writing = false;
  String? _languageCode;

  @override
  void initState() {
    super.initState();
    _readController();
    widget.controller.addListener(_controllerChanged);
  }

  @override
  void didUpdateWidget(covariant PhoneTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_controllerChanged);
      widget.controller.addListener(_controllerChanged);
      _readController();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final code = Localizations.localeOf(context).languageCode;
    if (_languageCode != null && _languageCode != code) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _requiredKey.currentState?.hasError == true) {
          _requiredKey.currentState!.validate();
        }
      });
    }
    _languageCode = code;
  }

  void _readController() {
    final raw = widget.controller.text.trim();
    var number = raw.replaceAll(RegExp(r'\D'), '');
    _country = countries.firstWhere((country) => country.code == 'SA');
    if (number.startsWith('00')) number = number.substring(2);
    final international = raw.startsWith('+') || raw.startsWith('00');
    final candidates = countries.where((country) {
      final code = country.fullCountryCode;
      final nationalLength = number.length - code.length;
      return number.startsWith(code) &&
          (international || nationalLength >= country.minLength) &&
          nationalLength <= country.maxLength;
    }).toList()
      ..sort((a, b) =>
          b.fullCountryCode.length.compareTo(a.fullCountryCode.length));
    if (candidates.isNotEmpty) {
      _country = candidates.first;
      number = number.substring(_country.fullCountryCode.length);
    } else if (number.length == 10 && number.startsWith('05')) {
      number = number.substring(1);
    }
    _nationalController.text = number;
    _revision++;
  }

  void _controllerChanged() {
    if (_writing) return;
    setState(_readController);
  }

  void _saveNumber() {
    final national = _nationalController.text;
    final value =
        national.isEmpty ? '' : '${_country.fullCountryCode}$national';
    _writing = true;
    widget.controller.text = value;
    _writing = false;
    _requiredKey.currentState?.didChange(value);
    widget.onChanged?.call(value);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_controllerChanged);
    _nationalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(color: widget.borderColor),
    );
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.aboveText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(l10n.translate(widget.aboveText!),
                  style: TextStyle(fontSize: widget.textSize)),
            ),
          FormField<String>(
            key: _requiredKey,
            initialValue: widget.controller.text,
            validator: (_) => !widget.isReadOnly &&
                    widget.isRequired &&
                    _nationalController.text.isEmpty
                ? l10n.translate(AppLanguageKeys.authPhoneNumberRequired)
                : null,
            builder: (field) => Directionality(
              textDirection: TextDirection.ltr,
              child: IntlPhoneField(
                key: ValueKey(_revision),
                controller: _nationalController,
                initialCountryCode: _country.code,
                disableLengthCheck: false,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                enabled: !widget.isReadOnly,
                readOnly: widget.isReadOnly,
                keyboardType: TextInputType.phone,
                languageCode: _languageCode ?? 'ar',
                searchText: l10n.translate(AppLanguageKeys.searchCountry),
                invalidNumberMessage:
                    l10n.translate(AppLanguageKeys.invalidPhoneNumber),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: TextStyle(fontSize: widget.textSize),
                dropdownTextStyle: TextStyle(fontSize: widget.textSize),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: widget.fillColor,
                  isDense: true,
                  counterText: '',
                  errorText: field.errorText,
                  hintText: widget.hintText == null
                      ? null
                      : l10n.translate(widget.hintText!),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: border,
                  enabledBorder: border,
                  disabledBorder: border,
                  focusedBorder: border,
                ),
                flagsButtonPadding: const EdgeInsets.only(left: 6, right: 4),
                dropdownIconPosition: IconPosition.trailing,
                dropdownIcon: const Icon(Icons.arrow_drop_down, size: 18),
                onChanged: (_) => _saveNumber(),
                onCountryChanged: (country) {
                  _country = country;
                  _saveNumber();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
