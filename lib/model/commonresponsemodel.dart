// To parse this JSON data, do
//
//     final commonResponseModel = commonResponseModelFromJson(jsonString);

import 'dart:convert';

CommonResponseModel commonResponseModelFromJson(String str) => CommonResponseModel.fromJson(json.decode(str));

String commonResponseModelToJson(CommonResponseModel data) => json.encode(data.toJson());

class CommonResponseModel {
    int statusCode;
    String message;
    String data;

    CommonResponseModel({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    factory CommonResponseModel.fromJson(Map<String, dynamic> json) => CommonResponseModel(
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
