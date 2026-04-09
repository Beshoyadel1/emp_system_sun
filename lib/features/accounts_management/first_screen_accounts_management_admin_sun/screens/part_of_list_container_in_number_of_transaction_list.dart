import 'package:flutter/cupertino.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../features/accounts_management/custom_widget/design_container_image_with_two_text_widget.dart';
import '../../../../../features/accounts_management/custom_widget/design_container_text_with_image_or_icon.dart';
import '../../../../../../core/theming/assets.dart';

class PartOfListContainerInFirstScreenAccountsManagementAdminSun extends StatelessWidget {
  const PartOfListContainerInFirstScreenAccountsManagementAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    final List<int> items = List.generate(5, (index) => index);
    return  SizedBox(
      height: 120,
      child: ListView.separated(
        shrinkWrap: true,
        //physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return CustomContainer(
            isSelected: false,
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            typeWidget: const DesignContainerImageWithTwoTextWidget(
              imagePath: AppImageKeys.account_sun2,
              title: 'عدد النقاط للمستخدم',
              subTitle: ' 5000 نقطة ',
            ),
          );
        },
      ),
    );
  }
}