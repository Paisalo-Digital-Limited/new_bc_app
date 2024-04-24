// To parse this JSON data, do
//
//     final getTaskSlabDetailsResponse = getTaskSlabDetailsResponseFromJson(jsonString);

import 'dart:convert';

GetTaskSlabDetailsResponse getTaskSlabDetailsResponseFromJson(String str) => GetTaskSlabDetailsResponse.fromJson(json.decode(str));

String getTaskSlabDetailsResponseToJson(GetTaskSlabDetailsResponse data) => json.encode(data.toJson());

class GetTaskSlabDetailsResponse {
  int statusCode;
  String message;
  List<SlabData> data;

  GetTaskSlabDetailsResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetTaskSlabDetailsResponse.fromJson(Map<String, dynamic> json) => GetTaskSlabDetailsResponse(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<SlabData>.from(json["data"].map((x) => SlabData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SlabData {
  int id;
  String slabs;
  List<Transaction> transactions;

  SlabData({
    required this.id,
    required this.slabs,
    required this.transactions,
  });

  factory SlabData.fromJson(Map<String, dynamic> json) => SlabData(
    id: json["id"],
    slabs: json["slabs"],
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slabs": slabs,
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
  };
}

class Transaction {
  String transactionType;
  int count;

  Transaction({
    required this.transactionType,
    required this.count,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    transactionType: json["transactionType"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "transactionType": transactionType,
    "count": count,
  };
}
