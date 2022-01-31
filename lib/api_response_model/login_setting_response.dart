// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginSettingResponse loginSettingResponseFromJson(String str) => LoginSettingResponse.fromJson(json.decode(str));

String loginSettingResponseToJson(LoginSettingResponse data) => json.encode(data.toJson());

class LoginSettingResponse {
  String status;
  String message;
  int gsuite;

  LoginSettingResponse({
    this.status,
    this.message,
    this.gsuite,
  });

  factory LoginSettingResponse.fromJson(Map<String, dynamic> json) => LoginSettingResponse(
    status: json["status"],
    message: json["message"],
    gsuite: json["gsuite"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "gsuite": gsuite,
  };
}
