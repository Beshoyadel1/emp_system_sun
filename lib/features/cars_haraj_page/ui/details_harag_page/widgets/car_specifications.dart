import 'package:emp_system_sun/features/cars_haraj_page/custom_widget/title_with_sub_title.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/colors.dart';

class CarSpecifications extends StatelessWidget {
  final String? carDetails;
  const CarSpecifications({super.key,this.carDetails});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      isSelected: false,
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      typeWidget:  Wrap(
        spacing: 35,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: [
          TitleWithSubTitle(
            crossAxisAlignment: CrossAxisAlignment.start,
            title: AppLanguageKeys.carDetails,
            subTitle:carDetails??"Beshoy",
            textSizeTitle:12,
            titleColor: AppColors.greyColor,
            textSizeSubTitle: 14,
            subTitleColor: AppColors.darkColor,
          ),
        ],
      ),
    );
  }
}
