class CityModel {
  final int cityId;
  final String cityName;

  CityModel({required this.cityId, required this.cityName});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(cityId: json["CityId"], cityName: json["CityName"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'CityId': cityId,
      'CityName': cityName,
    };
  }
}
