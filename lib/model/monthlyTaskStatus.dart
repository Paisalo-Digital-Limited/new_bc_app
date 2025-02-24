// To parse this JSON data, do
//
//     final monthlyTaskStatus = monthlyTaskStatusFromJson(jsonString);

import 'dart:convert';

MonthlyTaskStatus monthlyTaskStatusFromJson(String str) => MonthlyTaskStatus.fromJson(json.decode(str));

String monthlyTaskStatusToJson(MonthlyTaskStatus data) => json.encode(data.toJson());

class MonthlyTaskStatus {
  int statusCode;
  String message;
  List<Datum> data;

  MonthlyTaskStatus({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory MonthlyTaskStatus.fromJson(Map<String, dynamic> json) => MonthlyTaskStatus(
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
  String aliasName;
  int targetCount;
  int achieveCount;

  Datum({
    required this.aliasName,
    required this.targetCount,
    required this.achieveCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    aliasName: json["aliasName"],
    targetCount: json["targetCount"],
    achieveCount: json["achieveCount"],
  );

  Map<String, dynamic> toJson() => {
    "aliasName": aliasName,
    "targetCount": targetCount,
    "achieveCount": achieveCount,
  };
}
