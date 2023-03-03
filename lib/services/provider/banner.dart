import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:real_estate_project/const/const.dart';
import 'package:real_estate_project/model/banner.dart';
import 'package:real_estate_project/utility/http_exception.dart';

class BannerProvider with ChangeNotifier {
  final List<BannerData> _bannerData = [];
  List<BannerData> get bannerData => [..._bannerData];

  clearBanner() {
    _bannerData.clear();
  }

  Future getBannners() async {
    var url = "${AppConst.baseUrl}/banner/app";

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        _bannerData.addAll((decodedData['data'] as List)
            .map((e) => BannerData.fromJson(e))
            .toList());
      } else {
        throw HttpException(errorMessage: "errorMessage");
      }
    } catch (e) {
      rethrow;
    }
  }
}
