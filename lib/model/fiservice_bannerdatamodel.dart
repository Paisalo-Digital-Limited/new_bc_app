// To parse this JSON data, do
//
//     final fiServiceBannerDataModel = fiServiceBannerDataModelFromJson(jsonString);

import 'dart:convert';

FiServiceBannerDataModel fiServiceBannerDataModelFromJson(String str) => FiServiceBannerDataModel.fromJson(json.decode(str));

String fiServiceBannerDataModelToJson(FiServiceBannerDataModel data) => json.encode(data.toJson());

class FiServiceBannerDataModel {
  int statusCode;
  String message;
  String data;

  FiServiceBannerDataModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory FiServiceBannerDataModel.fromJson(Map<String, dynamic> json) => FiServiceBannerDataModel(
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
FiServiceBannerData fiServiceBannerDataFromJson(String str) => FiServiceBannerData.fromJson(json.decode(str));

String fiServiceBannerDataToJson(FiServiceBannerData data) => json.encode(data.toJson());

class FiServiceBannerData{

  int id;
  String advertisement;
  String description;
  String banner;
  bool isActive;
  bool isDeleted;
  DateTime createdOn;
  int createdBy;
  dynamic modifiedOn;
  dynamic modifiedBy;
  String appType;

  FiServiceBannerData({
    required this.id,
    required this.advertisement,
    required this.description,
    required this.banner,
    required this.isActive,
    required this.isDeleted,
    required this.createdOn,
    required this.createdBy,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.appType,
  });

  factory FiServiceBannerData.fromJson(Map<String, dynamic> json) => FiServiceBannerData(
    id: json["Id"],
    advertisement: json["Advertisement"],
    description: json["Description"],
    banner: json["Banner"],
    isActive: json["IsActive"],
    isDeleted: json["IsDeleted"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    createdBy: json["CreatedBy"],
    modifiedOn: json["ModifiedOn"],
    modifiedBy: json["ModifiedBy"],
    appType: json["AppType"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Advertisement": advertisement,
    "Description": description,
    "Banner": banner,
    "IsActive": isActive,
    "IsDeleted": isDeleted,
    "CreatedOn": createdOn.toIso8601String(),
    "CreatedBy": createdBy,
    "ModifiedOn": modifiedOn,
    "ModifiedBy": modifiedBy,
    "AppType": appType,
  };

}
