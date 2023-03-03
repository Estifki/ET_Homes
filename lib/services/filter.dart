import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:real_estate_project/const/const.dart';

import '../model/properties/filtered_properties.dart';

class FilterApi {
  static Future<List<FilteredPropertiesModel>> getFilteredProperies(
      {required dynamic minPrice,
      required dynamic maxPrice,
      required dynamic bedRooms,
      required dynamic bathRooms,
      required dynamic minArea,
      required dynamic owner,
      required dynamic propertyType}) async {
    String propertyTypeValue() {
      if (propertyType == "") {
        return "";
      } else {
        return "type=$propertyType";
      }
    }

    String propertyOwner() {
      if (owner == "") {
        return "";
      } else {
        return "owner=$owner";
      }
    }

    String bedRoomValue() {
      if (bedRooms == "") {
        return "";
      } else {
        return "bedroom=$bedRooms";
      }
    }

    String bathRoomValue() {
      if (bathRooms == "") {
        return "";
      } else {
        return "bathroom=$bathRooms";
      }
    }

    var url =
        "${AppConst.baseUrl}/property/search?minprice=$minPrice&${bedRoomValue()}&maxprice=$maxPrice&${bathRoomValue()}&${propertyTypeValue()}&minarea=$minArea&${propertyOwner()}";

    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        return jsonResponse
            .map((data) => FilteredPropertiesModel.fromJson(data))
            .toList();
      } else {
        throw Exception('Unknown Network Error');
      }
    } catch (e) {
      rethrow;
    }
  }
}
