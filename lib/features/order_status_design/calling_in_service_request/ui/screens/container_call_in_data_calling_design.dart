import 'package:flutter/cupertino.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';

class ContainerCallInDataCallingDesign extends StatelessWidget {
  final String? imagePath;
  final double? width;
  const ContainerCallInDataCallingDesign({
    super.key,
    this.width,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(10),
      width:width?? 60,
      decoration: BoxDecoration(
        color: AppColors.orangeColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.redColor.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Image.asset(imagePath??AppImageKeys.call2),
    );
  }
}
