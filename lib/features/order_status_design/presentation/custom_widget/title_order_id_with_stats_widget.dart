import 'package:emp_system_sun/features/order_status_design/presentation/custom_widget/title_with_sub_title.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../features/internal_services/presentation/pages/internal_orders/custom_widget/container_status.dart';
import '../../../../../../features/order_status_design/presentation/custom_widget/container_return_to_page_setting.dart';

class TitleOrderIdWithStatsWidget extends StatelessWidget {
  final int? status;
  final String? id;
  const TitleOrderIdWithStatsWidget({super.key,this.status,this.id});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 450;

        final titleWidget = TitleWithSubTitle(
          spacing: 5,
          title:AppLanguageKeys.orderDetailsNumber,
          numberOrderTitle:id??"55",
          titleColor: AppColors.darkColor,
          textSizeTitle: 20,
          subTitle:AppLanguageKeys.viewAllOrderDetails,
          subTitleColor: AppColors.greyColor,
          textSizeSubTitle: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
        );

        final actionsWidget = Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 5,
          children: [
            ContainerStatus(
              status: status??-2,
            ),
             ContainerReturnToPageSetting(
              text: AppLanguageKeys.back,
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        );

        // Mobile
        if (isMobile) {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: [
              titleWidget,
              actionsWidget,
            ],
          );
        }

        // Desktop / Tablet
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: [
            titleWidget,
            actionsWidget,
          ],
        );
      },
    );
  }
}