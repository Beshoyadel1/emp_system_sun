import 'package:emp_system_sun/features/cars_haraj_page/presentation/bloc/harag_cubit/harag_cubit.dart';
import 'package:emp_system_sun/features/cars_haraj_page/presentation/bloc/harag_cubit/harag_state.dart';
import 'package:emp_system_sun/features/cars_haraj_page/presentation/ui/page_details_harag/page_details_harag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../core/language/language_constant.dart';
import '../../../../../../../../../core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import '../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../features/cars_haraj_page/presentation/custom_widget/widget_design_list_harag.dart';
import '../../../../../../../features/internal_services/presentation/pages/internal_orders/custom_widget/text_empty_view_data.dart';

class AvailableListCars extends StatelessWidget {
  const AvailableListCars({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HaragCubit, HaragState>(
      builder: (context, state) {
        if (state is UserHaragesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is UserHaragesError) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is! UserHaragesSuccess) {
          return const SizedBox();
        }

        final data = state.response?.data;

        if (data == null) {
          return const Center(
            child: TextEmptyViewData(),
          );
        }

        final harages = [...(data.data ?? [])];

        if (harages.isEmpty) {
          return const Center(
            child: TextEmptyViewData(),
          );
        }

        // Sort by date: newest first
        harages.sort((a, b) {
          final dateA = DateTime.tryParse(a.releaseDate ?? '');
          final dateB = DateTime.tryParse(b.releaseDate ?? '');

          if (dateA == null && dateB == null) {
            return 0;
          }

          if (dateA == null) {
            return 1;
          }

          if (dateB == null) {
            return -1;
          }

          return dateB.compareTo(dateA);
        });

        // Show only the latest 5
        final latestHarages = harages.take(3).toList();

        return CustomContainer(
          isSelected: false,
          onTap: () {},
          typeWidget: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: latestHarages.length,
            separatorBuilder: (_, __) {
              return const SizedBox(
                height: 20,
              );
            },
            itemBuilder: (context, index) {
              final harag = latestHarages[index];

              return WidgetDesignListHarag(
                isDemoData: true,
                haragId: harag.id?.toString() ?? '-',
                name: harag.user?.getName(context) ?? '-',
                nameButton: AppLanguageKeys.details,
                image: harag.car?.carImage ?? harag.user?.image,
                kilometers: harag.kilometers?.toString() ?? '0',
                isNew: harag.isNew,
                releaseDate: harag.releaseDate ?? '-',
                isSold: harag.isSold,
                sellDate: harag.sellDate ?? '-',
                onTabDetails: () async {
                  final result = await Navigator.push(
                    context,
                    NavigateToPageWidget(
                      PageDetailsHarag(
                        harageId: harag.id ?? 0,
                      ),
                    ),
                  );

                  if (result == true && context.mounted) {
                    await context.read<HaragCubit>().getUserHarages(
                      currentPage: 1,
                    );
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}