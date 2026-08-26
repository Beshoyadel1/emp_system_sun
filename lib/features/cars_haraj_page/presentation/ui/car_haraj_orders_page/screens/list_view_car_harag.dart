import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../features/spare_parts/presentation/custom_widget/app_pagination.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import '../../../../../../../features/cars_haraj_page/presentation/bloc/harag_cubit/harag_cubit.dart';
import '../../../../../../../features/cars_haraj_page/presentation/bloc/harag_cubit/harag_state.dart';
import '../../../../../../../features/cars_haraj_page/presentation/custom_widget/widget_design_list_harag.dart';
import '../../../../../../../features/cars_haraj_page/presentation/ui/page_details_harag/page_details_harag.dart';
import '../../../../../../../features/internal_services/presentation/pages/internal_orders/custom_widget/text_empty_view_data.dart';

class ListViewCarHarag extends StatelessWidget {
  const ListViewCarHarag({super.key});

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

        if (state is UserHaragesSuccess) {
          final data = state.response?.data;

          if (data == null) {
            return const Center(
              child: TextEmptyViewData(),
            );
          }

          // Change `data.data` to the actual list property
          // inside your GetUserHaragesData model.
          final harages = data.data ?? [];

          if (harages.isEmpty) {
            return const Center(
              child: TextEmptyViewData(),
            );
          }

          return CustomContainer(
            isSelected: false,
            onTap: () {},
            typeWidget: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: harages.length,
                    separatorBuilder: (_, __) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    itemBuilder: (context, index) {
                      final harag = harages[index];

                      return WidgetDesignListHarag(
                        haragId: harag.id?.toString() ?? '-',
                        name: harag.user?.getName(context) ?? '-',
                        nameButton: AppLanguageKeys.details,
                        image: harag.car?.carImage ?? harag.user?.image,
                        kilometers:
                        harag.kilometers?.toString() ?? '0',
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
                ),

                const SizedBox(
                  height: 20,
                ),

                AppPagination(
                  currentPage: data.currentPage ?? state.currentPage,
                  totalPages: data.pageCount ?? state.pageCount,
                  onPageChanged: (page) {
                    context.read<HaragCubit>().getUserHarages(
                      currentPage: page,
                    );
                  },
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}