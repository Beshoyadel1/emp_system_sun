import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../../core/theming/fonts.dart';
import '../../../../../../../../../core/theming/text_styles.dart';

class TextDirectionTechnicalSupportAdminSun extends StatelessWidget {
  final String textMessage;
  final bool isSender, isSeen;

  const TextDirectionTechnicalSupportAdminSun({
    super.key,
    required this.textMessage,
    this.isSender = false,
    this.isSeen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
        isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          TextInAppWidget(
            text: '8:10 pm',
            textColor: AppColors.darkColor,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textSize: 10,
          ),
          const SizedBox(height: 4),
          Row(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: isSender
                ? [
              _buildCircle(),
              _buildBubble(),
              if (isSeen) ...[
                const SizedBox(width: 5),
                const Icon(
                  Icons.done_all,
                  color: AppColors.orangeColor,
                  size: 18,
                ),
              ],
            ]
                : [
              _buildBubble(),
              _buildCircle(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircle() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color:
        isSender ? AppColors.redColor.withOpacity(0.3) : AppColors.greyColor,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildBubble() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 250),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isSender ? AppColors.orangeColor : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextInAppWidget(
        text: textMessage,
        textColor: isSender ? AppColors.whiteColor : AppColors.darkColor,
        fontWeightIndex: FontSelectionData.regularFontFamily,
        textSize: 14,
      ),
    );
  }
}

