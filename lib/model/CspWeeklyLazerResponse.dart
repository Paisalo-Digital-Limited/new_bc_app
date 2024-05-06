// To parse this JSON data, do
//
//     final cspWeeklyLazerResponse = cspWeeklyLazerResponseFromJson(jsonString);

import 'dart:convert';

CspWeeklyLazerResponse cspWeeklyLazerResponseFromJson(String str) => CspWeeklyLazerResponse.fromJson(json.decode(str));

String cspWeeklyLazerResponseToJson(CspWeeklyLazerResponse data) => json.encode(data.toJson());

class CspWeeklyLazerResponse {
  int statusCode;
  String message;
  List<Datum> data;

  CspWeeklyLazerResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CspWeeklyLazerResponse.fromJson(Map<String, dynamic> json) => CspWeeklyLazerResponse(
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
  double payableToCsp;
  String dayOfWeek;

  Datum({
    required this.payableToCsp,
    required this.dayOfWeek,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    payableToCsp: json["payableToCSP"]?.toDouble(),
    dayOfWeek: json["dayOfWeek"],
  );

  Map<String, dynamic> toJson() => {
    "payableToCSP": payableToCsp,
    "dayOfWeek": dayOfWeek,
  };
}
