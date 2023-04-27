class CityModel {
  final int cityId;
  final String cityName;

  CityModel({required this.cityId, required this.cityName});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(cityId: json["cityid"], cityName: json["cityname"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'cityid': cityId,
      'cityname': cityName,
    };
  }
}
