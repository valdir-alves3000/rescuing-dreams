import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rescuing_dreams/src/controller/guincho_controller.dart';
import 'package:rescuing_dreams/src/model/address_model.dart';
import 'package:rescuing_dreams/src/model/directions_model.dart';
import 'package:rescuing_dreams/src/repositories/guincho_repositiry.dart';
import 'package:rescuing_dreams/src/config/.env.dart';
import 'package:rescuing_dreams/src/resources/dialog/loading_dialog.dart';
import 'package:rescuing_dreams/src/services/directions_api_service.dart';

class MapController extends GetxController {
  Set<Polyline> polylineSet = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final raio = 0.0.obs;

  late StreamSubscription<Position> positionStream;
  LatLng _position = LatLng(-23.6494827, -46.4475031);
  final LatLng _destination = LatLng(-23.64762586916668, -46.44306130707264);

  late GoogleMapController _mapsController;
  final markers = Set<Marker>();

  MapController get to => Get.find<MapController>();
  DirectionsApiService directionsApiService = DirectionsApiService.instance;

  get mapsController => _mapsController;
  get position => _position;
  get destination => _destination;

  String get distancia => raio.value < 1
      ? '${(raio.value * 1000).toStringAsFixed(0)} m'
      : '${(raio.value).toStringAsFixed(1)} Km';

  filtrarGuincho() {
    Get.back();
  }

  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    //getPosicao();
    watchPosicao();
    loadMarkersGuinchos();
  }

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

  watchPosicao() async {
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      // ignore: unnecessary_null_comparison
      if (position == null) {
        latitude.value = position.latitude;
        longitude.value = position.longitude;
      }
    });
  }

  @override
  void onClose() {
    positionStream.cancel();
    super.onClose();
  }

  Future<Position> _posicaoAtual() async {
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

  getPosicao() async {
    try {
      final posicao = await _posicaoAtual();
      latitude.value = posicao.latitude;
      longitude.value = posicao.longitude;

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

  getPositionDestination(AddressModel address) async {
    try {
      destination.latitude = address.latitude;
      destination.longitude = address.longitude;
    } catch (e) {
      return null;
    }
  }

  addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      geodesic: true,
    );
    // polylines[id] = polyline;
  }

  getPolyline(DirectionsModel details) async {
    print('details: ');
    print(details);
    // List<PointLatLng> decodedPolyLinePointsResult = polylinePoints.decodePolyline(details.encodePooints);

    /*
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(_position.latitude, _position.longitude),
        PointLatLng(_destination.latitude, _destination.longitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    addPolyLine();
    update();
    */
  }
}
