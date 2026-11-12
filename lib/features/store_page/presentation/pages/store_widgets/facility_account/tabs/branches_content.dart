import 'package:emp_system_sun/core/language/language.dart';
import 'package:emp_system_sun/features/store_page/presentation/bloc/branch_cubit/branch_cubit.dart';
import 'package:emp_system_sun/features/store_page/presentation/bloc/branch_cubit/branch_state.dart';
import 'package:emp_system_sun/features/store_page/presentation/bloc/location_cubit/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import '../../add_branch_ui.dart';
import '../../branches_added_ui.dart';

class BranchesContent extends StatelessWidget {
  const BranchesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchCubit, BranchState>(
      builder: (context, state) {
        if (state is BranchLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BranchError) {
          return Center(
              child:
                  Text(AppLocalizations.of(context).translate(state.message)));
        }

        if (state is BranchSuccess) {
          if (!state.isAdding) return BranchesAddedUi(state: state);

          final branch = state.branches
              .where((branch) => branch.branchId == state.editingBranchId)
              .firstOrNull;
          final lat = branch?.latitude;
          final lng = branch?.longitude;
          return BlocProvider(
            key: ValueKey(state.editingBranchId),
            create: (_) => LocationCubit(
              initialLocation:
                  lat != null && lng != null ? LatLng(lat, lng) : null,
            ),
            child: const AddBranchUI(),
          );
        }

        return const SizedBox();
      },
    );
  }
}
