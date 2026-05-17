import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';

class FlutterMapWidget extends StatelessWidget {
  const FlutterMapWidget(
      {super.key, required this.centerLocation, required this.mapController});

  final LatLng centerLocation;
  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: centerLocation,
        initialZoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.smat_admin',
        ),
        CircleLayer(
          circles: [
            CircleMarker(
              point: centerLocation,
              color: AppColors.lightOrangeColor.withAlpha(60),
              borderStrokeWidth: 2,
              borderColor: AppColors.orangeColor,
              useRadiusInMeter: true,
              radius: 1500,
            ),
          ],
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 60.0,
              height: 60.0,
              point: centerLocation,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppColors.orangeColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            Marker(
              width: 40.0,
              height: 40.0,
              point: LatLng(
                centerLocation.latitude - 0.0064,
                centerLocation.longitude,
              ),
              child: Image.asset(
                AppImageKeys.carLocation,
                width: 32,
                height: 19,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
