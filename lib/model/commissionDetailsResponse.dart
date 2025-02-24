// To parse this JSON data, do
//
//     final commisionDetailsResponse = commisionDetailsResponseFromJson(jsonString);

import 'dart:convert';

CommisionDetailsResponse commisionDetailsResponseFromJson(String str) => CommisionDetailsResponse.fromJson(json.decode(str));

String commisionDetailsResponseToJson(CommisionDetailsResponse data) => json.encode(data.toJson());

class CommisionDetailsResponse {
  int statusCode;
  String message;
  Data data;

  CommisionDetailsResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CommisionDetailsResponse.fromJson(Map<String, dynamic> json) => CommisionDetailsResponse(
    statusCode: json["statusCode"],
    message: json["message"],
    data: Data.fromJson(json["data"]??null),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int comparisonResult;
  double myIncomeResult;
  List<TransactionDetail> transactionDetails;

  Data({
    required this.comparisonResult,
    required this.myIncomeResult,
    required this.transactionDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    comparisonResult: json["comparisonResult"],
    myIncomeResult: json["myIncomeResult"].toDouble(),
    transactionDetails: List<TransactionDetail>.from(json["transactionDetails"].map((x) => TransactionDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "comparisonResult": comparisonResult,
    "myIncomeResult": myIncomeResult,
    "transactionDetails": List<dynamic>.from(transactionDetails.map((x) => x.toJson())),
  };
}

class TransactionDetail {
  String kOId;
  String typeOfTransaction;
  int transactionCount;
  double totalCommission;

  TransactionDetail({
    required this.kOId,
    required this.typeOfTransaction,
    required this.transactionCount,
    required this.totalCommission,
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) => TransactionDetail(
    kOId: json["kO_ID"],
    typeOfTransaction: json["typeOfTransaction"],
    transactionCount: json["transactionCount"],
    totalCommission: json["totalCommission"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "kO_ID": kOId,
    "typeOfTransaction": typeOfTransaction,
    "transactionCount": transactionCount,
    "totalCommission": totalCommission,
  };
}
