import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class PermissionsController extends GetxController {
  Location location = Location();

  static PermissionsController get to => Get.find<PermissionsController>();

  Future<bool?> currentPosition() async {
    LocationPermission permisssao;
    bool ativado = await Geolocator.isLocationServiceEnabled();

    if (!ativado) {
      return Future.error('Por favor, habilite a localização no smartphone!');
    }

    permisssao = await Geolocator.checkPermission();
    if (permisssao == LocationPermission.denied) {
      permisssao = await Geolocator.requestPermission();

      if (permisssao == LocationPermission.denied) {
        return Future.error('Você precisa autorizar o acesso à localização.');
      }
    }

    if (permisssao == LocationPermission.deniedForever) {
      return Future.error('Autorize o acesso à localização nas configurações.');
    }

    return true;
  }
}
