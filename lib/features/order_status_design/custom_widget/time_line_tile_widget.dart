import 'package:flutter/material.dart';
import 'package:timeline_tile_plus/timeline_tile_plus.dart';
import '../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../core/theming/fonts.dart';
import '../../../../../../../../core/theming/text_styles.dart';

class TimeLineTileWidget extends StatelessWidget {
  final bool? isFirst,isLast,isIcon;
  final String? text,title,subTitle;
  final Color? textColor,colorBeforeLine,colorAfterLine,textColorTitle,textColorSubTitle,colorBorder;
  const TimeLineTileWidget({
    super.key,
    this.isFirst=false,
    this.isLast=false,
    this.isIcon=false,
    this.text,
    this.textColor,
    this.colorAfterLine,
    this.colorBeforeLine,
    this.title,
    this.subTitle,
    this.textColorSubTitle,
    this.textColorTitle,
    this.colorBorder
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.center,
      isFirst: isFirst!,
      isLast: isLast!,
      indicatorStyle: IndicatorStyle(
        width: 30,
        height: 30,
        color:AppColors.orangeColor,
        indicator:Container(
          decoration: BoxDecoration(
              color: isIcon!?AppColors.orangeColor:AppColors.whiteColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: colorBorder??AppColors.orangeColor,
              )
          ),
          child: isIcon!?
              const Icon(Icons.check,color: AppColors.whiteColor,)
              :
          Center(
            child: TextInAppWidget(
              text:text??'1',
              textSize: 18,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              textColor:textColor??AppColors.orangeColor,
            ),
          ),
        ),
      ),
      beforeLineStyle: LineStyle(
        color:colorBeforeLine?? AppColors.orangeColor,
        thickness: 3,
      ),
      afterLineStyle:LineStyle(
        color:colorAfterLine??AppColors.orangeColor,
        thickness: 3,
      ),
      endChild: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const SizedBox(
              height: 10,
            ),
            TextInAppWidget(
              text:title??'',
              textSize: 14,
              fontWeightIndex: FontSelectionData.semiBoldFontFamily,
              textColor:textColorTitle??AppColors.blackColor,
            ),
            TextInAppWidget(
              text:subTitle??'',
              textSize: 12,
              fontWeightIndex: FontSelectionData.semiBoldFontFamily,
              textColor:textColorSubTitle??AppColors.greyColor,
            ),
          ],
        ),
      ),
    );
  }
}
