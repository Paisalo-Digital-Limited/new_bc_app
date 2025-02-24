// To parse this JSON data, do
//
//     final cspkycDocumentModel = cspkycDocumentModelFromJson(jsonString);

import 'dart:convert';

CspkycDocumentModel cspkycDocumentModelFromJson(String str) => CspkycDocumentModel.fromJson(json.decode(str));

String cspkycDocumentModelToJson(CspkycDocumentModel data) => json.encode(data.toJson());

class CspkycDocumentModel {
  int statusCode;
  String message;
  List<Datum> data;

  CspkycDocumentModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CspkycDocumentModel.fromJson(Map<String, dynamic> json) => CspkycDocumentModel(
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
  String cspCode;
  String cspName;
  String docType;
  String docPath;
  String creationDate;

  Datum({
    required this.cspCode,
    required this.cspName,
    required this.docType,
    required this.docPath,
    required this.creationDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    cspCode: json["cspCode"],
    cspName: json["cspName"],
    docType: json["docType"],
    docPath: json["docPath"],
    creationDate: json["creationDate"],
  );

  Map<String, dynamic> toJson() => {
    "cspCode": cspCode,
    "cspName": cspName,
    "docType": docType,
    "docPath": docPath,
    "creationDate": creationDate,
  };
}
