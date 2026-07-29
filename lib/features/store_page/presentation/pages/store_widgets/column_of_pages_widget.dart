import 'package:emp_system_sun/core/utilies/map_of_all_app.dart';
import 'package:emp_system_sun/features/logout_dashboard/presentation/first_screen_logout_dashboard/logout_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/general_models/pages_model.dart';
import '../../../../../core/cubit/app_cubit/app_cubit.dart';
import 'expansion_tile_widget.dart';
import 'general_widgets_in_store/function_add_to_opened_pages.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class ColumnOfPagesWidget extends StatelessWidget {
  const ColumnOfPagesWidget({
    super.key,
    required this.pageNode,
    required this.appCubit,
    required this.isMobile,
  });

  final PageNodeModel pageNode;
  final AppCubit appCubit;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (pageNode.children.isNotEmpty) {
      return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            color: pageNode.number == appCubit.selectedPageIndex
                ? AppColors.whiteColor
                : AppColors.transparent,
          ),
          child: ExpansionTileWidget(
            pages: pageNode,
          ));
    } else {
      return InkWell(
          onTap: () async {
            // ============================
            // Logout
            // ============================
            if (pageNode.number == PagesOfAllApp.logoutPageNumber) {
              // لو Mobile اقفل الـ Drawer الأول
              if (isMobile) {
                Navigator.of(context).pop();
              }

              // استنى لحد ما الـ Drawer يقفل
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!context.mounted) return;

                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (dialogContext) {
                    return const LogoutDashboard();
                  },
                );
              });

              return;
            }

            // ============================
            // Normal Page
            // ============================

            final keyForUpdate =
                '${appCubit.selectedPageIndex}'
                '${appCubit.selectedPageFromOpenedPagesIndex}';

            final prefs = await SharedPreferences.getInstance();

            final getData = prefs.getStringList(keyForUpdate);

            if (getData != null && appCubit.data.isNotEmpty) {
              await prefs.setStringList(
                keyForUpdate,
                appCubit.data.map((e) => e.toString()).toList(),
              );
            } else {
              if (appCubit.data.isNotEmpty) {
                await addToOpenedPages(
                  context: context,
                  appCubit: appCubit,
                );
              }
            }

            appCubit.selectedPageIndex = pageNode.number;
            appCubit.selectedPageFromOpenedPagesIndex = -1;

            appCubit.changeSelectedPageIndex();

            appCubit.data.clear();

            if (isMobile && context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: Container(
            width: double.infinity,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: pageNode.number == appCubit.selectedPageIndex
                  ? AppColors.whiteColor
                  : pageNode.image == null
                      ? AppColors.veryLightOrangeColor.withAlpha(100)
                      : AppColors.seaBlueColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 5,
                      children: [
                        if (pageNode.image != null && pageNode.image!.isNotEmpty)
                          Image.asset(
                            pageNode.image!,
                            color: pageNode.number == appCubit.selectedPageIndex
                                ? AppColors.orangeColor
                                : AppColors.whiteColor,
                            height: 18,
                            width: 18,
                          ),
                        if (pageNode.imageUint8List != null && pageNode.imageUint8List!.isNotEmpty)
                          Image.memory(
                            pageNode.imageUint8List!,
                            color: pageNode.number == appCubit.selectedPageIndex
                                ? AppColors.orangeColor
                                : AppColors.whiteColor,
                            height: 18,
                            width: 18,
                          ),
                        Expanded(
                          child: TextInAppWidget(
                            text: pageNode.name,
                            textSize: 14,
                            textColor:
                                pageNode.number == appCubit.selectedPageIndex
                                    ? AppColors.orangeColor
                                    : AppColors.whiteColor,
                            fontWeightIndex:
                                FontSelectionData.regularFontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
    }
  }
}
