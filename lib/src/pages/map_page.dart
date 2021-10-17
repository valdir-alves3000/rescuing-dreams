import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescuing_dreams/src/controller/map_controller.dart';
import 'package:rescuing_dreams/src/model/address_model.dart';
import 'package:rescuing_dreams/src/model/places_model.dart';
import 'package:rescuing_dreams/src/services/origin_api_service.dart';
import 'package:rescuing_dreams/src/services/place_api_service.dart';
import 'package:rescuing_dreams/src/widgets/appbar_widget.dart';
import 'package:rescuing_dreams/src/widgets/divider_widget.dart';
import 'package:rescuing_dreams/src/widgets/draggable_widget.dart';
import 'package:rescuing_dreams/src/widgets/drawer_widget.dart';
import 'package:rescuing_dreams/src/widgets/input_widget.dart';
import 'package:rescuing_dreams/src/widgets/map_widget.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _originController = TextEditingController();
  late String _originText = '';

  final controller = Get.put(MapController());

  late bool _loading = false;
  final PlaceApiService _placeApi = PlaceApiService.instance;
  final OriginApiService _originApiService = OriginApiService.instance;
  List<PlacesModel> _predictions = [];

  late AnimationController _animationController;
  double _currentHeight = _minHeight;

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

  void _onCloseAnimation() {
    setState(() {
      _animationController.reverse();
      _currentHeight = 0.0;
      _destinationController.clear();
      _predictions = [];
    });
  }

  void _onOpenAnimation() {
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

  void _inputOnChanged(String query) {
    if (query.trim().length > 2) {
      setState(() {
        _loading = true;
      });

      _searchInput(query);
    } else {
      if (_loading || _predictions.length > 0) {
        setState(() {
          _loading = false;
          _predictions = [];
        });
      }
    }
  }

  void _searchInput(String query) async {
    _placeApi.searchPredictions(query).asStream().listen((event) {
      if (event != null) {
        setState(() {
          _loading = false;
          _predictions = event;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: GetBuilder<MapController>(
        init: controller,
        builder: (value) => Stack(
          children: [
            GoogleMapWidget(),
            GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  final newHeight = _currentHeight - details.delta.dy;
                  _animationController.value = _currentHeight / _maxHeight;
                  _currentHeight = newHeight.clamp(0.0, _maxHeight);
                });
              },
              onVerticalDragEnd: (details) {
                if (_currentHeight < _maxHeight / 2) {
                  setState(() {
                    _animationController.reset();
                  });
                } else {
                  setState(() {
                    _animationController.forward(
                        from: _currentHeight / _maxHeight);
                    _currentHeight = _maxHeight;
                  });
                }
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
                          child: DraggableWidget(_onOpenAnimation),
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
                            onChanged: _inputOnChanged,
                            onPress: _onCloseAnimation,
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
                                      onPress: _onCloseAnimation,
                                      placeId: _predictions[index].placeId,
                                      mainText: _predictions[index]
                                          .mainText
                                          .toString(),
                                      secondaryText: _predictions[index]
                                          .secondaryText
                                          .toString());
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
      drawer: DrawerWidget(),
      drawerEnableOpenDragGesture: false,
    );
  }
}
