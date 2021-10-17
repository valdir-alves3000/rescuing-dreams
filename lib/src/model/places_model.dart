class PlacesModel {
  final String description;
  final String placeId;
  final String mainText;
  final String secondaryText;

  PlacesModel({
    required this.description,
    required this.placeId,
    required this.mainText,
    required this.secondaryText,
  });

  static PlacesModel fromMap(Map<String, dynamic> map) {
        
    return PlacesModel(
      description: map['description'],
      placeId: map['place_id'],
      mainText: map['structured_formatting']['main_text'],
      secondaryText: map['structured_formatting']['secondary_text'],
      );
  }
}
