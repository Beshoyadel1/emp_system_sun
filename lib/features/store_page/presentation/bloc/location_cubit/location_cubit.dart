import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({LatLng? initialLocation})
      : super(initialLocation == null
            ? LocationInitial()
            : LocationLoaded(initialLocation, ''));

  int _locationVersion = 0;

  Future<void> getUserLocation() async {
    final version = ++_locationVersion;
    emit(LocationLoading());
    try {
      if (!kIsWeb && Platform.isMacOS) {
        final currentLatLng = LatLng(30.0444, 31.2357);
        final cityName = await _getPlaceName(currentLatLng);
        if (!isClosed && version == _locationVersion) {
          emit(LocationLoaded(currentLatLng, cityName));
        }
        return;
      }

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (isClosed || version != _locationVersion) return;
      if (!serviceEnabled) {
        emit(LocationError("Location service disabled"));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (isClosed || version != _locationVersion) return;
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (isClosed || version != _locationVersion) return;
        if (permission == LocationPermission.denied) {
          emit(LocationError("Permission denied"));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(LocationError("Permission denied forever"));
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final currentLatLng = LatLng(position.latitude, position.longitude);

      final cityName = await _getPlaceName(currentLatLng);

      if (!isClosed && version == _locationVersion) {
        emit(LocationLoaded(currentLatLng, cityName));
      }
    } catch (e) {
      if (!isClosed && version == _locationVersion) {
        emit(LocationError(e.toString()));
      }
    }
  }

  Future<String> _getPlaceName(LatLng latLng) async {
    final url = Uri.parse(
        "https://nominatim.openstreetmap.org/reverse?lat=${latLng.latitude}&lon=${latLng.longitude}&format=json");

    final response = await http.get(url, headers: {
      'User-Agent': 'flutter_map_example_app',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["address"]["city"] ??
          data["address"]["town"] ??
          data["address"]["village"] ??
          "Unknown location";
    } else {
      return "Unknown location";
    }
  }

  void selectLocation(LatLng location) {
    _locationVersion++;
    emit(LocationLoaded(location, ''));
  }

  Future<void> searchLocation(String query) async {
    if (query.isEmpty) return;
    final version = ++_locationVersion;
    try {
      final url = Uri.https('nominatim.openstreetmap.org', '/search', {
        'q': query,
        'format': 'json',
        'limit': '1',
      });

      final response = await http.get(url, headers: {
        'User-Agent': 'flutter_map_example_app',
      });

      if (isClosed || version != _locationVersion) return;
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        if (data.isNotEmpty) {
          final lat = double.parse(data[0]["lat"]);
          final lon = double.parse(data[0]["lon"]);
          final displayName = data[0]["display_name"];
          emit(LocationLoaded(LatLng(lat, lon), displayName));
        } else {
          emit(LocationError("Location not found"));
        }
      }
    } catch (e) {
      if (!isClosed && version == _locationVersion) {
        emit(LocationError(e.toString()));
      }
    }
  }
}
