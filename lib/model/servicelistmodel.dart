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
  String name;
  List<DatumDatum> data;

  ServiceListModelDatum({
    required this.name,
    required this.data,
  });

  factory ServiceListModelDatum.fromJson(Map<String, dynamic> json) => ServiceListModelDatum(
    name: json["name"],
    data: List<DatumDatum>.from(json["data"].map((x) => DatumDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DatumDatum {
  int id;
  dynamic transactionId;
  String transactionType;
  String amtType;
  String rangeA;
  String rangeB;
  String percentageMax;
  String maxAmt;
  String areaType;

  DatumDatum({
    required this.id,
    required this.transactionId,
    required this.transactionType,
    required this.amtType,
    required this.rangeA,
    required this.rangeB,
    required this.percentageMax,
    required this.maxAmt,
    required this.areaType,
  });

  factory DatumDatum.fromJson(Map<String, dynamic> json) => DatumDatum(
    id: json["id"],
    transactionId: json["transactionId"],
    transactionType: json["transactionType"],
    amtType: json["amtType"],
    rangeA: json["rangeA"],
    rangeB: json["rangeB"],
    percentageMax: json["percentageMax"],
    maxAmt: json["maxAmt"],
    areaType: json["areaType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transactionId": transactionId,
    "transactionType": transactionType,
    "amtType": amtType,
    "rangeA": rangeA,
    "rangeB": rangeB,
    "percentageMax": percentageMax,
    "maxAmt": maxAmt,
    "areaType": areaType,
  };
}
