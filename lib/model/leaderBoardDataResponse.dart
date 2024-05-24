// To parse this JSON data, do
//
//     final leaderBoardDataResponse = leaderBoardDataResponseFromJson(jsonString);

import 'dart:convert';

LeaderBoardDataResponse leaderBoardDataResponseFromJson(String str) => LeaderBoardDataResponse.fromJson(json.decode(str));

String leaderBoardDataResponseToJson(LeaderBoardDataResponse data) => json.encode(data.toJson());

class LeaderBoardDataResponse {
  int statusCode;
  String message;
  List<Datum> data;

  LeaderBoardDataResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LeaderBoardDataResponse.fromJson(Map<String, dynamic> json) => LeaderBoardDataResponse(
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
  double payableToCsp;
  String month;
  String year;

  Datum({
    required this.cspCode,
    required this.cspName,
    required this.payableToCsp,
    required this.month,
    required this.year,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    cspCode: json["cspCode"],
    cspName: json["cspName"],
    payableToCsp: json["payableToCSP"]?.toDouble(),
    month: json["month"]!,
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "cspCode": cspCode,
    "cspName": cspName,
    "payableToCSP": payableToCsp,
    "month": month,
    "year": year,
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
