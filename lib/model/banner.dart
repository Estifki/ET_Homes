// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
    BannerModel({
       required this.success,
       required this.data,
    });

    bool success;
    List<BannerData> data;

    factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        success: json["success"],
        data: List<BannerData>.from(json["data"].map((x) => BannerData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class BannerData {
    BannerData({
       required this.user,
       required this.owner,
       required this.agentCompany,
       required this.image,
       required this.createdAt,
       required this.updatedAt,
    });

    dynamic user;
    String owner;
    String agentCompany;
    String image;
    DateTime createdAt;
    DateTime updatedAt;

    factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        user: json["user"],
        owner: json["owner"],
        agentCompany: json["AgentCompany"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "owner": owner,
        "AgentCompany": agentCompany,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
