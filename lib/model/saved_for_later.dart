// To parse this JSON data, do
//
//     final savedForLaterModel = savedForLaterModelFromJson(jsonString);

import 'dart:convert';

SavedForLaterModel savedForLaterModelFromJson(String str) =>
    SavedForLaterModel.fromJson(json.decode(str));

String savedForLaterModelToJson(SavedForLaterModel data) =>
    json.encode(data.toJson());

class SavedForLaterModel {
  SavedForLaterModel({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory SavedForLaterModel.fromJson(Map<String, dynamic> json) =>
      SavedForLaterModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.userId,
    required this.properties,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String userId;
  List<SavedForLaterData> properties;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        userId: json["userId"],
        properties: List<SavedForLaterData>.from(
            json["properties"].map((x) => SavedForLaterData.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "properties": List<dynamic>.from(properties.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class SavedForLaterData {
  SavedForLaterData({
    required this.details,
    required this.id,
    required this.companyId,
    required this.name,
    required this.images,
    required this.price,
    required this.description,
    required this.type,
    required this.views,
    required this.owner,
    required this.agents,
    required this.address,
    required this.amenities,
    required this.isFeatured,
    required this.isRented,
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
  String type;
  int views;
  String owner;
  String agents;
  Address address;
  List<String> amenities;
  bool isFeatured;
  bool isRented;
  bool isSoldOut;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory SavedForLaterData.fromJson(Map<String, dynamic> json) =>
      SavedForLaterData(
        details: Details.fromJson(json["details"]),
        id: json["_id"],
        companyId: json["companyId"],
        name: json["name"],
        images: List<String>.from(json["images"].map((x) => x)),
        price: json["price"],
        description: json["description"],
        type: json["type"],
        views: json["views"],
        owner: json["owner"],
        agents: json["agents"],
        address: Address.fromJson(json["address"]),
        amenities: List<String>.from(json["amenities"].map((x) => x)),
        isFeatured: json["isFeatured"],
        isRented: json["isRented"],
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
        "type": type,
        "views": views,
        "owner": owner,
        "agents": agents,
        "address": address.toJson(),
        "amenities": List<dynamic>.from(amenities.map((x) => x)),
        "isFeatured": isFeatured,
        "isRented": isRented,
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
    required this.latitude,
    required this.longtude,
    required this.id,
  });

  String city;
  String location;
  double latitude;
  double longtude;
  String id;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"],
        location: json["location"],
        latitude: json["latitude"].toDouble(),
        longtude: json["longtude"].toDouble(),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "location": location,
        "latitude": latitude,
        "longtude": longtude,
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
