// To parse this JSON data, do
//
//     final transHistoryResponse = transHistoryResponseFromJson(jsonString);

import 'dart:convert';

TransHistoryResponse transHistoryResponseFromJson(String str) => TransHistoryResponse.fromJson(json.decode(str));

String transHistoryResponseToJson(TransHistoryResponse data) => json.encode(data.toJson());

class TransHistoryResponse {
    int statusCode;
    String message;
    List<TranDataList> data;

    TransHistoryResponse({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    factory TransHistoryResponse.fromJson(Map<String, dynamic> json) => TransHistoryResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<TranDataList>.from(json["data"].map((x) => TranDataList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class TranDataList {
    int id;
    String cspCode;
    String transactionDateTime;
    String referenceNo;
    String typeOfTransaction;
    String fromAccount;
    String toAccount;
    String amount;
    String customerCharge;
    String journalNumber;
    String status;
    String koHolding;
    dynamic isActive;
    dynamic isDeleted;
    dynamic createdOn;
    dynamic createdBy;
    dynamic modifiedOn;
    dynamic modifiedBy;

    TranDataList({
        required this.id,
        required this.cspCode,
        required this.transactionDateTime,
        required this.referenceNo,
        required this.typeOfTransaction,
        required this.fromAccount,
        required this.toAccount,
        required this.amount,
        required this.customerCharge,
        required this.journalNumber,
        required this.status,
        required this.koHolding,
        required this.isActive,
        required this.isDeleted,
        required this.createdOn,
        required this.createdBy,
        required this.modifiedOn,
        required this.modifiedBy,
    });

    factory TranDataList.fromJson(Map<String, dynamic> json) => TranDataList(
        id: json["id"],
        cspCode: json["cspCode"],
        transactionDateTime: json["transactionDateTime"],
        referenceNo: json["referenceNo"],
        typeOfTransaction: json["typeOfTransaction"]??"",
        fromAccount: json["fromAccount"],
        toAccount: json["toAccount"],
        amount: json["amount"]??"",
        customerCharge: json["customerCharge"]??"",
        journalNumber: json["journalNumber"]??"",
        status: json["status"]??"",
        koHolding: json["koHolding"]??"",
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdOn: json["createdOn"],
        createdBy: json["createdBy"],
        modifiedOn: json["modifiedOn"],
        modifiedBy: json["modifiedBy"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cspCode": cspCode,
        "transactionDateTime": transactionDateTime,
        "referenceNo": referenceNo,
        "typeOfTransaction": typeOfTransaction,
        "fromAccount": fromAccount,
        "toAccount": toAccount,
        "amount": amount,
        "customerCharge": customerCharge,
        "journalNumber": journalNumber,
        "status": status,
        "koHolding": koHolding,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "createdOn": createdOn,
        "createdBy": createdBy,
        "modifiedOn": modifiedOn,
        "modifiedBy": modifiedBy,
    };
}
