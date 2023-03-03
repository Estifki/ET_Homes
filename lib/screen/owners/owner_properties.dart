import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/services/owner.dart';
import 'package:real_estate_project/model/properties/owner_property.dart';
import 'package:real_estate_project/widgets/home/recent_listings.dart';
import 'package:real_estate_project/widgets/noproperty_found.dart';
import 'package:real_estate_project/widgets/property_detail/related_properties.dart';

import '../../const/const.dart';
import '../../services/provider/dark_theme.dart';
import '../../utility/shimmer/home/recent_listing.dart';
import '../filter/filter.dart';

class SingleOwnerPropertiesScreen extends StatefulWidget {
  const SingleOwnerPropertiesScreen({super.key});

  @override
  State<SingleOwnerPropertiesScreen> createState() =>
      _SingleOwnerPropertiesScreenState();
}

class _SingleOwnerPropertiesScreenState
    extends State<SingleOwnerPropertiesScreen> {
  late Future<List<SinglePropertyOwnerModel>> _ownerPropertiesData;

  bool _isListView = true;

  @override
  void didChangeDependencies() {
    var ownerID = ModalRoute.of(context)!.settings.arguments as List;
    _ownerPropertiesData =
        PropertyOwnerApi.getPropertyOfSingleOwner(ownerID[0]);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    var owner = ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: Text(
          "${owner[1]}".toUpperCase(),
          style: appBarStyle(screenSize),
        ),
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(top: screenSize.height * 0.07),
          child: FutureBuilder<List<SinglePropertyOwnerModel>>(
            future: _ownerPropertiesData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const NoPropertyFoundWidget(
                      fromTop: 0.225, text: "Try Again!");
                } else if (snapshot.data!.isEmpty) {
                  return const NoPropertyFoundWidget(
                      fromTop: 0.235, text: "No Property Found");
                } else {
                  List<SinglePropertyOwnerModel>? data = snapshot.data;

                  return _isListView
                      ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.only(top: 10),
                          physics: const ScrollPhysics(),
                          itemCount: data!.length,
                          itemBuilder: (ctx, index) {
                            return RecentListingsWidget(
                              id: data[index].id,
                              propertyName: data[index].name,
                              price: data[index].price,
                              bedroom: data[index].details.bedroom,
                              bathroom: data[index].details.bathroom,
                              area: data[index].details.area,
                              address: data[index].address.city,
                              type: data[index].type,
                              imgUrl: data[index].images[0],
                            );
                          })
                      : GridView.builder(
                          shrinkWrap: true,
                          itemCount: data!.length,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            childAspectRatio: 0.96,
                            maxCrossAxisExtent: screenSize.width * 0.5,
                            mainAxisSpacing: screenSize.width * 0.02,
                            crossAxisSpacing: screenSize.width * 0.02,
                          ),
                          itemBuilder: (ctx, index) {
                            return RelatedProprtiesWidget(
                              id: data[index].id,
                              propertyName: data[index].name,
                              // price: data[index].price,
                              bedroom: data[index].details.bedroom,
                              bathroom: data[index].details.bathroom,
                              area: data[index].details.area,
                              address: data[index].address.city,
                              type: data[index].type,
                              imgUrl: data[index].images[0],
                            );
                          },
                        );
                }
              } else {
                return Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 7,
                    itemBuilder: (contex, index) {
                      return const RecentListingShimmer();
                    },
                  ),
                );
              }
            },
          ),
        ),
        Positioned(
            child: Padding(
          padding: EdgeInsets.only(
              left: screenSize.width * 0.06,
              right: screenSize.width * 0.06,
              top: screenSize.height * 0.015),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor:
                        Provider.of<DarkThemeProvider>(context, listen: false)
                                .isDarkMode
                            ? Colors.black
                            : AppColor.lightBackground,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    builder: (context) {
                      return Wrap(children: [
                        FilterScreen(ownerIdForFilter: owner[0]),
                      ]);
                    }),
                child: Container(
                  height: 32,
                  width: 110,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Filter",
                    style: TextStyle(
                        fontSize: AppTextSize.propertyNameSize,
                        color: Colors.black,
                        fontFamily: AppFonts.semiBold),
                  ),
                ),
              ),
              _isListView
                  ? GestureDetector(
                      onTap: () => setState(() {
                        _isListView = false;
                      }),
                      child: const Icon(
                        Icons.grid_view_sharp,
                        size: 25,
                      ),
                    )
                  : GestureDetector(
                      onTap: () => setState(() {
                        _isListView = true;
                      }),
                      child: const Icon(
                        Icons.menu,
                        size: 28,
                      ),
                    )
            ],
          ),
        ))
      ]),
    );
  }
}
