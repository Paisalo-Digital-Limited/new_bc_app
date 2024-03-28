// To parse this JSON data, do
//
//     final cspAnnualReport = cspAnnualReportFromJson(jsonString);

import 'dart:convert';

CspAnnualReport cspAnnualReportFromJson(String str) => CspAnnualReport.fromJson(json.decode(str));

String cspAnnualReportToJson(CspAnnualReport data) => json.encode(data.toJson());

class CspAnnualReport {
  int statusCode;
  String message;
  List<AnnualReportData> data;

  CspAnnualReport({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CspAnnualReport.fromJson(Map<String, dynamic> json) => CspAnnualReport(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<AnnualReportData>.from(json["data"].map((x) => AnnualReportData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AnnualReportData {
  int id;
  String cspCode;
  String year;
  String fileName;
  dynamic cspApprovalFile;

  AnnualReportData({
    required this.id,
    required this.cspCode,
    required this.year,
    required this.fileName,
    required this.cspApprovalFile,
  });

  factory AnnualReportData.fromJson(Map<String, dynamic> json) => AnnualReportData(
    id: json["id"],
    cspCode: json["cspCode"],
    year: json["year"],
    fileName: json["fileName"],
    cspApprovalFile: json["cspApprovalFile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cspCode": cspCode,
    "year": year,
    "fileName": fileName,
    "cspApprovalFile": cspApprovalFile,
  };
}
