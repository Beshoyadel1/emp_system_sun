import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/internal_services/internal_services_statistics/Internal_services_page/model/new_order_steps_model/new_order_steps_model.dart';
import '../../../../../core/cubit/new_orders_cubit/new_orders_cubit.dart';
import '../../../../../core/cubit/new_orders_cubit/new_orders_state.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/theming/colors.dart';
import 'order_time_line.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewOrdersCubit(),
        child: Center(
            child: BlocBuilder<NewOrdersCubit, NewOrdersState>(
                buildWhen: (previous, current) => current is ChangeIndexState,
                builder: (context, state) {
                  final cubit = context.read<NewOrdersCubit>();
                  final currentIndex = cubit.selectedIndex;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            const Column(
                              children: [
                                TextInAppWidget(
                                    text: AppLanguageKeys.orderDetailsTitleKey,
                                    textSize: 20,
                                    textColor: AppColors.darkColor,
                                    fontWeightIndex:
                                        FontSelectionData.mediumFontFamily),
                                TextInAppWidget(
                                  text: AppLanguageKeys.viewAllOrderDetailsKey,
                                  textSize: 14,
                                  textColor: AppColors.darkGreyColor,
                                  fontWeightIndex:
                                      FontSelectionData.regularFontFamily,
                                ),
                              ],
                            ),
                            const Spacer(),
                            if (currentIndex > 0)
                              CustomContainer(
                                containerWidth: 120,
                                containerHeight: 40,
                                padding: const EdgeInsets.all(0),
                                containerColor: AppColors.darkGreyColor,
                                isSelected: false,
                                onTap: () {
                                  cubit.selectTab(currentIndex - 1);
                                },
                                typeWidget: const Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.arrow_back_ios_new_rounded,
                                        color: AppColors.whiteColor,
                                        size: 14,
                                      ),
                                      TextInAppWidget(
                                          text: AppLanguageKeys.backKey,
                                          textSize: 13,
                                          fontWeightIndex: FontSelectionData
                                              .regularFontFamily,
                                          textColor: AppColors.whiteColor),
                                    ],
                                  ),
                                ),
                              )
                          ]),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Wrap(
                                spacing: 30,
                                runSpacing: 20,
                                children: [
                                  steps[currentIndex].content,
                                  const OrderTimeline(),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                })));
  }
}
