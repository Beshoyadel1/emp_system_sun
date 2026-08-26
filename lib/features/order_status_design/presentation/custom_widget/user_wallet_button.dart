import 'package:flutter/material.dart';
import '../../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../../../core/language/language_constant.dart';
import '../../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../../core/theming/assets.dart';
import '../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../core/theming/fonts.dart';
import '../../../../../../../../core/theming/text_styles.dart';

class UserWalletButton extends StatelessWidget {
  final int? paymentMethod;

  const UserWalletButton({
    super.key,
    this.paymentMethod,
  });

  ({String? image, String title}) _paymentData() {
    switch (paymentMethod) {
      case PaymentMethodType.mada:
        return (
        image: AppImageKeys.mada,
        title: AppLanguageKeys.mada,
        );

      case PaymentMethodType.visa:
        return (
        image: AppImageKeys.visa,
        title: AppLanguageKeys.visa,
        );

      case PaymentMethodType.applePay:
        return (
        image: AppImageKeys.applePay,
        title: AppLanguageKeys.applePay,
        );

      case PaymentMethodType.cash:
        return (
        image: null,
        title: AppLanguageKeys.cash,
        );

      case PaymentMethodType.wallet:
        return (
        image: null,
        title: AppLanguageKeys.wallet,
        );

      case PaymentMethodType.points:
        return (
        image: null,
        title: AppLanguageKeys.points,
        );

      default:
        return (
        image: null,
        title: AppLanguageKeys.unknown,
        );
    }
  }

  Color _paymentColor() {
    switch (paymentMethod) {
      case PaymentMethodType.mada:
        return const Color(0xFF00A651);

      case PaymentMethodType.visa:
        return const Color(0xFF1434CB);

      case PaymentMethodType.applePay:
        return AppColors.blackColor;

      case PaymentMethodType.cash:
        return Colors.green;

      case PaymentMethodType.wallet:
        return AppColors.orangeColor;

      case PaymentMethodType.points:
        return Colors.deepPurple;

      default:
        return AppColors.secondaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final payment = _paymentData();
    final color = _paymentColor();

    return CustomContainer(
      onTap: () {},
      isSelected: false,
      containerWidth: double.infinity,
      borderRadius: BorderRadius.circular(16),

      containerColor: AppColors.whiteColor,

      border: Border.all(
        color: color,
        width: 1.5,
      ),

      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),

      typeWidget: Row(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (payment.image != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                payment.image!,
                width: 40,
                height: 24,
                fit: BoxFit.contain,
              ),
            )
          else
            Icon(
              paymentMethod == PaymentMethodType.cash
                  ? Icons.payments_rounded
                  : paymentMethod == PaymentMethodType.wallet
                  ? Icons.account_balance_wallet_rounded
                  : paymentMethod == PaymentMethodType.points
                  ? Icons.stars_rounded
                  : Icons.credit_card_rounded,
              color: color,
              size: 24,
            ),

          Flexible(
            child: TextInAppWidget(
              text: payment.title,
              textSize: 15,
              textColor: color,
              fontWeightIndex: FontSelectionData.semiBoldFontFamily,
              isTextCenter: true,
            ),
          ),
        ],
      ),
    );
  }
}