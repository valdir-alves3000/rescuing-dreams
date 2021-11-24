import 'package:dio/dio.dart';
import 'package:rescuing_dreams/src/config/.env.dart';
import 'package:rescuing_dreams/src/model/address_model.dart';
import 'package:rescuing_dreams/src/model/directions_model.dart';

class DirectionsApiService {
  DirectionsApiService._internal();
  static DirectionsApiService get instance => DirectionsApiService._internal();
  // final Dio _dio = Dio();

  Future placeIdDirections(
      String placeIdOrigin, String placeIdDestination) async {
    print('place Origin: ');
    print(placeIdOrigin);

    print('place Destination: ');
    print(placeIdDestination);

    try {
      final response = await Dio().get(
          "https://maps.googleapis.com/maps/api/directions/json?destination=place_id%3A$placeIdDestination&origin=place_id%3A$placeIdOrigin&key=$googleAPIKey");
      print('response directions: ');
      print(response.data['routes'][0]);

      var res = response.data['routes'][0];

      DirectionsModel directionsDetails = DirectionsModel(
        distanceValue: res['legs'][0]['distance']['value'],
        duractionValue: res['legs'][0]['duration']['value'],
        distanceText: res['legs'][0]['distance']['text'],
        duractionText: res['legs'][0]['duration']['text'],
        encodePoints: res['overview_polyline']['points'],
        bounds: res,
      );

      return directionsDetails;
    } catch (e) {
      return null;
    }
  }
}
