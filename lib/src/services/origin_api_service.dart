import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:rescuing_dreams/src/config/.env.dart';
import 'package:rescuing_dreams/src/controller/map_controller.dart';

class OriginApiService {
  OriginApiService._internal();
  static OriginApiService get instance => OriginApiService._internal();
  // final Dio _dio = Dio();

  MapController mapController = MapController();

  Future<String> placeIdOrigin() async {
    late Location location = Location();
    LocationData currentPosition = await location.getLocation();

    try {
      final response = await Dio().get(
          'https://maps.googleapis.com/maps/api/geocode/json',
          queryParameters: {
            "key": googleAPIKey,
            "latlng":
                '${currentPosition.latitude},${currentPosition.longitude}',
          });

      var res = response.data['results'][0];

      String origin = res['formatted_address'];

      return origin;
    } catch (e) {
      return '';
    }
  }
}
