import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/services/provider/dark_theme.dart';
import 'package:real_estate_project/widgets/home/recent_listings.dart';
import 'package:real_estate_project/widgets/property_detail/related_properties.dart';

import '../../services/provider/properties.dart';
import '../../const/const.dart';
import '../../utility/shimmer/home/recent_listing.dart';
import '../../widgets/noproperty_found.dart';

class ViewAllFeaturedPropertyScreen extends StatefulWidget {
  const ViewAllFeaturedPropertyScreen({super.key});

  @override
  State<ViewAllFeaturedPropertyScreen> createState() =>
      _ViewAllFeaturedPropertyScreenState();
}

class _ViewAllFeaturedPropertyScreenState
    extends State<ViewAllFeaturedPropertyScreen> {
  late Future _featuredPropertiesData;
  bool _isListView = true;
  bool _filterByPrice = false;

  Future _getFeaturedProperties() {
    return Provider.of<PropertiesProvider>(context, listen: false)
        .getFeaturedProperties();
  }

  @override
  void initState() {
    super.initState();
    _featuredPropertiesData = _getFeaturedProperties();
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
          "Featured Properties",
          style: appBarStyle(screenSize),
        ),
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(top: screenSize.height * 0.07),
          child: FutureBuilder(
            future: _featuredPropertiesData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const NoPropertyFoundWidget(text: "Try Again!");
                } else {
                  return Consumer<PropertiesProvider>(
                      builder: (context, propertiesData, _) {
                    _filterByPrice
                        ? propertiesData.sortFeaturedPropertiesByPrice()
                        : propertiesData.sortFeaturedPropertiesByTime();

                    return _isListView
                        ? ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.only(top: 10),
                            physics: const ScrollPhysics(),
                            itemCount: propertiesData.featuredItems.length,
                            itemBuilder: (ctx, index) {
                              return RecentListingsWidget(
                                id: propertiesData.featuredItems[index].id,
                                propertyName:
                                    propertiesData.featuredItems[index].name,
                                price:
                                    propertiesData.featuredItems[index].price,
                                bedroom: propertiesData
                                    .featuredItems[index].details.bedroom,
                                bathroom: propertiesData
                                    .featuredItems[index].details.bathroom,
                                area: propertiesData
                                    .featuredItems[index].details.area,
                                address: propertiesData
                                    .featuredItems[index].address.city,
                                type: propertiesData.featuredItems[index].type,
                                imgUrl: propertiesData
                                    .featuredItems[index].images[0],
                              );
                            })
                        : GridView.builder(
                            shrinkWrap: true,
                            itemCount: propertiesData.featuredItems.length,
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
                                id: propertiesData.featuredItems[index].id,
                                propertyName:
                                    propertiesData.featuredItems[index].name,
                                // price:
                                //     propertiesData.featuredItems[index].price,
                                bedroom: propertiesData
                                    .featuredItems[index].details.bedroom,
                                bathroom: propertiesData
                                    .featuredItems[index].details.bathroom,
                                area: propertiesData
                                    .featuredItems[index].details.area,
                                address: propertiesData
                                    .featuredItems[index].address.city,
                                type: propertiesData.featuredItems[index].type,
                                imgUrl: propertiesData
                                    .featuredItems[index].images[0],
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
