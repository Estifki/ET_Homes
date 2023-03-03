// To parse this JSON data, do
//
//     final companyListModel = companyListModelFromJson(jsonString);

import 'dart:convert';

CompanyListModel companyListModelFromJson(String str) =>
    CompanyListModel.fromJson(json.decode(str));

String companyListModelToJson(CompanyListModel data) =>
    json.encode(data.toJson());

class CompanyListModel {
  CompanyListModel({
    required this.success,
    required this.data,
  });

  bool success;
  List<CompanyListData> data;

  factory CompanyListModel.fromJson(Map<String, dynamic> json) =>
      CompanyListModel(
        success: json["success"],
        data: List<CompanyListData>.from(
            json["data"].map((x) => CompanyListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CompanyListData {
  CompanyListData({
    required this.id,
    required this.companyId,
    required this.name,
    required this.logo,
    required this.address,
    required this.phone,
    required this.v,
  });

  String id;
  String companyId;
  String name;
  String logo;
  String address;
  String phone;
  int v;

  factory CompanyListData.fromJson(Map<String, dynamic> json) =>
      CompanyListData(
        id: json["_id"],
        companyId: json["companyId"],
        name: json["name"],
        logo: json["logo"],
        address: json["address"],
        phone: json["phone"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "companyId": companyId,
        "name": name,
        "logo": logo,
        "address": address,
        "phone": phone,
        "__v": v,
      };
}
