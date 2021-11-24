// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:rescuing_dreams/src/controller/guincho_controller.dart';
// import 'package:rescuing_dreams/src/controller/location_trancking_controller.dart';
// import 'package:rescuing_dreams/src/controller/map_controller.dart';

// class GoogleMapWidget extends StatelessWidget {
//   final mapController = Get.put(LocationTranckingController());

//   @override
//   Widget build(BuildContext context) {
//     CameraPosition initialCameraPosition = CameraPosition(
//         zoom: 16,
//         // tilt: 80,
//         // bearing: 30,
//         target: mapController.currentLocation);
//     return
//         // mapController.isLoading.value == true
//         //     ? Container(
//         //         height: MediaQuery.of(context).size.height,
//         //         width: MediaQuery.of(context).size.width,
//         //         alignment: Alignment.center,
//         //         child: CircularProgressIndicator(),
//         //       )
//         //     :
//         Padding(
//       padding: const EdgeInsets.only(bottom: 0),
//       child: GetBuilder<LocationTranckingController>(
//         init: mapController,
//         builder: (value) => GoogleMap(
//           mapType: MapType.normal,
//           myLocationEnabled: true,
//           zoomControlsEnabled: false,
//           myLocationButtonEnabled: false,
//           initialCameraPosition: initialCameraPosition,
//           onMapCreated: mapController.onMapCreated,
//           markers: mapController.markers,
//           //polylines: mapController.polylines,
//         ),
//       ),
//     );
//   }
// }
