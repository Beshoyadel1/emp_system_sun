import 'package:latlong2/latlong.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final LatLng latLng;
  final String placeName;

  LocationLoaded(this.latLng, this.placeName);
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}
