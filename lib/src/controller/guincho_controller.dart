import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rescuing_dreams/src/controller/map_controller.dart';
import 'package:rescuing_dreams/src/repositories/guincho_repositiry.dart';

class MarkersGuinchoController extends GetxController {
  MarkersGuinchoController get to => Get.find<MarkersGuinchoController>();

  final markers = Set<Marker>();

  loadMarkersGuinchos() async {
    //FirebaseFirestore db = DB.get();
    //final guinchos = await db.collection('guinchos').get();
    final guinchos = GuinchosRepository().Guinchos;
    guinchos.forEach((guincho) async {
      markers.add(
        Marker(
          markerId: MarkerId(guincho.nome),
          position: LatLng(guincho.latitude, guincho.longitude),
          infoWindow: InfoWindow(title: guincho.nome),
          onTap: () => {},
          icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(),
            'assets/images/tow-truck.png',
          ),
        ),
      );
    });
    update();
  }
}
