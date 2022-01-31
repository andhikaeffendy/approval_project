// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginEmailResponse loginEmailResponseFromJson(String str) => LoginEmailResponse.fromJson(json.decode(str));

String loginEmailResponseToJson(LoginEmailResponse data) => json.encode(data.toJson());

class LoginEmailResponse {
  String status;
  String message;
  String name;
  String id_token;

  LoginEmailResponse({
    this.status,
    this.message,
    this.name,
    this.id_token,
  });

  factory LoginEmailResponse.fromJson(Map<String, dynamic> json) => LoginEmailResponse(
    status: json["status"],
    message: json["message"],
    name: json["name"],
    id_token: json["id_token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "name": name,
    "id_token": id_token,
  };
}
