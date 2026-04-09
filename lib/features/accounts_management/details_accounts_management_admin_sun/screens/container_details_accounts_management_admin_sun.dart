import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../features/accounts_management/details_accounts_management_admin_sun/screens/list_data_details_accounts_management_admin_sun.dart';
import '../../../../../../core/theming/colors.dart';

class ContainerDetailsAccountsManagementAdminSun extends StatelessWidget {
  const ContainerDetailsAccountsManagementAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsGeometry.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius:const  BorderRadius.all(Radius.circular(20)),
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
      child: const ListDataDetailsAccountsManagementAdminSun(),
    );
  }
}