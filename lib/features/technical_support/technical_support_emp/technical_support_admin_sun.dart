import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../features/technical_support/technical_support_emp/screens/chat/chat_in_technical_support_emp_admin_sun.dart';
import '../../../../../../features/technical_support/technical_support_emp/screens/list_data_technical_support_admin_sun.dart';
import '../../../../../../features/technical_support/technical_support_emp/screens/team_work/container_design_team_work_admin_sun.dart';
import '../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/language/language_constant.dart';

class TechnicalSupportAdminSun extends StatelessWidget {
  const TechnicalSupportAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;
    bool isTabletCustom = size.width > ValuesOfAllApp.mobileWidth &&
        size.width <= ValuesOfAllApp.customTabWidth;

    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: CustomContainer(
                isSelected: false,
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                typeWidget: const Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 350,
                      //height: 600,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: ListDataTechnicalSupportAdminSun(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      height: 600,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ChatInTechnicalSupportEmpAdminSun(),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                     // height: 600,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                            child: ContainerDesignTeamWorkAdminSun()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ));
  }
}