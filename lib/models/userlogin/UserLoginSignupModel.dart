import 'dart:convert';

UserLoginSignupModel userLoginSignupModelFromJson(String str) => UserLoginSignupModel.fromJson(json.decode(str));

String userLoginSignupModelToJson(UserLoginSignupModel data) => json.encode(data.toJson());

class UserLoginSignupModel {
  String username;
  String password;

  UserLoginSignupModel({
    this.username,
    this.password,
  });

  factory UserLoginSignupModel.fromJson(Map<String, dynamic> json) => new UserLoginSignupModel(
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}
