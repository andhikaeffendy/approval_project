// To parse this JSON data, do
//
//     final testNotifResponse = testNotifResponseFromJson(jsonString);

import 'dart:convert';

TestNotifResponse testNotifResponseFromJson(String str) => TestNotifResponse.fromJson(json.decode(str));

String testNotifResponseToJson(TestNotifResponse data) => json.encode(data.toJson());

class TestNotifResponse {
  String status;
  String message;

  TestNotifResponse({
    this.status,
    this.message,
  });

  factory TestNotifResponse.fromJson(Map<String, dynamic> json) => TestNotifResponse(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
