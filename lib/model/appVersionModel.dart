// To parse this JSON data, do
//
//     final appVersionModel = appVersionModelFromJson(jsonString);

import 'dart:convert';

AppVersionModel appVersionModelFromJson(String str) => AppVersionModel.fromJson(json.decode(str));

String appVersionModelToJson(AppVersionModel data) => json.encode(data.toJson());

class AppVersionModel {
  int statusCode;
  String message;
  dynamic data; // Change data type to dynamic

  AppVersionModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) => AppVersionModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data,
  };
}