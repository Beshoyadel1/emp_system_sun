import 'package:flutter/cupertino.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/text_styles.dart';

class TextEmptyViewData extends StatelessWidget {
  final String? text;
  final double? textSize;
  const TextEmptyViewData({super.key,this.textSize,this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:  TextInAppWidget(
        text: text??AppLanguageKeys.empty,
        textSize:textSize?? 15,
        textColor: AppColors.greyColor,
      ),
    );
  }
}
