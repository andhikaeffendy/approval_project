// To parse this JSON data, do
//
//     final formSignature = formSignatureFromJson(jsonString);

import 'dart:convert';

FormSignature formSignatureFromJson(String str) => FormSignature.fromJson(json.decode(str));

String formSignatureToJson(FormSignature data) => json.encode(data.toJson());

class FormSignature {
  String status;
  String message;

  FormSignature({
    this.status,
    this.message,
  });

  factory FormSignature.fromJson(Map<String, dynamic> json) => FormSignature(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
