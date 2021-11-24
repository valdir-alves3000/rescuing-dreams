import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rescuing_dreams/src/fire_base/fire_base_auth.dart';
import 'package:rescuing_dreams/src/model/directions.dart';
import 'package:rescuing_dreams/src/repositories/MechanicsRepository.dart';
import 'package:rescuing_dreams/src/repositories/directions_repository.dart';
import 'package:rescuing_dreams/src/repositories/guincho_repositiry.dart';

class MapController extends GetxController {
  FirAuth _firAuth = FirAuth();
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;

  late StreamSubscription<Position> positionStream;
  LatLng _position = LatLng(-23.6494827, -46.4475031);
  LatLng _destination = LatLng(-23.6494827, -46.4475031);
  late GoogleMapController _mapsController;
  final markers = Set<Marker>();
  List<LatLng> polylineCoordinates = [];

  var data;

  static MapController get to => Get.find<MapController>();
  get mapsController => _mapsController;
  get position => _position;
  get destination => _destination;

  onMapCreated(GoogleMapController gmc) {
    _mapsController = gmc;
    watchPosition();
    getPosition();
    loadGuinchos();
  }

  updateCamera() {
    _mapsController.animateCamera(
      data != null
          ? CameraUpdate.newLatLngBounds(data.bounds, 110.0)
          : CameraUpdate.newCameraPosition(CameraPosition(
              target: position,
              zoom: 15,
            )),
    );
  }

  setPolyline(LatLng pos) async {
    Directions? directions = await DirectionsRepository()
        .getDirections(origin: position, destination: pos);

    if (directions != null) {
      data = directions;
      polylineCoordinates.clear();
      data.polylinePoints.forEach((pointLatLng) {
        polylineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarker,
        position: pos,
      ),
    );
    loadMechanics();
    update();
    updateCamera();
  }

  loadGuinchos() async {
    //FirebaseFirestore db = DB.get();
    //final guinchos = await db.collection('guinchos').get();
    final guinchos = GuinchosRepository().Guinchos;
    String icon = 'assets/images/tow-truck.png';
    guinchos.forEach((guincho) => addMarker(guincho, icon));
  }

  loadMechanics() {
    String icon = 'assets/images/mechanic.png';
    final mecanics = MechanicsRepository().Mechanics;
    mecanics.forEach((mecanic) => addMarker(mecanic, icon));
  }

  addMarker(marker, icon) async {
    markers.add(
      Marker(
        markerId: MarkerId(marker.nome),
        position: LatLng(marker.latitude, marker.longitude),
        infoWindow: InfoWindow(title: marker.nome),
        onTap: () => {},
        icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(),
          icon,
        ),
      ),
    );
    update();
  }

  watchPosition() async {
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      _position = LatLng(position.latitude, position.longitude);
      _destination = LatLng(position.latitude, position.longitude);
    });
  }

  Future<Position> _currentPosition() async {
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

    return await Geolocator.getCurrentPosition();
  }

  getPosition() async {
    try {
      final currentPositon = await _currentPosition();
      latitude.value = currentPositon.latitude;
      longitude.value = currentPositon.longitude;

      _mapsController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(latitude.value, longitude.value),
        ),
      );
    } catch (e) {
      Get.snackbar(
        'Erro',
        e.toString(),
        backgroundColor: Colors.grey[900],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  calculateFares() {
    double timeTraveledFare = (data.durationValue / 60 * 0.2);
    double distanceTraveledFare = (data.distanceValue * 0.0203);
    double totalFareAmount = 42 + timeTraveledFare + distanceTraveledFare;

    return totalFareAmount.truncate();
  }

  resetData() {
    polylineCoordinates.clear();
    markers.clear();
    data = null;
    update();
  }

  void createUserResgate() {
    _firAuth.createUserResgate(position, destination, () {});
  }

  @override
  void onClose() {
    positionStream.cancel();
    super.onClose();
  }
}
