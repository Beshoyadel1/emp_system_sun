import 'package:flutter/cupertino.dart';
import '../../../../../../features/permissions/custom_widget/text_with_container_as_column_widget.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../features/permissions/custom_widget/text_with_text_form_field_as_column_widget.dart';

class MobileOfDataContainerInListDataFirstScreenPermissions
    extends StatelessWidget {
  const MobileOfDataContainerInListDataFirstScreenPermissions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //row_
        Row(
          spacing: 5,
          children: [
            TextWithTextFormFieldAsColumnWidget(
              text: AppLanguageKeys.employeeName,
              hint: AppLanguageKeys.employeeName,
            ),
            TextWithTextFormFieldAsColumnWidget(
              text: AppLanguageKeys.jobTitle,
              hint: AppLanguageKeys.jobTitle,
            ),
          ],
        ),
        Row(
          children: [
            TextWithTextFormFieldAsColumnWidget(
              text: AppLanguageKeys.accountStatus,
              hint: AppLanguageKeys.accountStatus,
              options: [AppLanguageKeys.active, AppLanguageKeys.inactive],
            ),
          ],
        ),
        Row(
          children: [
            TextWithTextFormFieldAsColumnWidget(
              text: AppLanguageKeys.email,
              hint: AppLanguageKeys.email,
            ),
          ],
        ),
        Row(
          children: [
            TextWithTextFormFieldAsColumnWidget(
              text: AppLanguageKeys.phoneNumber,
              hint: AppLanguageKeys.phoneNumber,
            ),
          ],
        ),
        Row(
          children: [
            TextWithContainerAsColumnWidget(
              title: AppLanguageKeys.picture,
              textContainer: AppLanguageKeys.uploadPicture,
            ),
          ],
        )
      ],
    );
  }
}
