import 'package:flutter/material.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import 'car_details_dialog_widget.dart';
import 'container_details.dart';

class AllDetailsCar extends StatelessWidget {
  const AllDetailsCar({super.key});

  void _showCarDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const CarDetailsDialogWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 890,
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ContainerDetails(),
          CustomContainer(
            isSelected: false,
            onTap: () {},
            containerHeight: 192,
            containerWidth: 437,
            typeWidget: const Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextInAppWidget(
                  text: 'موصفات السيارة',
                  textSize: 16,
                  textColor: AppColors.greyColor,
                  fontWeightIndex: FontSelectionData.mediumFontFamily,
                ),
                TextInAppWidget(
                  text:
                      'أودي A6 موديل 2018، ماشي 125 ألف كم، أسود من الخارج وداخلي بيج جلد، جير أوتوماتيك، 4 سلندر، بحالة ممتازة بدون حوادث. مزودة بدخول ذكي، تشغيل بصمة، شاشة، كاميرا خلفية، حساسات، وكراسي كهربائية. فحص واستمارة سارية، والصيانة الدورية منتظمة.',
                  textSize: 14,
                  textColor: AppColors.darkColor,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 444,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                3,
                (_) => Image.asset(
                  AppImageKeys.carHaraj,
                  width: 66,
                  height: 44,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          CustomContainer(
            isSelected: false,
            onTap: () {
              _showCarDetailsDialog(context);
            },
            containerColor: AppColors.orangeColor,
            containerWidth: 200,
            containerHeight: 55,
            typeWidget: const Center(
                child: TextInAppWidget(
              text: 'تم بيع السيارة',
              textColor: AppColors.whiteColor,
            )),
          )
        ],
      ),
    );
  }
}
