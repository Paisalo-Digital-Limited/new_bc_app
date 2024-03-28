// To parse this JSON data, do
//
//     final commonResponseModel = commonResponseModelFromJson(jsonString);

import 'dart:convert';

CommonResponseModelInt commonResponseModelFromJson(String str) => CommonResponseModelInt.fromJson(json.decode(str));

String commonResponseModelToJson(CommonResponseModelInt data) => json.encode(data.toJson());

class CommonResponseModelInt {
    int statusCode;
    String message;
    int data;

    CommonResponseModelInt({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    factory CommonResponseModelInt.fromJson(Map<String, dynamic> json) => CommonResponseModelInt(
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
