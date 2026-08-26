import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../core/cubit/new_orders_cubit/new_orders_cubit.dart';
import '../../../../../../../../../core/cubit/new_orders_cubit/new_orders_state.dart';
import '../widgets/orders_page_order_services_type.dart';

class OrderServicesTypePage extends StatelessWidget {
  final int serviceId;
  const OrderServicesTypePage({super.key,required this.serviceId});

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

          return OrdersPageMobileServicesStatistics(cubit: cubit,serviceId:serviceId,);
        },
      ),
    );
  }
}
