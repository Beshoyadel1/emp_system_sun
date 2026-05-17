import 'package:emp_system_sun/features/store_page/data/model/location_cubit/location_cubit.dart';
import 'package:emp_system_sun/features/store_page/presentation/bloc/branch_cubit/branch_cubit.dart';
import 'package:emp_system_sun/features/store_page/presentation/bloc/branch_cubit/branch_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../add_branch_ui.dart';
import '../../branches_added_ui.dart';

class BranchesContent extends StatelessWidget {
  const BranchesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationCubit(),
      child: BlocBuilder<BranchCubit, BranchState>(
        builder: (context, state) {
          if (state is BranchLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BranchError) {
            return Center(child: Text(state.message));
          }

          if (state is BranchSuccess) {
            return state.isAdding
                ? const AddBranchUI()
                : BranchesAddedUi(state:state);
          }

          return const SizedBox();
        },
      ),
    );
  }
}