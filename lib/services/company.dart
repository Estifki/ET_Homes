
import 'package:http/http.dart' as http;
import 'package:real_estate_project/const/const.dart';
import 'package:real_estate_project/model/company.dart';
import 'package:real_estate_project/model/properties/home/mostly_viewed.dart';
import 'package:real_estate_project/utility/http_exception.dart';

class CompanyApi {
  Future<CompanyListModel> getCompanies() async {
    var url = "${AppConst.baseUrl}/agent-company/app";

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return companyListModelFromJson(response.body);
      } else {
        throw HttpException(errorMessage: "errorMessage");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<MostlyViewedModel> getSingleCompany(String companyID) async {
    var url = "${AppConst.baseUrl}/property/company/$companyID";

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return mostlyViewedModelFromJson(response.body);
      } else {
        throw HttpException(errorMessage: "errorMessage");
      }
    } catch (e) {
      rethrow;
    }
  }
}
