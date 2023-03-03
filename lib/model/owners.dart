// To parse this JSON data, do
//
//     final PropertyOwnersModel = PropertyOwnersModelFromJson(jsonString);

import 'dart:convert';

List<PropertyOwnersModel> propertyOwnersModelFromJson(String str) => List<PropertyOwnersModel>.from(json.decode(str).map((x) => PropertyOwnersModel.fromJson(x)));

String propertyOwnersModelToJson(List<PropertyOwnersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PropertyOwnersModel {
    PropertyOwnersModel({
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

    factory PropertyOwnersModel.fromJson(Map<String, dynamic> json) => PropertyOwnersModel(
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
