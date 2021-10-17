import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescuing_dreams/src/controller/address_controller.dart';
import 'package:rescuing_dreams/src/controller/map_controller.dart';
import 'package:rescuing_dreams/src/model/address_model.dart';
import 'package:rescuing_dreams/src/model/directions_model.dart';
import 'package:rescuing_dreams/src/resources/dialog/loading_dialog.dart';
import 'package:rescuing_dreams/src/services/directions_api_service.dart';
import 'package:rescuing_dreams/src/widgets/divider_widget.dart';

class PredirectionTileWidget extends StatelessWidget {
  final AddressController addressController = AddressController();
  final MapController mapController = MapController();
  final DirectionsApiService directionsApiService =
      DirectionsApiService.instance;
  String placeId;
  String mainText;
  String secondaryText;
  Function() onPress;

  PredirectionTileWidget({
    required this.placeId,
    required this.mainText,
    required this.secondaryText,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.white),
      onPressed: () async {
        LoadingDialog.showLoadingDialog(context, "Loading...");
        print(placeId);
        await addressController.getPlaceAddressDetails(placeId, context);
        var directionsDetails = await directionsApiService.placeIdDirections(
            'ChIJlW8enlRpzpQRD9nlNlrDZ5Q', placeId);
        mapController.getPolyline(directionsDetails);
        LoadingDialog.hideLoadingDialog(context);
        onPress();
      },
      child: Column(
        children: [
          DividerWidget(),
          SizedBox(width: 10),
          Row(
            children: [
              SizedBox(width: 20),
              Icon(
                Icons.add_location,
                color: Colors.green,
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text('$mainText',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16, color: Colors.black54)),
                    SizedBox(height: 3),
                    Text('$secondaryText',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
