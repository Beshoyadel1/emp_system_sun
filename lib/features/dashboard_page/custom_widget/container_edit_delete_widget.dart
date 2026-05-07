import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theming/colors.dart';

class ContainerEditDeleteWidget extends StatelessWidget {
  final bool? isDelete, isAdd;
  final VoidCallback? onPressed;
  final double? size;
  final Color? colorIcon, colorBackGround;

  const ContainerEditDeleteWidget(
      {super.key,
      this.isDelete = false,
      this.isAdd = false,
      this.onPressed,
      this.size,
      this.colorBackGround,
      this.colorIcon});

  @override
  Widget build(BuildContext context) {
    final double iconSize = size ?? 20;
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          width: iconSize + 8,
          height: iconSize + 8,
          decoration: BoxDecoration(
            color: colorBackGround ??
                (isDelete!
                    ? AppColors.redColor
                    : isAdd!
                        ? AppColors.greenColor
                        : AppColors.darkBlueColor),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            isDelete! ? Icons.delete : isAdd! ? Icons.add: Icons.edit,
            color: colorIcon ?? AppColors.whiteColor,
            size: iconSize,
          ),
        ));
  }
}
