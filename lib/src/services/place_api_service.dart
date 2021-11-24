import 'package:dio/dio.dart';
import 'package:rescuing_dreams/src/config/.env.dart';
import 'package:rescuing_dreams/src/model/places_model.dart';

class PlaceApiService {
  PlaceApiService._internal();
  static PlaceApiService get instance => PlaceApiService._internal();
  //final Dio _dio = Dio();

  //static final String androidKey = googleAPIKey;
  //static final String iosKey = googleAPIKey;
  //final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<PlacesModel>?> searchPredictions(String input) async {
    try {
      final response = await Dio().get(
          "https://maps.googleapis.com/maps/api/place/autocomplete/json",
          queryParameters: {
            "input": input,
            "key": googleAPIKey,
            "types": "geocode",
            "language": "pt_BR",
          });

      var res = response.data['predictions']
          .map<PlacesModel>((e) => PlacesModel.fromMap(e))
          .toList() as List<PlacesModel>;

      return res;
    } catch (e) {
      return null;
    }
  }
}
