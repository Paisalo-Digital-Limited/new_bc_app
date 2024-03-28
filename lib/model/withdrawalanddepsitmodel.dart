import 'dart:convert';

WithdrawalAndDepsitModel withdrawalAndDepsitModelFromJson(String str) => WithdrawalAndDepsitModel.fromJson(json.decode(str));

String withdrawalAndDepsitModelToJson(WithdrawalAndDepsitModel data) => json.encode(data.toJson());

class WithdrawalAndDepsitModel {
  int statusCode;
  String message;
  List<WithdrawalDePositData> data;

  WithdrawalAndDepsitModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory WithdrawalAndDepsitModel.fromJson(Map<String, dynamic> json) => WithdrawalAndDepsitModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<WithdrawalDePositData>.from(json["data"].map((x) => WithdrawalDePositData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class WithdrawalDePositData {
  int id;
  String cspCode;
  String amount;
  String reqType;
  String isApproved;
  int approvedBy;

  WithdrawalDePositData({
    required this.id,
    required this.cspCode,
    required this.amount,
    required this.reqType,
    required this.isApproved,
    required this.approvedBy,
  });

  factory WithdrawalDePositData.fromJson(Map<String, dynamic> json) => WithdrawalDePositData(
    id: json["id"],
    cspCode: json["cspCode"],
    amount: json["amount"],
    reqType: json["reqType"],
    isApproved: json["isApproved"],
    approvedBy: json["approvedBy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cspCode": cspCode,
    "amount": amount,
    "reqType": reqType,
    "isApproved": isApproved,
    "approvedBy": approvedBy,
  };
}
