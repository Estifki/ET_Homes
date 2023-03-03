// To parse this JSON data, do
//
//     final recentListingModel = recentListingModelFromJson(jsonString);

import 'dart:convert';

RecentListingModel recentListingModelFromJson(String str) =>
    RecentListingModel.fromJson(json.decode(str));

String recentListingModelToJson(RecentListingModel data) =>
    json.encode(data.toJson());

class RecentListingModel {
  RecentListingModel({
    required this.docs,
    required this.totalDocs,
    required this.limit,
    required this.totalPages,
    required this.page,
    required this.pagingCounter,
    required this.hasPrevPage,
    required this.hasNextPage,
    required this.prevPage,
    required this.nextPage,
  });

  List<RecentListingData> docs;
  int totalDocs;
  int limit;
  int totalPages;
  int page;
  int pagingCounter;
  bool hasPrevPage;
  bool hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  factory RecentListingModel.fromJson(Map<String, dynamic> json) =>
      RecentListingModel(
        docs: List<RecentListingData>.from(
            json["docs"].map((x) => RecentListingData.fromJson(x))),
        totalDocs: json["totalDocs"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        page: json["page"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
        "totalDocs": totalDocs,
        "limit": limit,
        "totalPages": totalPages,
        "page": page,
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
      };
}

class RecentListingData {
  RecentListingData({
    required this.details,
    required this.id,
    required this.companyId,
    required this.name,
    required this.images,
    required this.price,
    required this.description,
    required this.paymentDescription,
    required this.type,
    required this.views,
    required this.owner,
    required this.agents,
    required this.address,
    required this.amenities,
    required this.isFeatured,
    required this.isRented,
    required this.isFurnished,
    required this.isRequestedForAd,
    required this.isSoldOut,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  Details details;
  String id;
  String companyId;
  String name;
  List<String> images;
  int price;
  String description;
  String paymentDescription;
  String type;
  int views;
  String owner;
  dynamic agents;
  Address address;
  List<String> amenities;
  bool isFeatured;
  bool isRented;
  bool isFurnished;
  bool isRequestedForAd;
  bool isSoldOut;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory RecentListingData.fromJson(Map<String, dynamic> json) =>
      RecentListingData(
        details: Details.fromJson(json["details"]),
        id: json["_id"],
        companyId: json["companyId"],
        name: json["name"],
        images: List<String>.from(json["images"].map((x) => x)),
        price: json["price"],
        description: json["description"],
        paymentDescription: json["paymentDescription"],
        type: json["type"],
        views: json["views"],
        owner: json["owner"],
        agents: json["agents"],
        address: Address.fromJson(json["address"]),
        amenities: List<String>.from(json["amenities"].map((x) => x)),
        isFeatured: json["isFeatured"],
        isRented: json["isRented"],
        isFurnished: json["isFurnished"],
        isRequestedForAd: json["isRequestedForAd"],
        isSoldOut: json["isSoldOut"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "details": details.toJson(),
        "_id": id,
        "companyId": companyId,
        "name": name,
        "images": List<dynamic>.from(images.map((x) => x)),
        "price": price,
        "description": description,
        "paymentDescription": paymentDescription,
        "type": type,
        "views": views,
        "owner": owner,
        "agents": agents,
        "address": address.toJson(),
        "amenities": List<dynamic>.from(amenities.map((x) => x)),
        "isFeatured": isFeatured,
        "isRented": isRented,
        "isFurnished": isFurnished,
        "isRequestedForAd": isRequestedForAd,
        "isSoldOut": isSoldOut,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Address {
  Address({
    required this.city,
    required this.location,
    required this.loc,
    required this.id,
  });

  String city;
  String location;
  List<double> loc;
  String id;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"],
        location: json["location"],
        loc: List<double>.from(json["loc"].map((x) => x.toDouble())),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "location": location,
        "loc": List<dynamic>.from(loc.map((x) => x)),
        "_id": id,
      };
}

class Details {
  Details({
    required this.area,
    required this.bedroom,
    required this.bathroom,
    required this.yearbuilt,
  });

  int area;
  int bedroom;
  int bathroom;
  int yearbuilt;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        area: json["area"],
        bedroom: json["bedroom"],
        bathroom: json["bathroom"],
        yearbuilt: json["yearbuilt"],
      );

  Map<String, dynamic> toJson() => {
        "area": area,
        "bedroom": bedroom,
        "bathroom": bathroom,
        "yearbuilt": yearbuilt,
      };
}
