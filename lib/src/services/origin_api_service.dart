import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rescuing_dreams/src/config/.env.dart';
import 'package:rescuing_dreams/src/controller/map_controller.dart';
import 'package:rescuing_dreams/src/model/address_model.dart';

class OriginApiService {
  OriginApiService._internal();
  static OriginApiService get instance => OriginApiService._internal();
  // final Dio _dio = Dio();

  MapController controller = MapController();

  Future placeIdOrigin() async {
    try {
      final response = await Dio().get(
          'https://maps.googleapis.com/maps/api/geocode/json',
          queryParameters: {
            "key": googleAPIKey,
            "latlng":
                '${controller.position.latitude},${controller.position.longitude}',
          });

      print('response Origin: ');
      print(controller.position.latitude);
      print(response.data['results'][0]['formatted_address']);

      var origin = response.data['results'][0]['formatted_address'];
      return origin;
    } catch (e) {
      return '';
    }
  }
}
