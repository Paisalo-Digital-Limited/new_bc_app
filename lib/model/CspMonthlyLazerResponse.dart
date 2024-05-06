// To parse this JSON data, do
//
//     final cspMonthlyLazerResponse = cspMonthlyLazerResponseFromJson(jsonString);

import 'dart:convert';

CspMonthlyLazerResponse cspMonthlyLazerResponseFromJson(String str) => CspMonthlyLazerResponse.fromJson(json.decode(str));

String cspMonthlyLazerResponseToJson(CspMonthlyLazerResponse data) => json.encode(data.toJson());

class CspMonthlyLazerResponse {
  int statusCode;
  String message;
  List<Datum> data;

  CspMonthlyLazerResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CspMonthlyLazerResponse.fromJson(Map<String, dynamic> json) => CspMonthlyLazerResponse(
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
  String circleName;
  String population;
  String cspName;
  String cspCode;
  String transactionType;
  int numTransactionsOrAvgBal;
  int totalCommission;
  double payableToCsp;
  String year;
  String month;

  Datum({
    required this.circleName,
    required this.population,
    required this.cspName,
    required this.cspCode,
    required this.transactionType,
    required this.numTransactionsOrAvgBal,
    required this.totalCommission,
    required this.payableToCsp,
    required this.year,
    required this.month,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    circleName: json["circleName"]??"",
    population: json["population"]??"",
    cspName: json["cspName"]??"",
    cspCode: json["cspCode"]??"",
    transactionType: json["transactionType"]??"",
    numTransactionsOrAvgBal: json["numTransactionsOrAvgBal"],
    totalCommission: json["totalCommission"],
    payableToCsp: json["payableToCSP"]?.toDouble(),
    year: json["year"],
    month: json["month"],
  );

  Map<String, dynamic> toJson() => {
    "circleName": circleName,
    "population": population,
    "cspName": cspName,
    "cspCode": cspCode,
    "transactionType": transactionType,
    "numTransactionsOrAvgBal": numTransactionsOrAvgBal,
    "totalCommission": totalCommission,
    "payableToCSP": payableToCsp,
    "year": year,
    "month": month,
  };
}
