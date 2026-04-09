import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../features/permissions/first_screen_permissions/screens/list_data_first_screen_permissions.dart';
import '../../../../../../core/utilies/map_of_all_app.dart';

class FirstScreenPermissions extends StatelessWidget {
  const FirstScreenPermissions({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;
    bool isTabletCustom = size.width > ValuesOfAllApp.mobileWidth &&
        size.width <= ValuesOfAllApp.customTabWidth;
    bool isTab = size.width > ValuesOfAllApp.tabWidth;

    return const SingleChildScrollView(child: ListDataFirstScreenPermissions());
  }
}
