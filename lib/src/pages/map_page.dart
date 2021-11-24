import 'dart:ui';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:rescuing_dreams/src/controller/map_controller.dart';
import 'package:rescuing_dreams/src/model/places_model.dart';
import 'package:rescuing_dreams/src/services/origin_api_service.dart';
import 'package:rescuing_dreams/src/services/place_api_service.dart';
import 'package:rescuing_dreams/src/widgets/appbar_widget.dart';
import 'package:rescuing_dreams/src/widgets/divider_widget.dart';
import 'package:rescuing_dreams/src/widgets/draggable_widget.dart';
import 'package:rescuing_dreams/src/widgets/drawer_directions.dart';
import 'package:rescuing_dreams/src/widgets/drawer_widget.dart';
import 'package:rescuing_dreams/src/widgets/pick_place_map.dart';
import 'package:rescuing_dreams/src/widgets/prediction_tile_widget.dart';

const double _minHeight = 200;
double _maxHeight = MediaQueryData.fromWindow(window).size.height - 100;

class MapPage extends StatefulWidget {
  static const String idPage = '/mapPage';
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _originController = TextEditingController();
  final mapsController = Get.put(MapController());
  final OriginApiService _originApiService = OriginApiService.instance;
  final PlaceApiService _placeApi = PlaceApiService.instance;

  late bool _loading = false;

  late AnimationController _animationController;
  double _currentHeight = _minHeight;

  List<PlacesModel> _predictions = [];
  String _originText = 'Seu Local';

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 650),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      body: GetBuilder<MapController>(
        init: mapsController,
        builder: (_) => Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              height: MediaQuery.of(context).size.height - 200,
              child: GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: mapsController.position,
                  zoom: 15,
                ),
                onMapCreated: mapsController.onMapCreated,
                markers: mapsController.markers,
                onLongPress: setPolyline,
                polylines: {
                  if (mapsController.data != null)
                    Polyline(
                      polylineId: const PolylineId('overview_polyline'),
                      color: Colors.indigo.shade400,
                      jointType: JointType.round,
                      width: 5,
                      startCap: Cap.roundCap,
                      endCap: Cap.roundCap,
                      geodesic: true,
                      points: mapsController.polylineCoordinates,
                    ),
                },
              ),
            ),
            Positioned(
              top: 50,
              left: 22,
              child: GestureDetector(
                onTap: () {
                  if (mapsController.data != null) {
                    resetData();
                  } else {
                    scaffoldkey.currentState!.openDrawer();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 6,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      mapsController.data == null ? Icons.menu : Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            if (mapsController.data != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: DrawerDirections(
                  distance: mapsController.data.distanceText,
                  duraction: mapsController.data.durationText,
                  amount: mapsController.calculateFares(),
                  onPress: createUserResgate,
                ),
              ),
            if (mapsController.data == null)
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  onVerticalDragUpdate(details);
                },
                onVerticalDragEnd: (details) {
                  onVerticalDragEnd();
                },
                child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, snapshop) {
                      final value = _animationController.value;
                      return Stack(
                        children: [
                          Positioned(
                            height: lerpDouble(_minHeight, _maxHeight, value),
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: DraggableWidget(onOpenAnimation),
                          ),
                        ],
                      );
                    }),
              ),
            AnimatedBuilder(
                animation: _animationController,
                builder: (context, snapshop) {
                  return Positioned(
                    left: 0,
                    top: -180 * (1 - _animationController.value),
                    right: 0,
                    child: Column(
                      children: [
                        Container(
                          height: 180,
                          child: AppBarWidget(
                            destinationController: _destinationController,
                            onChanged: inputOnChanged,
                            onPress: onCloseAnimation,
                            onTap: () {},
                            originController: _originController,
                            originText: _originText,
                          ),
                        ),
                        (_predictions.length > 0)
                            ? ListView.separated(
                                padding: EdgeInsets.all(10),
                                itemBuilder: (context, index) {
                                  return PredirectionTileWidget(
                                    setPolyline: setPolyline,
                                    placeIdDestination:
                                        _predictions[index].placeId,
                                    onPress: onCloseAnimation,
                                    mainText:
                                        _predictions[index].mainText.toString(),
                                    secondaryText: _predictions[index]
                                        .secondaryText
                                        .toString(),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        DividerWidget(),
                                itemCount: _predictions.length,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                              )
                            : Container(),
                      ],
                    ),
                  );
                }),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: PickPlaceMap(),
            ),
          ],
        ),
      ),
      drawer: DrawerWidget(
        closeDrawer: closeOpenDrawer,
      ),
      drawerEnableOpenDragGesture: false,
    );
  }

  void closeOpenDrawer() {
    scaffoldkey.currentState!.openEndDrawer();
  }

  void onCloseAnimation() {
    setState(() {
      _animationController.reverse();
      _currentHeight = 0.0;
      _destinationController.clear();
      _predictions = [];
    });
  }

  void onOpenAnimation() {
    setState(() {
      _animationController.forward(from: 1.0);
      _currentHeight = _maxHeight;

      _originApiService.placeIdOrigin().asStream().listen((event) {
        if (event != '') {
          setState(() {
            _originText = event;
          });
        }
      });
    });
  }

  void inputOnChanged(String query) {
    if (query.trim().length > 2) {
      setState(() {
        _loading = true;
      });

      searchInput(query);
    } else {
      if (_loading || _predictions.length > 0) {
        setState(() {
          _loading = false;
          _predictions = [];
        });
      }
    }
  }

  void searchInput(String query) async {
    _placeApi.searchPredictions(query).asStream().listen((event) {
      if (event != null) {
        setState(() {
          _loading = false;
          _predictions = event;
        });
      }
    });
  }

  void setPolyline(LatLng position) async {
    await mapsController.setPolyline(position);
  }

  void resetData() async {
    await mapsController.resetData();
  }

  void createUserResgate() async {
    mapsController.createUserResgate();
  }

  void onVerticalDragUpdate(details) {
    setState(() {
      final newHeight = _currentHeight - details.delta.dy;
      _animationController.value = _currentHeight / _maxHeight;
      _currentHeight = newHeight.clamp(0.0, _maxHeight);
    });
  }

  void onVerticalDragEnd() {
    if (_currentHeight < _maxHeight / 2) {
      setState(() {
        _animationController.reset();
      });
    } else {
      setState(() {
        _animationController.forward(from: _currentHeight / _maxHeight);
        _currentHeight = _maxHeight;
      });
    }
  }
}
