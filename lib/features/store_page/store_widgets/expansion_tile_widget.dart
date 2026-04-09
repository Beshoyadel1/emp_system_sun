import 'package:flutter/material.dart';
import '../../../../../core/setup_git_it.dart';
import 'column_of_pages_widget.dart';
import '../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../core/cubit/app_cubit/app_cubit.dart';
import '../../../../../core/general_models/pages_model.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class ExpansionTileWidget extends StatefulWidget {
  const ExpansionTileWidget({super.key, required this.pages});

  final PageNodeModel pages;

  @override
  State<ExpansionTileWidget> createState() => _ExpansionTileWidgetState();
}

class _ExpansionTileWidgetState extends State<ExpansionTileWidget> {
  final AppCubit _appCubit = getIt<AppCubit>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;
    return Theme(
      data: ThemeData(dividerColor: Colors.transparent),
      child: ExpansionTile(
        backgroundColor: AppColors.veryLightOrangeColor.withAlpha(100),
        iconColor: widget.pages.number == _appCubit.selectedPageIndex
            ? AppColors.secondaryColor
            : AppColors.whiteColor,
        collapsedIconColor: widget.pages.number == _appCubit.selectedPageIndex
            ? AppColors.secondaryColor
            : AppColors.whiteColor,
        tilePadding: const EdgeInsetsDirectional.only(start: 5, end: 2),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 5,
          children: [
            Image.asset(
              widget.pages.image ?? "",
              color: widget.pages.number == _appCubit.selectedPageIndex
                  ? AppColors.secondaryColor
                  : AppColors.whiteColor,
              height: 18,
              width: 18,
            ),
            Expanded(
              child: TextInAppWidget(
                text: widget.pages.name,
                textSize: 14,
                textColor: widget.pages.number == _appCubit.selectedPageIndex
                    ? AppColors.secondaryColor
                    : AppColors.whiteColor,
                fontWeightIndex: FontSelectionData.regularFontFamily,
              ),
            ),
          ],
        ),
        children: widget.pages.children
            .map((e) => ColumnOfPagesWidget(
                  pageNode: e,
                  appCubit: _appCubit,
                  isMobile: isMobile,
                ))
            .toList(),
      ),
    );
  }
}
