import 'package:flutter/cupertino.dart';
import '../../../../../../../features/order_status_design/calling_in_service_request/ui/screens/data_calling_design.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class ListDataCallingInServiceRequest extends StatelessWidget {
  const ListDataCallingInServiceRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(AppImageKeys.person101,width: 80,),
        const TextInAppWidget(
          text: 'مندوب الصيانة',
          textSize: 18,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor: AppColors.darkColor,
        ),
        const SizedBox(height: 20,),
        const DataCallingDesign()
      ],
    );
  }
}
