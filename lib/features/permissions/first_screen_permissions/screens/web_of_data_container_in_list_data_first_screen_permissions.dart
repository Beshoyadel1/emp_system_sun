import 'package:flutter/cupertino.dart';
import '../../../../../../features/permissions/custom_widget/text_with_container_as_column_widget.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../features/permissions/custom_widget/text_with_text_form_field_as_column_widget.dart';

class WebOfDataContainerInListDataFirstScreenPermissions
    extends StatelessWidget {
  const WebOfDataContainerInListDataFirstScreenPermissions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            TextWithTextFormFieldAsColumnWidget(
              text: AppLanguageKeys.accountStatus,
              hint: AppLanguageKeys.accountStatus,
              options: [AppLanguageKeys.active, AppLanguageKeys.inactive],
            ),
          ],
        ),
        Row(
          spacing: 5,
          children: [
            TextWithTextFormFieldAsColumnWidget(
              text: AppLanguageKeys.email,
              hint: AppLanguageKeys.email,
            ),
            TextWithTextFormFieldAsColumnWidget(
              text: AppLanguageKeys.phoneNumber,
              hint: AppLanguageKeys.phoneNumber,
            ),
            TextWithContainerAsColumnWidget(
              title: AppLanguageKeys.picture,
              textContainer: AppLanguageKeys.uploadPicture,
            )
          ],
        ),
      ],
    );
  }
}
