import 'dart:convert';

GetCspAppTransactionDetails getCspAppTransactionDetailsFromJson(String str) => GetCspAppTransactionDetails.fromJson(json.decode(str));

String getCspAppTransactionDetailsToJson(GetCspAppTransactionDetails data) => json.encode(data.toJson());

class GetCspAppTransactionDetails {
  int statusCode;
  String message;
  List<Map<String, List<Datum>>> data;

  GetCspAppTransactionDetails({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetCspAppTransactionDetails.fromJson(Map<String, dynamic> json) => GetCspAppTransactionDetails(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<Map<String, List<Datum>>>.from(json["data"].map((x) => Map.from(x).map((k, v) => MapEntry<String, List<Datum>>(k, List<Datum>.from(v.map((x) => Datum.fromJson(x))))))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))))),
  };
}

class Datum {
  String range;
  double rural;
  double urban;
  double cspRuralPercentage;
  double cspUrbanPercentage;
  bool isExpanded;

  Datum({
    required this.range,
    required this.rural,
    required this.urban,
    required this.cspRuralPercentage,
    required this.cspUrbanPercentage,
    this.isExpanded = false,  // initialize as false
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    range: json["range"],
    rural: json["rural"]?.toDouble(),
    urban: json["urban"]?.toDouble(),
    cspRuralPercentage: json["cspRuralPercentage"]?.toDouble(),
    cspUrbanPercentage: json["cspUrbanPercentage"]?.toDouble(),
  );



  Map<String, dynamic> toJson() => {
    "range": range,
    "rural": rural,
    "urban": urban,
    "cspRuralPercentage": cspRuralPercentage,
    "cspUrbanPercentage": cspUrbanPercentage,
  };
}
