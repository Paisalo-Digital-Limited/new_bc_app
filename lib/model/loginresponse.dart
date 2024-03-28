// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  int statusCode;
  String message;
  Data data;

  LoginResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    statusCode: json["statusCode"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String name;
  String token;
  String userName;
  String validaty;
  String refreshToken;
  int id;
  String emailId;
  String role;
  int guidId;
  String expiredTime;
  String redirectUrl;
  String branchName;
  String cspCode;
  String address;
  String circle;
  String population;
  String mobile;

  Data({
    required this.name,
    required this.token,
    required this.userName,
    required this.validaty,
    required this.refreshToken,
    required this.id,
    required this.emailId,
    required this.role,
    required this.guidId,
    required this.expiredTime,
    required this.redirectUrl,
    required this.branchName,
    required this.cspCode,
    required this.address,
    required this.circle,
    required this.population,
    required this.mobile,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"]??"",
    token: json["token"]??"",
    userName: json["userName"]??"",
    validaty: json["validaty"]??"",
    refreshToken: json["refreshToken"]??"",
    id: json["id"],
    emailId: json["emailId"]??"",
    role: json["role"]??"",
    guidId: json["guidId"]??0,
    expiredTime: json["expiredTime"]??"",
    redirectUrl: json["redirectUrl"]??"",
    branchName: json["branchName"]??"",
    cspCode: json["cspCode"]??"",
    address: json["address"]??"",
    circle: json["circle"]??"",
    population: json["population"]??"",
    mobile: json["mobile"]??"",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "token": token,
    "userName": userName,
    "validaty": validaty,
    "refreshToken": refreshToken,
    "id": id,
    "emailId": emailId,
    "role": role,
    "guidId": guidId,
    "expiredTime": expiredTime,
    "redirectUrl": redirectUrl,
    "branchName": branchName,
    "cspCode": cspCode,
    "address": address,
    "circle": circle,
    "population": population,
    "mobile": mobile,
  };
}
