import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cubit/app_cubit/app_cubit.dart';
import '../../../../../core/cubit/app_cubit/app_states.dart';
import '../../../../../core/setup_git_it.dart';
import '../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import 'column_of_pages_widget.dart';

class PagesSelectionBar extends StatefulWidget {
  const PagesSelectionBar({super.key});

  @override
  State<PagesSelectionBar> createState() => _PagesSelectionBarState();
}

class _PagesSelectionBarState extends State<PagesSelectionBar> {
  final AppCubit _appCubit = getIt<AppCubit>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;
    return Container(
      width: 256,
      decoration: const BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadiusDirectional.only(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100,
          ),
          Center(
            child: Image.asset(AppImageKeys.sarWhiteLogo, height: 80),
          ),
          const SizedBox(
            height: 60,
          ),
          BlocBuilder<AppCubit, AppStates>(
            buildWhen: (previous, current) {
              return current is ChangeSelectedPageIndexState;
            },
            builder: (BuildContext context, AppStates state) {
              return Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final page in appPages) ...[
                          ColumnOfPagesWidget(
                            pageNode: page,
                            appCubit: _appCubit,
                            isMobile: isMobile,
                          ),
                          if (_appCubit.selectedPageIndex != page.number)
                            const Divider(
                              thickness: 1,
                              color: AppColors.whiteColor,
                            )
                        ]
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
