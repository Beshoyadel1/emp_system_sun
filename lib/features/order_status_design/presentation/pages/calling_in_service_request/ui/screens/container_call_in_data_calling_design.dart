import 'package:flutter/material.dart';
import '../../../../../../../core/theming/colors.dart';

class ContainerCallInDataCallingDesign extends StatelessWidget {
  final IconData? icon;
  final double? width;

  const ContainerCallInDataCallingDesign({
    super.key,
    this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: width ?? 60,
      height: width ?? 60,
      decoration: BoxDecoration(
        color: AppColors.orangeColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.redColor.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        icon ?? Icons.call,
        color: Colors.white,
        size: 19,
      ),
    );
  }
}