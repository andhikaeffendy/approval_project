// To parse this JSON data, do
//
//     final formReject = formRejectFromJson(jsonString);

import 'dart:convert';

FormReject formRejectFromJson(String str) => FormReject.fromJson(json.decode(str));

String formRejectToJson(FormReject data) => json.encode(data.toJson());

class FormReject {
  String status;
  String message;

  FormReject({
    this.status,
    this.message,
  });

  factory FormReject.fromJson(Map<String, dynamic> json) => FormReject(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
