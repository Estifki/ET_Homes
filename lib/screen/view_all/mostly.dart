import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/widgets/home/recent_listings.dart';
import 'package:real_estate_project/widgets/property_detail/related_properties.dart';

import '../../services/provider/dark_theme.dart';
import '../../services/provider/properties.dart';
import '../../const/const.dart';
import '../../utility/shimmer/home/recent_listing.dart';
import '../../widgets/noproperty_found.dart';

class ViewAllMostlyViewedPropertyScreen extends StatefulWidget {
  const ViewAllMostlyViewedPropertyScreen({super.key});

  @override
  State<ViewAllMostlyViewedPropertyScreen> createState() =>
      _ViewAllMostlyViewedPropertyScreenState();
}

class _ViewAllMostlyViewedPropertyScreenState
    extends State<ViewAllMostlyViewedPropertyScreen> {
  late Future _mostlyViewedData;
  bool _isListView = true;
  bool _filterByPrice = false;

  @override
  void initState() {
    super.initState();
    _mostlyViewedData = _getMostlyViewedProperties();
  }

  Future _getMostlyViewedProperties() {
    return Provider.of<PropertiesProvider>(context, listen: false)
        .getFeaturedProperties();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
          "Mostly Viewed",
          style: appBarStyle(screenSize),
        ),
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(top: screenSize.height * 0.07),
          child: FutureBuilder(
            future: _mostlyViewedData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const NoPropertyFoundWidget(text: "Try Again!");
                } else {
                  return Consumer<PropertiesProvider>(
                      builder: (context, propertiesData, _) {
                    _filterByPrice
                        ? propertiesData.sortMostlyViewedPropertiesByPrice()
                        : propertiesData.sortMostlyViewedPropertiesByTime();

                    return _isListView
                        ? ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.only(top: 10),
                            physics: const ScrollPhysics(),
                            itemCount: propertiesData.mostlyViewedItem.length,
                            itemBuilder: (ctx, index) {
                              return RecentListingsWidget(
                                id: propertiesData.mostlyViewedItem[index].id,
                                propertyName:
                                    propertiesData.mostlyViewedItem[index].name,
                                price: propertiesData
                                    .mostlyViewedItem[index].price,
                                bedroom: propertiesData
                                    .mostlyViewedItem[index].details.bedroom,
                                bathroom: propertiesData
                                    .mostlyViewedItem[index].details.bathroom,
                                area: propertiesData
                                    .mostlyViewedItem[index].details.area,
                                address: propertiesData
                                    .mostlyViewedItem[index].address.city,
                                type:
                                    propertiesData.mostlyViewedItem[index].type,
                                imgUrl: propertiesData
                                    .mostlyViewedItem[index].images[0],
                              );
                            })
                        : GridView.builder(
                            shrinkWrap: true,
                            itemCount: propertiesData.mostlyViewedItem.length,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                                top: 10,
                                left: screenSize.width * 0.04,
                                right: screenSize.width * 0.04),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              childAspectRatio: 0.96,
                              maxCrossAxisExtent: screenSize.width * 0.5,
                              mainAxisSpacing: screenSize.width * 0.02,
                              crossAxisSpacing: screenSize.width * 0.02,
                            ),
                            itemBuilder: (ctx, index) {
                              return RelatedProprtiesWidget(
                                id: propertiesData.mostlyViewedItem[index].id,
                                propertyName:
                                    propertiesData.mostlyViewedItem[index].name,
                                // price: propertiesData
                                //     .mostlyViewedItem[index].price,
                                bedroom: propertiesData
                                    .mostlyViewedItem[index].details.bedroom,
                                bathroom: propertiesData
                                    .mostlyViewedItem[index].details.bathroom,
                                area: propertiesData
                                    .mostlyViewedItem[index].details.area,
                                address: propertiesData
                                    .mostlyViewedItem[index].address.city,
                                type:
                                    propertiesData.mostlyViewedItem[index].type,
                                imgUrl: propertiesData
                                    .mostlyViewedItem[index].images[0],
                              );
                            },
                          );
                  });
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
              _filterByPrice
                  ? GestureDetector(
                      onTap: () => setState(() {
                        _filterByPrice = !_filterByPrice;
                      }),
                      child: Container(
                        height: 32,
                        width: 120,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                              Provider.of<DarkThemeProvider>(context).isDarkMode
                                  ? Colors.grey.shade300
                                  : Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Filter by price",
                          style: TextStyle(
                              fontSize: AppTextSize.propertyNameSize - 1,
                              color: Provider.of<DarkThemeProvider>(context)
                                      .isDarkMode
                                  ? Colors.black
                                  : Colors.white,
                              fontFamily: AppFonts.medium),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () => setState(() {
                        _filterByPrice = !_filterByPrice;
                      }),
                      child: Container(
                        height: 32,
                        width: 120,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                              Provider.of<DarkThemeProvider>(context).isDarkMode
                                  ? Colors.grey.withOpacity(0.15)
                                  : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Filter by price",
                          style: TextStyle(
                              fontSize: AppTextSize.propertyNameSize - 1,
                              color: Provider.of<DarkThemeProvider>(context)
                                      .isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              fontFamily: AppFonts.medium),
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
