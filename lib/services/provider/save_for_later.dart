import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_project/const/const.dart';
import 'package:http/http.dart' as http;
import 'package:real_estate_project/utility/http_exception.dart';

class SaveForLaterProvider with ChangeNotifier {
  List _savedForLaterPropertiesID = [];
  final List _savedForLaterProperties = [];

  List get savedForLaterProperties => [..._savedForLaterProperties];

  cleanData() {
    _savedForLaterProperties.clear();
    _savedForLaterPropertiesID.clear();
  }

  bool findPropertByID(String propertyID) {
    if (_savedForLaterPropertiesID.firstWhere(
            (favProperty) => favProperty == propertyID,
            orElse: () => null) ==
        null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> getSavedProperties(String? userID) async {
    try {
      var url = "${AppConst.baseUrl}/favorite/user/$userID";
      http.Response response = await http.get(
        Uri.parse(url),
      );
      var decodedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (decodedData["success"] == true) {
          if (decodedData['data']["properties"] == null) {
          } else {
            _savedForLaterProperties.addAll(decodedData['data']["properties"]);
            for (var prop in _savedForLaterProperties) {
              _savedForLaterPropertiesID.add(prop["_id"]);
            }
            notifyListeners();
          }
        }
      } else {}
    } catch (e) {}
  }

  Future addToSavedProperties(String? userID, String propertyID) async {
    String url = "${AppConst.baseUrl}/favorite/add/$userID";
    try {
      http.Response response = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "property": propertyID,
        }),
      );
      if (response.statusCode == 200) {
        await getSavedProperties(userID);
        notifyListeners();
      } else {
        throw HttpException(errorMessage: "Unkown Error Occured!");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeSavedProperties(String? userID, String propertyID) async {
    try {
      var url = "${AppConst.baseUrl}/favorite/remove/$userID";
      http.Response response = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({"property": propertyID}),
      );
      var decodedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (decodedData["success"] == true) {
          if (decodedData['data']["properties"] == null) {
            _savedForLaterPropertiesID = [];
          } else {
            await getSavedProperties(userID);
            notifyListeners();
          }
        }
      }
    } catch (e) {}
  }
}
