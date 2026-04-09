import 'package:flutter/cupertino.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../../features/permissions/custom_widget/check_box_with_text_widget.dart';

class MobileAsPartUserSelectPermissions extends StatelessWidget {
  const MobileAsPartUserSelectPermissions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Row(
          children: [
            CheckBoxWithText(text: AppLanguageKeys.statistics),
            CheckBoxWithText(text: AppLanguageKeys.servicesSettings),
          ],
        ),
        Row(
          children: [
            CheckBoxWithText(text: AppLanguageKeys.carModelSettings),
            CheckBoxWithText(text: AppLanguageKeys.accountManagement),
          ],
        ),
        Row(
          children: [
            CheckBoxWithText(text: AppLanguageKeys.permissionsManagement),
            CheckBoxWithText(text: AppLanguageKeys.organizationManagement),
          ],
        )
      ],
    );
  }
}
