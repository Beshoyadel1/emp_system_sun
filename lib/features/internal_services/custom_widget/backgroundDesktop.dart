import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';

class backgroundDesktop extends StatelessWidget {
  final int? flexNumber;
  final String? imagePath;
  final Color? color;

  const backgroundDesktop(
      {super.key, this.flexNumber = 1, this.imagePath, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? AppColors.orangeColor,
      child: Image.asset(
        imagePath ?? AppImageKeys.sun_logo,
        height: double.infinity,
        width: 250,
      ),
    );
  }
}
