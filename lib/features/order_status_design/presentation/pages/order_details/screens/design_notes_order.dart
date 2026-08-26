import 'package:flutter/cupertino.dart';
import '../../../../../../../../core/language/language_constant.dart';
import '../../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../core/theming/fonts.dart';
import '../../../../../../../../core/theming/text_styles.dart';

class DesignNotesOrder extends StatelessWidget {
  final String note;
  const DesignNotesOrder({super.key,required this.note});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {},
      isSelected: true,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppColors.orangeColor.withOpacity(0.4)),
      typeWidget:Column(
        spacing: 10,
        children: [
          const TextInAppWidget(
            text:AppLanguageKeys.notes,
            textSize: 15,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor: AppColors.blackColor,
          ),
          TextFormFieldWidget(
            textFormController:TextEditingController(
              text:note
            ),
            maxLines: 9,
            fillColor: WidgetStateColor.transparent,
            borderColor: AppColors.greyColor.withOpacity(0.5),
            readOnly: true,
          )
        ],
      ),
    );
  }
}