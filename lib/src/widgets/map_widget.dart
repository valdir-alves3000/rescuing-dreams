import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rescuing_dreams/src/controller/guincho_controller.dart';
import 'package:rescuing_dreams/src/controller/map_controller.dart';

class GoogleMapWidget extends StatelessWidget {
  final mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        initialCameraPosition:
            CameraPosition(target: mapController.position, zoom: 15),
        onMapCreated: mapController.onMapCreated,
        markers: mapController.markers,
        //polylines: controller.polylines,
      ),
    );
  }
}
