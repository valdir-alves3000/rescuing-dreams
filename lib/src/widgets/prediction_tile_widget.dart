import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rescuing_dreams/src/resources/dialog/loading_dialog.dart';
import 'package:rescuing_dreams/src/services/address_api_service.dart';
import 'package:rescuing_dreams/src/widgets/divider_widget.dart';

class PredirectionTileWidget extends StatelessWidget {
  AddressApiService addressApiService = AddressApiService.instance;

  String placeIdDestination;
  String mainText;
  String secondaryText;
  Function() onPress;
  Function(LatLng) setPolyline;

  PredirectionTileWidget({
    required this.mainText,
    required this.secondaryText,
    required this.onPress,
    required this.placeIdDestination,
    required this.setPolyline,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.white),
      onPressed: () async {
        LoadingDialog.showLoadingDialog(context, "Loading...");
        var _destination =
            await addressApiService.placeIdAddress(placeIdDestination);

        if (_destination != null) {
          await setPolyline(
              LatLng(_destination.latitude, _destination.longitude));
        }
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
