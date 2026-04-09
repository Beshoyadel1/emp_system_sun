import 'package:flutter/material.dart';
import '../../../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/language/language_constant.dart';

class BankAccountContent extends StatefulWidget {
  const BankAccountContent({super.key});

  @override
  State<BankAccountContent> createState() => _BankAccountContentState();
}

class _BankAccountContentState extends State<BankAccountContent> {
  @override
  Widget build(BuildContext context) {
    bool isMobile =
        MediaQuery.of(context).size.width < ValuesOfAllApp.mobileWidth;
    return Column(
        spacing: 30,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: fields.map((fieldName) {
              return SizedBox(
                width: isMobile ? double.infinity : 280,
                child: TextFormFieldWidget(
                  textFormController: TextEditingController(),
                  text: fieldName,
                  textSize: 16,
                  isColumn: true,
                  textColor: AppColors.darkColor,
                  borderColor: AppColors.darkGreyColor,
                  //borderRadius: 20,
                  fillColor: AppColors.whiteColor,
                  textFormHeight: 35,
                ),
              );
            }).toList(),
          ),
        ]);
  }

  final List<String> fields = [
    AppLanguageKeys.bankNameKey,
    AppLanguageKeys.beneficiaryNameKey,
    AppLanguageKeys.bankAccountNumberKey,
    AppLanguageKeys.swiftCodeKey,
    AppLanguageKeys.ibanNumberKey,
  ];
}
