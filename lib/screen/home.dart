import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:real_estate_project/const/const.dart';
import 'package:real_estate_project/model/owners.dart';
import 'package:real_estate_project/services/provider/banner.dart';
import 'package:real_estate_project/services/owner.dart';

import 'package:real_estate_project/services/provider/properties.dart';
import 'package:real_estate_project/screen/view_all/mostly.dart';
import 'package:real_estate_project/screen/view_all/property_owner.dart';

import 'package:real_estate_project/utility/shimmer/home/featured&mostly.dart.dart';
import 'package:real_estate_project/utility/shimmer/home/owner.dart';
import 'package:real_estate_project/utility/shimmer/home/recent_listing.dart';
import 'package:shimmer/shimmer.dart';

import '../services/provider/dark_theme.dart';
import '../widgets/home/banner.dart';
import '../widgets/home/custom_appbar.dart';

import '../widgets/home/owners.dart';

import '../widgets/home/features_property.dart';
import '../widgets/home/moslty_viewed.dart';
import '../widgets/home/recent_listings.dart';
import 'view_all/featured.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _refreshController = RefreshController();
  late Future<List<PropertyOwnersModel>> _ownersData;

  late Future _bannerData;
  int _currentPage = 1;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<PropertiesProvider>(context, listen: false).clearItems();
      Provider.of<BannerProvider>(context, listen: false).clearBanner();
      _bannerData =
          Provider.of<BannerProvider>(context, listen: false).getBannners();
      _ownersData = PropertyOwnerApi.getPropertyOwners();
      Provider.of<PropertiesProvider>(context, listen: false)
          .getFeaturedProperties();
      _isInit = false;
    }
  }

  Future _onLoading() async {
    if (_currentPage <
        Provider.of<PropertiesProvider>(context, listen: false).totalPage) {
      await Provider.of<PropertiesProvider>(context, listen: false)
          .getRecentListings(++_currentPage)
          .then((_) => _refreshController.loadComplete());
    } else {
      _refreshController.loadNoData();
    }
  }

  // Future _onRefresh() async {
  //   Provider.of<PropertiesProvider>(context, listen: false).clearItems();
  //   Provider.of<BannerProvider>(context, listen: false).clearBanner();
  //   _bannerData =
  //       await Provider.of<BannerProvider>(context, listen: false).getBannners();
  //   _ownersData = PropertyOwnerApi.getPropertyOwners();
  //   Provider.of<PropertiesProvider>(context, listen: false)
  //       .getFeaturedProperties();
  //   await _onLoading();
  // }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        context,
        SizedBox(
          width: 120,
          child: ListTileSwitch(
            value: Provider.of<DarkThemeProvider>(context, listen: false)
                .isDarkMode,
            // leading: Icon(Icons.mode_night_outlined),
            visualDensity: VisualDensity.comfortable,
            switchType: SwitchType.custom,
            switchActiveColor: AppColor.primaryColorCustom,
            // title: Text(
            //   'Dark Mode',
            //   style: TextStyle(
            //       fontSize: AppTextSize.propertyNameSize,
            //       fontFamily: AppFonts.medium),
            // ),
            onChanged: (value) {
              setState(() {
                Provider.of<DarkThemeProvider>(context, listen: false)
                    .setDarkTheme = value;
              });
            },
          ),
        ),
      ),
      //
      //body
      //
      body: SmartRefresher(
        controller: _refreshController,
        enablePullUp: true,
        enablePullDown: false,
        onLoading: () => _onLoading(),
        // onRefresh: () {
        //   _onRefresh().then((_) => _refreshController.refreshCompleted());
        // },
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            //
            //
            //Banner Ads
            //
            //
            SizedBox(
              height: screenSize.width > 370
                  ? screenSize.height * 0.22
                  : screenSize.height * 0.26,
              child: FutureBuilder(
                future: _bannerData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Unknown Error"),
                      );
                    } else {
                      return Consumer<BannerProvider>(
                        builder: (context, data, _) {
                          return CarouselSlider.builder(
                            itemCount: data.bannerData.length,
                            options: CarouselOptions(
                              autoPlay: true,
                              viewportFraction: 1,
                            ),
                            itemBuilder: (context, index, _) {
                              return BannerWidget(
                                  id: data.bannerData[index].owner,
                                  // name: data.bannerData[index].,
                                  imageUrl: data.bannerData[index].image);
                            },
                          );
                        },
                      );
                    }
                  } else {
                    return Center(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade400,
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          height: screenSize.height * 0.2,
                          width: screenSize.width,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            //
            //
            //PropertyOwners
            //
            //
            PropertyHeader(
              header: "Real Estates",
              ontap: const ViewAllPropertyOwnersScreen(),
            ),
            SizedBox(
                // color: Colors.red,

                height: screenSize.width > 370
                    ? screenSize.height * 0.154
                    : screenSize.height * 0.182,
                child: FutureBuilder<List<PropertyOwnersModel>>(
                  future: _ownersData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Unknown Error"),
                        );
                      } else {
                        List<PropertyOwnersModel>? data = snapshot.data;
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: data!.length,
                            itemBuilder: (ctx, index) {
                              return OwnersWidget(
                                id: data[index].id,
                                ownerName: data[index].name,
                                imgUrl: data[index].logo,
                              );
                            });
                      }
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return const OwnersShimmer();
                          });
                    }
                  },
                )),

            //
            //
            //Features Properties
            //
            //
            Consumer<PropertiesProvider>(builder: (context, propertiesData, _) {
              return propertiesData.featuredItems.isEmpty
                  ? const SizedBox()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        PropertyHeader(
                          header: "Featured Properties",
                          ontap: const ViewAllFeaturedPropertyScreen(),
                        ),
                        SizedBox(
                          height: screenSize.width > 370
                              ? screenSize.height * 0.26
                              : screenSize.height * 0.29,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: propertiesData.featuredItems.length,
                              itemBuilder: (ctx, index) {
                                propertiesData.sortFeaturedPropertiesByTime();
                                return FeaturesPropertyWidget(
                                  id: propertiesData.featuredItems[index].id,
                                  propertyName:
                                      propertiesData.featuredItems[index].name,
                                  bedroom: propertiesData
                                      .featuredItems[index].details.bedroom,
                                  bathroom: propertiesData
                                      .featuredItems[index].details.bathroom,
                                  area: propertiesData
                                      .featuredItems[index].details.area,
                                  address: propertiesData
                                      .featuredItems[index].address.location,
                                  type:
                                      propertiesData.featuredItems[index].type,
                                  imgUrl: propertiesData
                                      .featuredItems[index].images[0],
                                );
                              }),
                        ),
                      ],
                    );
            }),
            //
            //
            //PropertyOwners
            //
            //
            PropertyHeader(
              header: "Mostly Viewed",
              ontap: const ViewAllMostlyViewedPropertyScreen(),
            ),
            SizedBox(
              height: screenSize.width > 370
                  ? screenSize.height * 0.26
                  : screenSize.height * 0.29,
              child: FutureBuilder(
                future: Provider.of<PropertiesProvider>(context, listen: false)
                    .getMostlyViewedProperties(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Unknown Error"),
                      );
                    } else {
                      return Consumer<PropertiesProvider>(
                          builder: (context, mostlyViewedData, _) {
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                mostlyViewedData.mostlyViewedItem.length > 10
                                    ? 10
                                    : mostlyViewedData.mostlyViewedItem.length,
                            itemBuilder: (ctx, index) {
                              return MostlyViewedWidget(
                                id: mostlyViewedData.mostlyViewedItem[index].id,
                                propertyName: mostlyViewedData
                                    .mostlyViewedItem[index].name,
                                bedroom: mostlyViewedData
                                    .mostlyViewedItem[index].details.bedroom,
                                bathroom: mostlyViewedData
                                    .mostlyViewedItem[index].details.bathroom,
                                area: mostlyViewedData
                                    .mostlyViewedItem[index].details.area,
                                address: mostlyViewedData
                                    .mostlyViewedItem[index].address.location,
                                type: mostlyViewedData
                                    .mostlyViewedItem[index].type,
                                imgUrl: mostlyViewedData
                                    .mostlyViewedItem[index].images[0],
                              );
                            });
                      });
                    }
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 6,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return const FeaturedAndMostlyShimmer();
                        });
                  }
                },
              ),
            ),
            //
            //
            //Recent Listings
            //
            //

            Padding(
              padding: const EdgeInsets.only(
                  left: 12, top: 18, right: 12, bottom: 8),
              child: Text(
                "Recent Listings",
                style: TextStyle(
                  fontSize: AppTextSize.headerTitleSize,
                  fontFamily: AppFonts.title,
                ),
              ),
            ),

            FutureBuilder(
              future: Provider.of<PropertiesProvider>(context, listen: false)
                  .getRecentListings(_currentPage),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Unknown Error"),
                    );
                  } else {
                    return Consumer<PropertiesProvider>(
                        builder: (context, recentListingData, _) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: recentListingData.recentItems.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (ctx, index) {
                            return RecentListingsWidget(
                              id: recentListingData.recentItems[index].id,
                              propertyName:
                                  recentListingData.recentItems[index].name,
                              price: recentListingData.recentItems[index].price,
                              bedroom: recentListingData
                                  .recentItems[index].details.bedroom,
                              bathroom: recentListingData
                                  .recentItems[index].details.bathroom,
                              area: recentListingData
                                  .recentItems[index].details.area,
                              address: recentListingData
                                  .recentItems[index].address.location,
                              type: recentListingData.recentItems[index].type,
                              imgUrl: recentListingData
                                  .recentItems[index].images[0],
                            );
                          });
                    });
                  }
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (ctx, index) {
                        return const RecentListingShimmer();
                      });
                }
              },
            ),
            SizedBox(height: screenSize.height * 0.001)
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PropertyHeader extends StatelessWidget {
  String header;
  Widget ontap;

  PropertyHeader({super.key, required this.header, required this.ontap});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 18, right: 10, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            header,
            style: TextStyle(
              fontSize: AppTextSize.headerTitleSize,
              fontFamily: AppFonts.title,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(CupertinoPageRoute(builder: (context) => ontap)),
            child: Text(
              "View all",
              style: TextStyle(
                  fontSize: screenSize.width > 370
                      ? screenSize.width * 0.035
                      : screenSize.width * 0.035,
                  color: AppColor.primaryColorCustom,
                  fontFamily: AppFonts.medium),
            ),
          ),
        ],
      ),
    );
  }
}
