import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../features/accounts_management/details_accounts_management_admin_sun/screens/container_details_accounts_management_admin_sun.dart';
import '../../../../../core/theming/colors.dart';


class DetailsAccountsManagementAdminSun extends StatelessWidget {
  const DetailsAccountsManagementAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                    child: ContainerDetailsAccountsManagementAdminSun()
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
