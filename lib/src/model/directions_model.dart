import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsModel {
  int distanceValue;
  int duractionValue;
  String distanceText;
  String duractionText;
  String encodePoints;
  LatLngBounds bounds;

  DirectionsModel({
    required this.distanceValue,
    required this.duractionValue,
    required this.distanceText,
    required this.duractionText,
    required this.encodePoints,
    required this.bounds,
  });
}
