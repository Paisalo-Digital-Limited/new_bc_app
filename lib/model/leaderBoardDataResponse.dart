// To parse this JSON data, do
//
//     final leaderBoardDataResponse = leaderBoardDataResponseFromJson(jsonString);

import 'dart:convert';

LeaderBoardDataResponse leaderBoardDataResponseFromJson(String str) => LeaderBoardDataResponse.fromJson(json.decode(str));

String leaderBoardDataResponseToJson(LeaderBoardDataResponse data) => json.encode(data.toJson());

class LeaderBoardDataResponse {
  int statusCode;
  String message;
  List<LeaderBoardItemData> data;

  LeaderBoardDataResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LeaderBoardDataResponse.fromJson(Map<String, dynamic> json) => LeaderBoardDataResponse(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<LeaderBoardItemData>.from(json["data"].map((x) => LeaderBoardItemData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class LeaderBoardItemData {
  String koid;
  String cspname;
  double totalCommission;
  dynamic transctionResultVm;

  LeaderBoardItemData({
    required this.koid,
    required this.cspname,
    required this.totalCommission,
    this.transctionResultVm,
  });

  factory LeaderBoardItemData.fromJson(Map<String, dynamic> json) => LeaderBoardItemData(
    koid: json["koid"],
    cspname: json["cspname"],
    totalCommission: json["totalCommission"].toDouble(),
    transctionResultVm: json["transctionResultVm"],
  );

  Map<String, dynamic> toJson() => {
    "koid": koid,
    "cspname": cspname,
    "totalCommission": totalCommission,
    "transctionResultVm": transctionResultVm,
  };
}
