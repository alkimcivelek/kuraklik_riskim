import 'package:kuraklik_riskim/model/city_model.dart';

class RegisterModel {
  final String name;
  final String surname;
  final String email;
  final String profileImage;
  final CityModel city;
  final String password;

  RegisterModel(
      {required this.name,
      required this.surname,
      required this.email,
      required this.profileImage,
      required this.city,
      required this.password});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
        name: json['name'],
        surname: json['surname'],
        email: json['email'],
        profileImage: json['profileImage'],
        city: CityModel.fromJson(
          json['city'],
        ),
        password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'profileImageUrl': profileImage,
      'city': city.toJson(),
      'password': password
    };
  }
}
