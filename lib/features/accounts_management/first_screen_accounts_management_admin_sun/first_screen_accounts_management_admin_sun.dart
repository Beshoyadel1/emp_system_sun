import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../features/accounts_management/first_screen_accounts_management_admin_sun/screens/container_first_screen_accounts_management_admin_sun.dart';
import '../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../core/theming/colors.dart';


class FirstScreenAccountsManagementAdminSun extends StatelessWidget {
  const FirstScreenAccountsManagementAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;
    bool isTabletCustom = size.width > ValuesOfAllApp.mobileWidth && size.width <= ValuesOfAllApp.customTabWidth;
    bool isTab = size.width > ValuesOfAllApp.tabWidth;

    return const Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                    child: ContainerFirstScreenAccountsManagementAdminSun()
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
