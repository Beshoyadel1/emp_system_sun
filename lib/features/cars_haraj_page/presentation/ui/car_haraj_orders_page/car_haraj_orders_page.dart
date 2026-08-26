import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../../features/cars_haraj_page/presentation/bloc/harag_cubit/harag_cubit.dart';
import '../../../../../../../../../features/cars_haraj_page/presentation/ui/car_haraj_orders_page/screens/list_view_car_harag.dart';

class CarHarajOrdersPage extends StatelessWidget {
  const CarHarajOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HaragCubit()
        ..getUserHarages(
          currentPage: 1,
        ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.scaffoldColor,
            body: SafeArea(
              child: RefreshIndicator(
                color: AppColors.orangeColor,
                onRefresh: () async {
                  await context.read<HaragCubit>().getUserHarages(currentPage: 1);
                },
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: ListViewCarHarag(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}