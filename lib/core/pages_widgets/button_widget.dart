import 'package:flutter/material.dart';
import '../theming/colors.dart';
import '../theming/text_styles.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    this.iconData,
    this.onTap,
    this.iconColor,
    this.text,
    this.textSize,
    this.buttonColor,
    this.iconSize,
    this.textColor,
    this.widthInButton,
    this.fontWeightIndex,
    this.boxShape,
    this.borderColor,
    this.isIconInEnd,
    this.borderRadius,
    this.isColumn,
    this.isTextCenter,
    this.textHeight,
    this.borderWidth,
    this.image,
    this.heightContainer,
    this.widthContainer,
    this.imageHeight,
    this.imageWidth,
    this.isFirstImageText = false,
  });

  final IconData? iconData;
  final Color? iconColor;
  final double? iconSize;
  final void Function()? onTap;
  final String? text;
  final double? textSize;
  final Color? textColor;
  final Color? buttonColor;
  final Color? borderColor;
  final bool? widthInButton;
  final int? fontWeightIndex;
  final BoxShape? boxShape;
  final bool? isIconInEnd;
  final double? borderRadius;
  final bool? isColumn;
  final bool? isTextCenter;
  final double? textHeight;
  final double? borderWidth;
  final String? image;
  final double? heightContainer;
  final double? widthContainer;
  final double? imageHeight;
  final double? imageWidth;
  final bool isFirstImageText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: heightContainer ?? 50,
        width: widthContainer ?? 120,
        decoration: BoxDecoration(
          color: buttonColor ?? AppColors.whiteColor,
          borderRadius: boxShape != null
              ? null
              : BorderRadius.circular(borderRadius ?? 10),
          border: boxShape != null
              ? null
              : borderColor == null
                  ? null
                  : Border.all(
                      color: borderColor!,
                      width: borderWidth ?? 1,
                    ),
          shape: boxShape ?? BoxShape.rectangle,
        ),
        child: isColumn == true ? _buildColumnContent() : _buildRowContent(),
      ),
    );
  }

  /// Column layout
  Widget _buildColumnContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (iconData != null)
          Icon(
            iconData,
            color: iconColor ?? Colors.white,
            size: iconSize ?? 20,
          ),
        if (isFirstImageText && image != null) ...[
          Image.asset(
            image!,
            fit: BoxFit.contain,
            height: imageHeight ?? 16,
            width: imageWidth ?? 16,
          ),
          const SizedBox(height: 6),
        ],
        if (text != null)
          Flexible(
            child: SizedBox(
              height: textHeight ?? 20,
              child: Center(
                child: TextInAppWidget(
                  text: text ?? '',
                  textColor: textColor ?? Colors.white,
                  textSize: textSize,
                  isTextCenter: isTextCenter,
                  textAlign: TextAlign.center,
                  fontWeightIndex: fontWeightIndex,
                ),
              ),
            ),
          ),
        if (!isFirstImageText && image != null) ...[
          const SizedBox(height: 6),
          Image.asset(
            image!,
            fit: BoxFit.contain,
            height: imageHeight ?? 16,
            width: imageWidth ?? 16,
          ),
        ],
      ],
    );
  }

  /// Row layout
  Widget _buildRowContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (iconData != null)
          Icon(
            iconData,
            color: iconColor ?? Colors.white,
            size: iconSize ?? 20,
          ),
        if (widthInButton == true) const SizedBox(width: 8),
        if (isFirstImageText && image != null) ...[
          const SizedBox(width: 6),
          Image.asset(
            image!,
            fit: BoxFit.contain,
            height: imageHeight ?? 16,
            width: imageWidth ?? 16,
          ),
        ],
        if (text != null)
          Flexible(
            child: TextInAppWidget(
              text: text ?? '',
              textColor: textColor ?? Colors.white,
              textSize: textSize,
              isTextCenter: isTextCenter,
              fontWeightIndex: fontWeightIndex,
              textAlign: TextAlign.center,
            ),
          ),
        if (!isFirstImageText && image != null) ...[
          const SizedBox(width: 6),
          Image.asset(
            image!,
            fit: BoxFit.contain,
            height: imageHeight ?? 16,
            width: imageWidth ?? 16,
          ),
        ],
      ],
    );
  }
}
