class AddressModel {
  final String placeId;
  final String placeName;
  final double latitude;
  final double longitude;

  AddressModel({
    required this.placeId,
    required this.placeName,
    required this.latitude,
    required this.longitude,
  });
/*
  static AddressModel fromMap(Map<String, dynamic> map) {
   
    return AddressModel(
      placeId: map['place_id'],
      placeName: map['name'],
      latitude: map['geometry']['location']['lat'],
      longitude: map['geometry']['location']['lng'],
    );
  }
  */
}
