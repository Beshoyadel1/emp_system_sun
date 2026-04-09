import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cubit/new_orders_cubit/new_orders_cubit.dart';
import '../../../../../core/cubit/new_orders_cubit/new_orders_state.dart';
import '../widgets/car_order_details_page.dart';
import '../widgets/car_orders_page.dart';

class CarHarajOrdersPage extends StatelessWidget {
  const CarHarajOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => NewOrdersCubit(),
        child: BlocBuilder<NewOrdersCubit, NewOrdersState>(
            builder: (context, state) {
          final cubit = context.read<NewOrdersCubit>();
          if (state is NewOrdersInitial) {
            return CarOrdersPage(cubit: cubit);
          } else {
            return const CarOrderDetailsPage();
          }
        }));
  }
}
