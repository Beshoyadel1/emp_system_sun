import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/list_data_first_screen_communication_and_policies_pages.dart';
import '../../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../../core/theming/colors.dart';

class FirstScreenCommunicationAndPoliciesPages extends StatelessWidget {
  const FirstScreenCommunicationAndPoliciesPages({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListDataFirstScreenCommunicationAndPoliciesPages(),
        ),
      ),
    );
  }
}
