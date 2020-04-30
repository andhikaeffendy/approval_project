// To parse this JSON data, do
//
//     final formApprove = formApproveFromJson(jsonString);

import 'dart:convert';

FormApprove formApproveFromJson(String str) => FormApprove.fromJson(json.decode(str));

String formApproveToJson(FormApprove data) => json.encode(data.toJson());

class FormApprove {
  String status;
  String message;

  FormApprove({
    this.status,
    this.message,
  });

  factory FormApprove.fromJson(Map<String, dynamic> json) => FormApprove(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
