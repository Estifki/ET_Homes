// To parse this JSON data, do
//
//     final agentCommentModel = agentCommentModelFromJson(jsonString);

import 'dart:convert';

AgentCommentModel agentCommentModelFromJson(String str) =>
    AgentCommentModel.fromJson(json.decode(str));

String agentCommentModelToJson(AgentCommentModel data) =>
    json.encode(data.toJson());

class AgentCommentModel {
  AgentCommentModel({
    required this.success,
    required this.data,
  });

  bool success;
  List<AgentCommentData> data;

  factory AgentCommentModel.fromJson(Map<String, dynamic> json) =>
      AgentCommentModel(
        success: json["success"],
        data: List<AgentCommentData>.from(
            json["data"].map((x) => AgentCommentData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AgentCommentData {
  AgentCommentData({
    required this.id,
    required this.user,
    required this.agent,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  User user;
  String agent;
  String comment;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory AgentCommentData.fromJson(Map<String, dynamic> json) =>
      AgentCommentData(
        id: json["_id"],
        user: User.fromJson(json["user"]),
        agent: json["agent"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user.toJson(),
        "agent": agent,
        "comment": comment,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class User {
  User({
    required this.id,
    required this.companyId,
    required this.firstName,
    required this.lastName,
    required this.profile,
    required this.email,
    required this.phone,
    required this.password,
    required this.isAdmin,
    required this.favorites,
    required this.hasCompany,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  dynamic companyId;
  String firstName;
  String lastName;
  String profile;
  String email;
  int phone;
  String password;
  bool isAdmin;
  List<dynamic> favorites;
  bool hasCompany;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        companyId: json["companyId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profile: json["profile"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        isAdmin: json["isAdmin"],
        favorites: List<dynamic>.from(json["favorites"].map((x) => x)),
        hasCompany: json["hasCompany"],
        status: json["status"],
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
        "email": email,
        "phone": phone,
        "password": password,
        "isAdmin": isAdmin,
        "favorites": List<dynamic>.from(favorites.map((x) => x)),
        "hasCompany": hasCompany,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
