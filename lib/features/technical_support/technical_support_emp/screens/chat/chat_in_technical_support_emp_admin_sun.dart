import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../features/technical_support/technical_support_emp/screens/chat/screens/message/chat_list_design_in_technical_support_admin_sun.dart';
import '../../../../../../features/technical_support/technical_support_emp/screens/chat/screens/message/design_text_field_technical_support_admin_sun.dart';
import '../../../../../../../core/theming/colors.dart';

class ChatInTechnicalSupportEmpAdminSun  extends StatelessWidget {
  const ChatInTechnicalSupportEmpAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(
            color: AppColors.greyColor.withOpacity(0.3)
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Column(
        children: [
          ChatListDesignInTechnicalSupportAdminSun(),
          DesignTextFieldTechnicalSupportAdminSun(),
        ],
      ),
    );
  }
}
