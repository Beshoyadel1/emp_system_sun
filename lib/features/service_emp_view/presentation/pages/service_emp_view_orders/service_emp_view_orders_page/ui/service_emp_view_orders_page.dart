import 'package:emp_system_sun/features/service_emp_view/presentation/pages/service_emp_view_orders/service_emp_view_orders_page/widgets/orders_page_service_emp_view_orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../core/cubit/new_orders_cubit/new_orders_cubit.dart';
import '../../../../../../../../../core/cubit/new_orders_cubit/new_orders_state.dart';


class ServiceEmpViewOrdersPage extends StatelessWidget {
  final int? serviceId;
  const ServiceEmpViewOrdersPage({super.key,this.serviceId});

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

          return OrdersPageSparePartsStatistics(cubit: cubit,serviceId: serviceId,);
        },
      ),
    );
  }
}
