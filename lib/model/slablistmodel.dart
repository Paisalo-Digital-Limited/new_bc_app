// To parse this JSON data, do
//
//     final slabListModel = slabListModelFromJson(jsonString);

import 'dart:convert';

SlabListModel slabListModelFromJson(String str) => SlabListModel.fromJson(json.decode(str));

String slabListModelToJson(SlabListModel data) => json.encode(data.toJson());

class SlabListModel {
  int statusCode;
  String message;
  List<SlabListData> data;

  SlabListModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory SlabListModel.fromJson(Map<String, dynamic> json) => SlabListModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<SlabListData>.from(json["data"].map((x) => SlabListData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SlabListData {
  String slab;
  int pmjdy;
  int pmjjby;
  int pmsby;
  int apy;
  int incentive;
  int balanceMainFee;

  SlabListData({
    required this.slab,
    required this.pmjdy,
    required this.pmjjby,
    required this.pmsby,
    required this.apy,
    required this.incentive,
    required this.balanceMainFee,
  });

  factory SlabListData.fromJson(Map<String, dynamic> json) => SlabListData(
    slab: json["slab"],
    pmjdy: json["pmjdy"],
    pmjjby: json["pmjjby"],
    pmsby: json["pmsby"],
    apy: json["apy"],
    incentive: json["incentive"],
    balanceMainFee: json["balanceMainFee"],
  );

  Map<String, dynamic> toJson() => {
    "slab": slab,
    "pmjdy": pmjdy,
    "pmjjby": pmjjby,
    "pmsby": pmsby,
    "apy": apy,
    "incentive": incentive,
    "balanceMainFee": balanceMainFee,
  };
}
