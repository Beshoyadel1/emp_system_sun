import 'package:flutter/cupertino.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/theming/assets.dart';
import '../../../../../../features/permissions/custom_widget/check_box_with_text_widget.dart';

class SelectPermissionsAndServicesProvidedToTheUserWithImage
    extends StatelessWidget {
  const SelectPermissionsAndServicesProvidedToTheUserWithImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CheckBoxWithText(
              text: AppLanguageKeys.maintenanceServices,
              imageSelect: AppImageKeys.service33,
            ),
            CheckBoxWithText(
              text: AppLanguageKeys.maintenanceServices,
              imageSelect: AppImageKeys.service44,
            )
          ],
        )
      ],
    );
  }
}
