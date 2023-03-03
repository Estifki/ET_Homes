// To parse this JSON data, do
//
//     final propertyDetailsModel = propertyDetailsModelFromJson(jsonString);

import 'dart:convert';

PropertyDetailsModel propertyDetailsModelFromJson(String str) => PropertyDetailsModel.fromJson(json.decode(str));

String propertyDetailsModelToJson(PropertyDetailsModel data) => json.encode(data.toJson());

class PropertyDetailsModel {
    PropertyDetailsModel({
        required this.success,
        required this.data,
        required this.related,
        required this.agentCompany,
    });

    bool success;
    Data data;
    List<Related> related;
    String agentCompany;

    factory PropertyDetailsModel.fromJson(Map<String, dynamic> json) => PropertyDetailsModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        related: List<Related>.from(json["related"].map((x) => Related.fromJson(x))),
        agentCompany: json["agentCompany"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "related": List<dynamic>.from(related.map((x) => x.toJson())),
        "agentCompany": agentCompany,
    };
}

class Data {
    Data({
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
        required this.isHided,
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
    Owner owner;
    Agents agents;
    Address address;
    List<String> amenities;
    bool isFeatured;
    bool isRented;
    bool isFurnished;
    bool isRequestedForAd;
    bool isSoldOut;
    bool isHided;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        owner: Owner.fromJson(json["owner"]),
        agents: Agents.fromJson(json["agents"]),
        address: Address.fromJson(json["address"]),
        amenities: List<String>.from(json["amenities"].map((x) => x)),
        isFeatured: json["isFeatured"],
        isRented: json["isRented"],
        isFurnished: json["isFurnished"],
        isRequestedForAd: json["isRequestedForAd"],
        isSoldOut: json["isSoldOut"],
        isHided: json["isHided"],
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
        "owner": owner.toJson(),
        "agents": agents.toJson(),
        "address": address.toJson(),
        "amenities": List<dynamic>.from(amenities.map((x) => x)),
        "isFeatured": isFeatured,
        "isRented": isRented,
        "isFurnished": isFurnished,
        "isRequestedForAd": isRequestedForAd,
        "isSoldOut": isSoldOut,
        "isHided": isHided,
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

class Agents {
    Agents({
        required this.id,
        required this.companyId,
        required this.firstName,
        required this.lastName,
        required this.profile,
        required this.phone,
        required this.email,
        required this.hasCompany,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    String id;
    String companyId;
    String firstName;
    String lastName;
    String profile;
    List<String> phone;
    String email;
    bool hasCompany;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Agents.fromJson(Map<String, dynamic> json) => Agents(
        id: json["_id"],
        companyId: json["companyId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profile: json["profile"],
        phone: List<String>.from(json["phone"].map((x) => x)),
        email: json["email"],
        hasCompany: json["hasCompany"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "companyId": companyId,
        "firstName": firstName,
        "lastName": lastName,
        "profile": profile,
        "phone": List<dynamic>.from(phone.map((x) => x)),
        "email": email,
        "hasCompany": hasCompany,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
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

class Owner {
    Owner({
        required this.id,
        required this.name,
        required this.logo,
        required this.address,
        required this.phone,
        required this.v,
    });

    String id;
    String name;
    String logo;
    String address;
    String phone;
    int v;

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["_id"],
        name: json["name"],
        logo: json["logo"],
        address: json["address"],
        phone: json["phone"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "logo": logo,
        "address": address,
        "phone": phone,
        "__v": v,
    };
}

class Related {
    Related({
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
        required this.isHided,
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
    String agents;
    Address address;
    List<String> amenities;
    bool isFeatured;
    bool isRented;
    bool isFurnished;
    bool isRequestedForAd;
    bool isSoldOut;
    bool isHided;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Related.fromJson(Map<String, dynamic> json) => Related(
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
        isHided: json["isHided"],
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
        "isHided": isHided,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
