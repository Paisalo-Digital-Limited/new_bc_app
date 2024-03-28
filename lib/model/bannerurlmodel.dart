// To parse this JSON data, do
//
//     final bannerDataModel = bannerDataModelFromJson(jsonString);

import 'dart:convert';

BannerDataModel bannerDataModelFromJson(String str) => BannerDataModel.fromJson(json.decode(str));

String bannerDataModelToJson(BannerDataModel data) => json.encode(data.toJson());

class BannerDataModel {
  int statusCode;
  String message;
  Data data;

  BannerDataModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory BannerDataModel.fromJson(Map<String, dynamic> json) => BannerDataModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int id;
  String advertisement;
  String description;
  String banner;

  Data({
    required this.id,
    required this.advertisement,
    required this.description,
    required this.banner,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    advertisement: json["advertisement"],
    description: json["description"],
    banner: json["banner"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "advertisement": advertisement,
    "description": description,
    "banner": banner,
  };
}
