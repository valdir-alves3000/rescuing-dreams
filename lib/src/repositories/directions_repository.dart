import 'package:dio/dio.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rescuing_dreams/src/model/directions.dart';
import 'package:rescuing_dreams/src/config/.env.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      final response = await Dio().get(
        _baseUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': googleAPIKey,
        },
      );

      // Get route information
      final data = response.data['routes'][0];

      // Bounds
      final northeast = data['bounds']['northeast'];
      final southwest = data['bounds']['southwest'];
      final bounds = LatLngBounds(
        northeast: LatLng(northeast['lat'], northeast['lng']),
        southwest: LatLng(southwest['lat'], southwest['lng']),
      );

      // Distance & Duration
      String distanceText = '';
      String durationText = '';
      int distanceValue = 0;
      int durationValue = 0;
      
      if ((data['legs'] as List).isNotEmpty) {
        final legs = data['legs'][0];
        distanceText = legs['distance']['text'];
        durationText = legs['duration']['text'];
        distanceValue = legs['duration']['value'];
        durationValue = legs['duration']['value'];
      }

      return Directions(
        bounds: bounds,
        polylinePoints: PolylinePoints()
            .decodePolyline(data['overview_polyline']['points']),
        distanceText: distanceText,
        durationText: durationText,
        distanceValue: distanceValue,
        durationValue: durationValue,
      );
    } catch (e) {
      return null;
    }
  }
}
