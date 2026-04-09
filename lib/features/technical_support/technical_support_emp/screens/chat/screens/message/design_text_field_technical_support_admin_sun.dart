import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../../core/language/language_constant.dart';
import '../../../../../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../../../../../core/theming/colors.dart';

class DesignTextFieldTechnicalSupportAdminSun extends StatefulWidget {
  const DesignTextFieldTechnicalSupportAdminSun({super.key});

  @override
  State<DesignTextFieldTechnicalSupportAdminSun> createState() => _DesignTextFieldTechnicalSupportAdminSunState();
}

class _DesignTextFieldTechnicalSupportAdminSunState extends State<DesignTextFieldTechnicalSupportAdminSun> {
  late TextEditingController textFormFieldWidget;
  @override
  void initState() {
    textFormFieldWidget = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsGeometry.all(20),
      width: 500,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormFieldWidget(
        textFormController: textFormFieldWidget,
        fillColor: AppColors.whiteColor,
        borderColor: AppColors.greyColor.withOpacity(0.5),
        hintText:AppLanguageKeys.writeYourMessageHere,
        hintTextColor: AppColors.darkColor,
        contentPadding: EdgeInsetsGeometry.all(10),
        hintTextSize: 10,
        textSize: 15,
        textFormWidth: 500,
        enabledBorderRadius:BorderRadius.circular(10),
        focusedBorderRadius: BorderRadius.circular(10),
        suffixIcon: Icons.send,
      ),
    );
  }
}
