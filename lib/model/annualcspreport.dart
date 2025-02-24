// To parse this JSON data, do
//
//     final cspAnnualReport = cspAnnualReportFromJson(jsonString);

import 'dart:async';
import 'dart:convert';

CspAnnualReport cspAnnualReportFromJson(String str) => CspAnnualReport.fromJson(json.decode(str));

String cspAnnualReportToJson(CspAnnualReport data) => json.encode(data.toJson());

class CspAnnualReport {
  int statusCode;
  String message;
  List<Datum> data;

  CspAnnualReport({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CspAnnualReport.fromJson(Map<String, dynamic> json) => CspAnnualReport(
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
  double numTransactionsOrAvgBal;
  int totalCommission;
  double payableToCsp;
  String year;
  String month;
  double gst;

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
    required this.gst
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    circleName: json["circleName"],
    population: json["population"]??"",
    cspName: json["cspName"],
    cspCode: json["cspCode"]!,
    transactionType: json["transactionType"],
    numTransactionsOrAvgBal: json["numTransactionsOrAvgBal"]?.toDouble(),
    totalCommission: json["totalCommission"],
    payableToCsp: json["payableToCSP"]?.toDouble(),
    year: json["year"]??"",
    month: json["month"]??"",
    gst: json["gst"]??0,
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
    "gst": gst
  };
}



class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
