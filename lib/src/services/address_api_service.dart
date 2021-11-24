import 'package:dio/dio.dart';
import 'package:rescuing_dreams/src/config/.env.dart';
import 'package:rescuing_dreams/src/model/address_model.dart';

class AddressApiService {
  AddressApiService._internal();
  static AddressApiService get instance => AddressApiService._internal();
  // final Dio _dio = Dio();

  placeIdAddress(String placeId) async {
    try {
      final response = await Dio().get(
          'https://maps.googleapis.com/maps/api/place/details/json',
          queryParameters: {
            "key": googleAPIKey,
            "place_id": placeId,
          });

      var res = response.data['result'];
      var address = AddressModel(
        placeId: placeId,
        placeName: res['name'],
        latitude: res['geometry']['location']['lat'],
        longitude: res['geometry']['location']['lng'],
      );

      return address;
    } catch (e) {
      return null;
    }
  }
}
