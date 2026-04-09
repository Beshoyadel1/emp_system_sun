import 'package:flutter/cupertino.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';

class RowMuteSoundDataCallingDesign extends StatelessWidget {
  const RowMuteSoundDataCallingDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 40,
          padding: EdgeInsetsGeometry.all(10),
          decoration: BoxDecoration(
            color: AppColors.whiteColorF4,
            shape: BoxShape.circle,
          ),
          child: Image.asset(AppImageKeys.sound),
        ),
        Container(
          width: 40,
          padding: EdgeInsetsGeometry.all(10),
          decoration: BoxDecoration(
            color: AppColors.whiteColorF4,
            shape: BoxShape.circle,
          ),
          child: Image.asset(AppImageKeys.mute),
        ),
      ],
    );
  }
}
