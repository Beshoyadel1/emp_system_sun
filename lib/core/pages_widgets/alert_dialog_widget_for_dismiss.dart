import 'package:flutter/material.dart';

import '../theming/colors.dart';

class GeneralAlertDialogWidget extends StatelessWidget {
  const GeneralAlertDialogWidget({super.key, this.classWidget, this.isLogout});

  final Widget? classWidget;
  final bool? isLogout;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          isLogout == true ? AppColors.whiteColor : AppColors.defaultColor,
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.all(10),
      content: SizedBox(
        width: 700,
        height: 500,
        // padding: const EdgeInsets.only(top: 20),
        child: classWidget ?? const SizedBox(),
      ),
    );
  }
}

void showGeneralDialogWidget(
    {required BuildContext context, Widget? classWidget, bool? isLogout}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return GeneralAlertDialogWidget(
        classWidget: classWidget,
        isLogout: isLogout,
      );
    },
  );
}
