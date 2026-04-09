import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cubit/new_orders_cubit/new_orders_cubit.dart';
import '../../../../../core/cubit/new_orders_cubit/new_orders_state.dart';
import '../widgets/orders_page_spare_parts_statistics.dart';

class SparePartsStatisticsPage extends StatelessWidget {
  const SparePartsStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewOrdersCubit(),
      child: BlocBuilder<NewOrdersCubit, NewOrdersState>(
        buildWhen: (previous, current) {
          return current is NewOrdersInitial ||
              current is NewOrderDetails;
        },
        builder: (context, state) {
          final cubit = context.read<NewOrdersCubit>();

          // if (state is NewOrderDetails) {
          //   return const OrderDetailsPage();
          // }

          return OrdersPageSparePartsStatistics(cubit: cubit);
        },
      ),
    );
  }
}
