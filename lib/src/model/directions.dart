import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String distanceText;
  final int distanceValue;
  final String durationText;
  final int durationValue;

  const Directions({
    required this.bounds,
    required this.polylinePoints,
    required this.distanceText,
    required this.distanceValue,
    required this.durationText,
    required this.durationValue,
  });
}
