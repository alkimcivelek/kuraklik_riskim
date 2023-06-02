class LoginResponseModel {
  final String userId;
  final String message;

  LoginResponseModel({required this.userId, required this.message});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(userId: json["userid"], message: json["token"]);
  }

  Map<String, dynamic> toJson() {
    return {'userid': userId, 'token': message};
  }
}
