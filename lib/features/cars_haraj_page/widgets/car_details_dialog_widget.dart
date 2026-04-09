import 'package:flutter/material.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';
import 'car_model.dart' show CarModel;

class CarDetailsDialogWidget extends StatelessWidget {
  const CarDetailsDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 100, vertical: 24),
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Padding(
            padding: const EdgeInsets.all(70.0),
            child: SizedBox(
              width: 800,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  const Wrap(spacing: 60, children: [
                    TextInAppWidget(text: 'بيع سيارة', textSize: 20),
                    CarModel()
                  ]),
                  TextFormFieldWidget(
                    textFormController: TextEditingController(),
                    text: 'سعر بيع السيارة',
                    isColumn: true,
                    fillColor: AppColors.whiteColor,
                    borderColor: AppColors.greyColor,
                    textFormHeight: 40,
                    focusedBorderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: CustomContainer(
                      isSelected: false,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      containerColor: AppColors.orangeColor,
                      containerWidth: 200,
                      containerHeight: 45,
                      typeWidget: const Center(
                          child: TextInAppWidget(
                        text: 'تم بيع السيارة',
                        textColor: AppColors.whiteColor,
                        textSize: 16,
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
