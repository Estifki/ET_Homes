import 'package:flutter/material.dart';
import 'package:real_estate_project/model/properties/home/mostly_viewed.dart';
import 'package:real_estate_project/services/company.dart';
import 'package:real_estate_project/widgets/property_detail/related_properties.dart';

import '../../const/const.dart';
import '../../utility/shimmer/home/featured&mostly.dart.dart';
import '../../widgets/noproperty_found.dart';

class CompanyDetailsScreen extends StatefulWidget {
  const CompanyDetailsScreen({super.key});

  @override
  State<CompanyDetailsScreen> createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
  late Future<MostlyViewedModel> _companyDetailsData;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      var id = ModalRoute.of(context)!.settings.arguments as List;
      _companyDetailsData = CompanyApi().getSingleCompany(id[0]);
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var name = ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          name[1],
          style: appBarStyle(screenSize),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
      body: FutureBuilder<MostlyViewedModel>(
        future: _companyDetailsData,
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            if (snapShot.hasError) {
              return const NoPropertyFoundWidget(text: "Try Again!");
            } else {
              var data = snapShot.data!.data;

              if (data.isEmpty) {
                return const NoPropertyFoundWidget();
              }
              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(
                      top: 10,
                      left: screenSize.width * 0.04,
                      right: screenSize.width * 0.04),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 0.96,
                    maxCrossAxisExtent: screenSize.width * 0.5,
                    mainAxisSpacing: screenSize.width * 0.02,
                    crossAxisSpacing: screenSize.width * 0.02,
                  ),
                  itemBuilder: (ctx, index) {
                    return RelatedProprtiesWidget(
                      id: data[index].id,
                      propertyName: data[index].name,
                      bedroom: data[index].details.bedroom,
                      bathroom: data[index].details.bathroom,
                      area: data[index].details.area,
                      address: data[index].address.location,
                      type: data[index].type,
                      imgUrl: data[index].images[0],
                    );
                  });
            }
          } else {
            return GridView.builder(
                shrinkWrap: true,
                itemCount: 10,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(
                    top: 10,
                    left: screenSize.width * 0.02,
                    right: screenSize.width * 0.02),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 0.96,
                  maxCrossAxisExtent: screenSize.width * 0.5,
                  mainAxisSpacing: screenSize.width * 0.02,
                  crossAxisSpacing: screenSize.width * 0.02,
                ),
                itemBuilder: (ctx, index) {
                  return const FeaturedAndMostlyShimmer();
                });
          }
        },
      ),
    );
  }
}
