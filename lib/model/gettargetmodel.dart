// To parse this JSON data, do
//
//     final getTargetModel = getTargetModelFromJson(jsonString);

import 'dart:convert';

GetTargetModel getTargetModelFromJson(String str) => GetTargetModel.fromJson(json.decode(str));

String getTargetModelToJson(GetTargetModel data) => json.encode(data.toJson());

class GetTargetModel {
  int statusCode;
  String message;
  List<Datum> data;

  GetTargetModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetTargetModel.fromJson(Map<String, dynamic> json) => GetTargetModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String kOId;
  int targetCommAmt;
  String month;
  int year;

  Datum({
    required this.id,
    required this.kOId,
    required this.targetCommAmt,
    required this.month,
    required this.year,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    kOId: json["kO_ID"],
    targetCommAmt: json["targetCommAmt"],
    month: json["month"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "kO_ID": kOId,
    "targetCommAmt": targetCommAmt,
    "month": month,
    "year": year,
  };
}
