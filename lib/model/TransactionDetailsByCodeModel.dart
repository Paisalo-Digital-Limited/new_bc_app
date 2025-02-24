// To parse this JSON data, do
//
//     final transactionDetailsByCodeModel = transactionDetailsByCodeModelFromJson(jsonString);

import 'dart:convert';

TransactionDetailsByCodeModel transactionDetailsByCodeModelFromJson(String str) => TransactionDetailsByCodeModel.fromJson(json.decode(str));

String transactionDetailsByCodeModelToJson(TransactionDetailsByCodeModel data) => json.encode(data.toJson());

class TransactionDetailsByCodeModel {
  int statusCode;
  String message;
  List<TransData> data;

  TransactionDetailsByCodeModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory TransactionDetailsByCodeModel.fromJson(Map<String, dynamic> json) => TransactionDetailsByCodeModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<TransData>.from(json["data"].map((x) => TransData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TransData {
  String transactionType;
  double numTransactionsOrAvgBal;

  TransData({
    required this.transactionType,
    required this.numTransactionsOrAvgBal,
  });

  factory TransData.fromJson(Map<String, dynamic> json) => TransData(
    transactionType: json["transactionType"],
    numTransactionsOrAvgBal: json["numTransactionsOrAvgBal"],
  );

  Map<String, dynamic> toJson() => {
    "transactionType": transactionType,
    "numTransactionsOrAvgBal": numTransactionsOrAvgBal,
  };
}
