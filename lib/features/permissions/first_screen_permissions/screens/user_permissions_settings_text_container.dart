import 'package:flutter/cupertino.dart';
import '../../../../../../core/theming/assets.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/theming/text_styles.dart';

class UserPermissionsSettingsTextContainer extends StatelessWidget {
  const UserPermissionsSettingsTextContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 10,
          children: [
            Container(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.blackColor44,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkColor.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Image.asset(AppImageKeys.userPermissions),
            ),
            Expanded(
              child: TextInAppWidget(
                text: AppLanguageKeys.userPermissions,
                textSize: 16,
                fontWeightIndex: FontSelectionData.mediumFontFamily,
                textColor: AppColors.blackColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
