import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/utility/shimmer/home/recent_listing.dart';
import 'package:real_estate_project/widgets/home/recent_listings.dart';
import 'package:real_estate_project/widgets/noproperty_found.dart';
import 'package:real_estate_project/widgets/property_detail/related_properties.dart';

import '../services/auth/auth.dart';
import '../services/provider/save_for_later.dart';
import '../const/const.dart';

class SaveForLaterScreen extends StatefulWidget {
  const SaveForLaterScreen({super.key});

  @override
  State<SaveForLaterScreen> createState() => _SaveForLaterScreenState();
}

class _SaveForLaterScreenState extends State<SaveForLaterScreen> {
  late Future _getSavedData;
  bool _isListView = true;
  @override
  void initState() {
    Provider.of<SaveForLaterProvider>(context, listen: false).cleanData();
    _getSavedData = Provider.of<SaveForLaterProvider>(context, listen: false)
        .getSavedProperties(
            Provider.of<AuthProvider>(context, listen: false).userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Bookmarks",
          style: appBarStyle(screenSize),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _isListView
                ? GestureDetector(
                    onTap: () => setState(() {
                      _isListView = false;
                    }),
                    child: const Icon(
                      Icons.grid_view_sharp,
                      size: 24,
                    ),
                  )
                : GestureDetector(
                    onTap: () => setState(() {
                      _isListView = true;
                    }),
                    child: const Icon(
                      Icons.menu,
                      size: 24,
                    ),
                  ),
          )
        ],
      ),
      body: Stack(children: [
        FutureBuilder(
            future: _getSavedData,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const NoPropertyFoundWidget(
                    text: "Try Again!",
                  );
                } else {
                  var propertyData = Provider.of<SaveForLaterProvider>(context)
                      .savedForLaterProperties;
                  return propertyData.isEmpty
                      ? const NoPropertyFoundWidget(
                          text: "Saved Properties Will Be Shown Here",
                        )
                      : _isListView
                          ? ListView.builder(
                              itemCount: propertyData.length,
                              padding: const EdgeInsets.only(top: 6),
                              itemBuilder: (context, index) {
                                return RecentListingsWidget(
                                  id: propertyData[index]["_id"],
                                  propertyName: propertyData[index]["name"],
                                  price: propertyData[index]["price"],
                                  bedroom: propertyData[index]["details"]
                                      ["bedroom"],
                                  bathroom: propertyData[index]["details"]
                                      ["bathroom"],
                                  area: propertyData[index]["details"]["area"],
                                  address: propertyData[index]["address"]
                                      ["city"],
                                  type: propertyData[index]["type"],
                                  imgUrl: propertyData[index]["images"][0],
                                );
                              })
                          : GridView.builder(
                              shrinkWrap: true,
                              itemCount: propertyData.length,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.only(
                                  top: 6,
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
                                  id: propertyData[index]["_id"],
                                  propertyName: propertyData[index]["name"],
                                  // price: propertyData[index]["price"],
                                  bedroom: propertyData[index]["details"]
                                      ["bedroom"],
                                  bathroom: propertyData[index]["details"]
                                      ["bathroom"],
                                  area: propertyData[index]["details"]["area"],
                                  address: propertyData[index]["address"]
                                      ["city"],
                                  type: propertyData[index]["type"],
                                  imgUrl: propertyData[index]["images"][0],
                                );
                              },
                            );
                }
              } else {
                return ListView.builder(
                    itemCount: 7,
                    itemBuilder: (_, index) {
                      return const RecentListingShimmer();
                    });
              }
            }),
        // Positioned(
        //     child: Padding(
        //   padding: EdgeInsets.only(
        //       left: screenSize.width * 0.06, right: screenSize.width * 0.06),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [

        //     ],
        //   ),
        // ))
      ]),
      // body: FutureBuilder(
      //     future: _getSavedData,
      //     builder: (ctx, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         if (snapshot.hasError) {
      //           return Center(
      //             child: Text("Has Error"),
      //           );
      //         } else {
      //           var propertyData = Provider.of<SaveForLaterProvider>(context)
      //               .savedForLaterProperties;
      //           return propertyData.isEmpty
      //               ? Center(
      //                   child: Text("No Saved Data"),
      //                 )
      //               : ListView.builder(
      //                   itemCount: propertyData.length,
      //                   itemBuilder: (context, index) {
      //                     return ViewAllPropertyListViewWidget(
      //                       id: propertyData[index]["_id"],
      //                       propertyName: propertyData[index]["name"],
      //                       price: propertyData[index]["price"],
      //                       bedroom: propertyData[index]["details"]["bedroom"],
      //                       bathroom: propertyData[index]["details"]
      //                           ["bathroom"],
      //                       area: propertyData[index]["details"]["area"],
      //                       address: propertyData[index]["address"]["city"],
      //                       type: propertyData[index]["type"],
      //                       imgUrl: propertyData[index]["images"][0],
      //                     );
      //                   });
      //         }
      //       } else {
      //         return Center(child: CircularProgressIndicator());
      //       }
      //     }),
    );
  }
}
