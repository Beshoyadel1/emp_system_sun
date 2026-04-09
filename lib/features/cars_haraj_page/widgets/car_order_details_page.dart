import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cubit/new_orders_cubit/new_orders_cubit.dart';
import '../../../../../core/cubit/new_orders_cubit/new_orders_state.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';
import 'all_details_car.dart';
import 'message.dart';
import 'update_car_widget.dart';

class CarOrderDetailsPage extends StatelessWidget {
  const CarOrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewOrdersCubit(),
        child: Center(
            child: BlocBuilder<NewOrdersCubit, NewOrdersState>(
                buildWhen: (previous, current) => current is ChangeIndexState,
                builder: (context, state) {
                //  final cubit = context.read<NewOrdersCubit>();
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const UpdateCarWidget(),
                          const SizedBox(height: 20),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            alignment: WrapAlignment.center,
                            children: [
                              const AllDetailsCar(),
                              CustomContainer(
                                borderRadius: BorderRadius.zero,
                                containerWidth: 310,
                                border: const Border(),
                                typeWidget: Center(
                                    child: Column(
                                        spacing: 20,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                      const TextInAppWidget(
                                          text: 'الرسائل',
                                          textSize: 20,
                                          textColor: AppColors.darkColor,
                                          fontWeightIndex: FontSelectionData
                                              .mediumFontFamily),
                                      ...List.generate(6, (_) => const Message()),
                                    ])),
                                isSelected: false,
                                onTap: () {},
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
