import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../../../../features/store_page/model/location_cubit/location_cubit.dart';
import '../../../../../features/store_page/model/location_cubit/location_state.dart';
import 'flutter_map_widget.dart';

class SquareMapWidget extends StatelessWidget {
  SquareMapWidget({super.key});

  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationCubit, LocationState>(
      listener: (context, state) {
        if (state is LocationLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            mapController.move(
              state.latLng,
              13,
            );
          });
        } else if (state is LocationError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is LocationInitial) {
          context.read<LocationCubit>().getUserLocation();
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LocationLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is LocationLoaded) {
          final center = state.latLng;
          return SizedBox(
            height: 200,
            child: FlutterMapWidget(
              centerLocation: center,
              mapController: mapController,
            ),
          );
        }
        if (state is LocationError) {
          return Center(
            child: Text(state.message),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
