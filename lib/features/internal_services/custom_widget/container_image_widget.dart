import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import '../../../../../core/theming/colors.dart';

class ContainerImageWidget extends StatelessWidget {
  final String? imagePath;
  final double? width, height;
  final Color color;
  final bool? isBorder;
  final Uint8List? imageMemory;

  const ContainerImageWidget({
    super.key,
     this.imagePath,
    required this.color,
    this.width,
    this.height,
    this.isBorder = true,
    this.imageMemory
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsetsGeometry.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(
            color: isBorder!
                ? AppColors.greyColor.withOpacity(0.3)
                : AppColors.transparent),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: (imageMemory == null || imageMemory!.isEmpty)
          ? Image.asset(imagePath ?? '')
          : Image.memory(imageMemory!),
    );
  }
}
