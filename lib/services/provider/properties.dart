import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
//

import '../../model/properties/home/mostly_viewed.dart';
import '../../model/properties/home/recent_listing.dart';
import '../../const/const.dart';
import '../../model/properties/home/featured_properties.dart';
import '/model/property_detail.dart';
import '/utility/http_exception.dart';

class PropertiesProvider with ChangeNotifier {
  int _totalPage = 1;
  final List<RecentListingData> _recentListingItems = [];
  final List<FeaturedPropertiesData> _featuredItems = [];
  final List<MostlyViewedData> _mostlyViewedItems = [];

  int get totalPage => _totalPage;
  List<RecentListingData> get recentItems => [..._recentListingItems];
  List<FeaturedPropertiesData> get featuredItems => [..._featuredItems];
  List<MostlyViewedData> get mostlyViewedItem => [..._mostlyViewedItems];
  void clearItems() {
    _recentListingItems.clear();
    _featuredItems.clear();
    _mostlyViewedItems.clear();
    // notifyListeners();
  }

  void sortFeaturedPropertiesByTime() {
    _featuredItems.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  void sortFeaturedPropertiesByPrice() {
    _featuredItems.sort((a, b) => a.price.compareTo(b.price));
  }

  void sortMostlyViewedPropertiesByTime() {
    _mostlyViewedItems.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  void sortMostlyViewedPropertiesByPrice() {
    _mostlyViewedItems.sort((a, b) => a.price.compareTo(b.price));
  }

  Future getFeaturedProperties() async {
    String url = "${AppConst.baseUrl}/property/featured";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        _featuredItems.clear();
        final data = featuredPropertiesModelFromJson(response.body);
        _featuredItems.addAll(data.data);
        notifyListeners();
      } else {
        throw HttpException(errorMessage: "invalid Url");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getMostlyViewedProperties() async {
    String url = "${AppConst.baseUrl}/property/mostly-viewed";
    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        _mostlyViewedItems.clear();
        final data = mostlyViewedModelFromJson(response.body);
        _mostlyViewedItems.addAll(data.data);
        notifyListeners();
      } else {
        throw HttpException(errorMessage: "invalid Url");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getRecentListings(int currentPage) async {
    String url = "${AppConst.baseUrl}/property?page=$currentPage";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        _totalPage = responseData["totalPages"];
        final data = recentListingModelFromJson(response.body);
        _recentListingItems.addAll(data.docs);
        notifyListeners();
      } else {
        throw HttpException(errorMessage: "invalid Url");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PropertyDetailsModel> getSingleProperty(String id) async {
    String url = "${AppConst.baseUrl}/property/find/$id";
    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = propertyDetailsModelFromJson(response.body);
        return jsonResponse;
      } else {
        throw HttpException(errorMessage: "invalid Url");
      }
    } catch (e) {
      rethrow;
    }
  }
}
