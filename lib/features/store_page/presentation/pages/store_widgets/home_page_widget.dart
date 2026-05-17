import 'package:flutter/material.dart';
import '../../../../../core/theming/colors.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.scaffoldColor),
          ),
          // child: const ClassOfWrapData()
        ),
      ],
    );
  }
}
