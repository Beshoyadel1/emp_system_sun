import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class CustomChart extends StatelessWidget {
  const CustomChart({
    super.key,
    required this.image,
    required this.imageBackground,
    this.serviceName,
    this.orderCount,
    this.totalAmount,
    this.percentage,
    this.isIncrease,
  });

  final String image;
  final Color imageBackground;
  final String? serviceName;
  final int? orderCount;
  final double? totalAmount;
  final double? percentage;
  final bool? isIncrease;

  @override
  Widget build(BuildContext context) {
    final isUp = isIncrease ?? false;

    return CustomContainer(
      containerWidth: 280,
      containerHeight: 260,
      isSelected: false,
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      typeWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔝 Header
          Row(
            children: [
              CircleAvatar(
                radius: 27,
                backgroundColor: imageBackground.withOpacity(0.2),
                child: Image.asset(
                  image,
                  height: 18,
                  width: 18,
                  color: imageBackground,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextInAppWidget(
                      text: serviceName ?? "",
                      textSize: 16,
                      fontWeightIndex:
                      FontSelectionData.mediumFontFamily,
                    ),
                    Row(
                      spacing: 5,
                      children: [
                        TextInAppWidget(
                          text: AppLanguageKeys.ordersCountKey,
                          textColor: imageBackground,
                          textSize: 14,
                        ),
                        TextInAppWidget(
                          text:
                          ": ${orderCount ?? 0}",
                          textColor: imageBackground,
                          textSize: 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Spacer(),

          /// 💰 Amount
          Row(
            spacing: 5,
            children: [
              TextInAppWidget(
                text: AppLanguageKeys.price,
                textSize: 18,
                fontWeightIndex: FontSelectionData.semiBoldFontFamily,
                textColor: imageBackground,
              ),
              TextInAppWidget(
                text: ":${totalAmount ?? 0}",
                textSize: 18,
                fontWeightIndex: FontSelectionData.boldFontFamily,
                textColor: imageBackground,
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// 📈 Percentage
          Row(
            children: [
              Icon(
                isUp
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
                color: isUp ? Colors.green : Colors.red,
                size: 16,
              ),
              const SizedBox(width: 5),
              TextInAppWidget(
                text: "${percentage ?? 0}%",
                textColor: isUp ? Colors.green : Colors.red,
                textSize: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}