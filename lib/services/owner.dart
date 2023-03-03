import 'package:real_estate_project/const/const.dart';
import 'package:http/http.dart' as http;
import 'package:real_estate_project/model/owners.dart';
import 'package:real_estate_project/model/properties/owner_property.dart';

class PropertyOwnerApi {
  static Future<List<PropertyOwnersModel>> getPropertyOwners() async {
    String url = '${AppConst.baseUrl}/owner';
    try {
      http.Response response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        return propertyOwnersModelFromJson(response.body);
      } else {
        return Future.error("error");
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<SinglePropertyOwnerModel>> getPropertyOfSingleOwner(
      String id) async {
    String url = '${AppConst.baseUrl}/property/owner/$id';
    try {
      http.Response response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        return singlePropertyOwnerModelFromJson(response.body);
      } else {
        return Future.error("error");
      }
    } catch (e) {
      rethrow;
    }
  }
}
