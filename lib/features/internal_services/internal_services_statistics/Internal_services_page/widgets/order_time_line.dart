import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../features/internal_services/internal_services_statistics/Internal_services_page/model/new_order_steps_model/new_order_steps_model.dart';
import '../../../../../core/cubit/new_orders_cubit/new_orders_cubit.dart';
import '../../../../../core/cubit/new_orders_cubit/new_orders_state.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class OrderTimeline extends StatelessWidget {
  const OrderTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewOrdersCubit, NewOrdersState>(
      buildWhen: (previous, current) => current is ChangeIndexState,
      builder: (context, state) {
        return CustomContainer(
          containerWidth: 241,
          border: const Border(),
          containerHeight: 592,
          typeWidget: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(steps.length, (index) {
                final step = steps[index];
                final bool isLast = index == steps.length - 1;
                final cubit = context.read<NewOrdersCubit>();
                final bool isCompleted = index < cubit.selectedIndex ||
                    (index == cubit.selectedIndex &&
                        cubit.selectedIndex == steps.length - 1);
                final bool isCurrent = index == cubit.selectedIndex;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isCompleted
                                    ? AppColors.orangeColor
                                    : AppColors.whiteColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isCurrent || isCompleted
                                      ? AppColors.orangeColor
                                      : AppColors.veryLightGreyColor,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: isCompleted
                                    ? const Icon(Icons.check,
                                        color: AppColors.whiteColor, size: 18)
                                    : TextInAppWidget(
                                        text: '${index + 1}',
                                        textSize: 16,
                                        textColor: isCurrent
                                            ? AppColors.orangeColor
                                            : AppColors.veryLightGreyColor,
                                      ),
                              ),
                            ),
                            if (!isLast)
                              Container(
                                width: 2,
                                height: 96,
                                color: index < cubit.selectedIndex
                                    ? AppColors.orangeColor
                                    : AppColors.veryLightGreyColor,
                              ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextInAppWidget(
                              text: step.title,
                              textSize: 16,
                              textColor: AppColors.darkColor,
                              fontWeightIndex:
                                  FontSelectionData.mediumFontFamily,
                            ),
                            const SizedBox(height: 4),
                            TextInAppWidget(
                              text: step.date,
                              textSize: 14,
                              textColor: AppColors.darkColor,
                              fontWeightIndex:
                                  FontSelectionData.regularFontFamily,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
          isSelected: false,
          onTap: () {},
        );
      },
    );
  }
}
