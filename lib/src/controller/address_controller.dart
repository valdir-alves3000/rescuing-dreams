import 'package:get/get.dart';
import 'package:rescuing_dreams/src/controller/map_controller.dart';
import 'package:rescuing_dreams/src/model/address_model.dart';
import 'package:rescuing_dreams/src/services/address_api_service.dart';

class AddressController extends GetxController {
  MapController guinchosController = MapController();
  final AddressApiService addressApi = AddressApiService.instance;
  late AddressModel addressList;

  static AddressController get to => Get.find<AddressController>();

  getPlaceAddressDetails(String placeId, context) {
    addressApi.placeIdAddress(placeId).asStream().listen((event) {
      if (event != null) {
        addressList = event;
        guinchosController.getPositionDestination(addressList);
      }
    });
  }
}
