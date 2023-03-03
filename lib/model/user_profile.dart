// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  UserProfileModel({
    required this.success,
    required this.profile,
  });

  dynamic success;
  Profile profile;

  factory UserProfileModel.fromJson(Map<dynamic, dynamic> json) =>
      UserProfileModel(
        success: json["success"],
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "profile": profile.toJson(),
      };
}

class Profile {
  Profile({
    required this.id,
    required this.companyId,
    required this.firstName,
    required this.lastName,
    required this.profile,
    required this.email,
    required this.phone,
    required this.isAdmin,
    required this.hasCompany,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  dynamic companyId;
  dynamic firstName;
  dynamic lastName;
  dynamic profile;
  dynamic email;
  dynamic phone;
  dynamic isAdmin;
  dynamic hasCompany;
  DateTime createdAt;
  DateTime updatedAt;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["_id"],
        companyId: json["companyId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profile: json["profile"],
        email: json["email"],
        phone: json["phone"],
        isAdmin: json["isAdmin"],
        hasCompany: json["hasCompany"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "companyId": companyId,
        "firstName": firstName,
        "lastName": lastName,
        "profile": profile,
        "email": email,
        "phone": phone,
        "isAdmin": isAdmin,
        "hasCompany": hasCompany,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
