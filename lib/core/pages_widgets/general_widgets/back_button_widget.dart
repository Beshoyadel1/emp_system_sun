import 'package:flutter/material.dart';

import '../../pages_widgets/button_widget.dart';
import '../../theming/colors.dart';
import '../../theming/fonts.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 20, top: 20),
          child: ButtonWidget(
            text: 'Back_Button',
            fontWeightIndex: FontSelectionData.semiBoldFontFamily,
            onTap: () {
              Navigator.pop(context);
            },
            textColor: AppColors.darkColor,
            buttonColor: Colors.transparent,
            textSize: 15,
          ),
        ),
      ],
    );
  }
}
