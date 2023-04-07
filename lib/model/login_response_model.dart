class LoginResponseModel {
  final String userId;
  final String message;

  LoginResponseModel({required this.userId, required this.message});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(userId: json["userId"], message: json["message"]);
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'message': message};
  }
}
