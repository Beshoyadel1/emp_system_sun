import 'package:flutter/material.dart';
import '../../../../../core/theming/colors.dart';

class SmallCircle extends StatelessWidget {
  final double size;
  final Color? color;

  const SmallCircle(
      {super.key, this.size = 12, this.color = AppColors.redColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
