// To parse this JSON data, do
//
//     final serviceListModel = serviceListModelFromJson(jsonString);

import 'dart:convert';

ServiceListModel serviceListModelFromJson(String str) => ServiceListModel.fromJson(json.decode(str));

String serviceListModelToJson(ServiceListModel data) => json.encode(data.toJson());

class ServiceListModel {
  int statusCode;
  String message;
  List<ServiceListModelDatum> data;

  ServiceListModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ServiceListModel.fromJson(Map<String, dynamic> json) => ServiceListModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<ServiceListModelDatum>.from(json["data"].map((x) => ServiceListModelDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ServiceListModelDatum {
  String type;
  List<DatumDatum> data;

  ServiceListModelDatum({
    required this.type,
    required this.data,
  });

  factory ServiceListModelDatum.fromJson(Map<String, dynamic> json) => ServiceListModelDatum(
    type: json["type"],
    data: List<DatumDatum>.from(json["data"].map((x) => DatumDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DatumDatum {
  String typeOfTransaction;
  String range;
  double rural;
  double urban;
  double cspRuralPercentage;
  double cspUrbanPercentage;

  DatumDatum({
    required this.typeOfTransaction,
    required this.range,
    required this.rural,
    required this.urban,
    required this.cspRuralPercentage,
    required this.cspUrbanPercentage,
  });

  factory DatumDatum.fromJson(Map<String, dynamic> json) => DatumDatum(
    typeOfTransaction: json["typeOfTransaction"],
    range: json["range"],
    rural: json["rural"].toDouble(),
    urban: json["urban"].toDouble(),
    cspRuralPercentage: json["cspRuralPercentage"].toDouble(),
    cspUrbanPercentage: json["cspUrbanPercentage"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "typeOfTransaction": typeOfTransaction,
    "range": range,
    "rural": rural,
    "urban": urban,
    "cspRuralPercentage": cspRuralPercentage,
    "cspUrbanPercentage": cspUrbanPercentage,
  };
}
