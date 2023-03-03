import 'dart:convert';

import 'package:real_estate_project/const/const.dart';
import 'package:http/http.dart' as http;

import '../model/user_profile.dart';
import '../utility/http_exception.dart';

class ProfileApi {
  static Future<UserProfileModel> getUserProfile(String? userID) async {
    try {
      String url = "${AppConst.baseUrl}/user/profile/app/$userID";
      http.Response response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        return userProfileModelFromJson(response.body);
      } else {
        throw HttpException(errorMessage: "Unknown Error occured!");
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> updatePassword(String? userID, password) async {
    try {
      String url = "${AppConst.baseUrl}/user/find/$userID";
      http.Response response = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "password": password,
        }),
      );
      if (response.statusCode == 200) {}
    } catch (e) {}
  }

  static Future<void> updateUserProfile(
      String? userID, fName, lName, profilePicUrl) async {
    try {
      String url = "${AppConst.baseUrl}/user/find/$userID";
      http.Response response = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: fName == ""
            ? lName == ""
                ? jsonEncode({
                    "profile": profilePicUrl,
                  })
                : jsonEncode({
                    "lastName": lName,
                    "profile": profilePicUrl,
                  })
            : lName == ""
                ? jsonEncode({
                    "firstName": fName,
                    "profile": profilePicUrl,
                  })
                : jsonEncode({
                    "firstName": fName,
                    "lastName": lName,
                    "profile": profilePicUrl,
                  }),
      );
      if (response.statusCode == 200) {}
    } catch (e) {}
  }
}
