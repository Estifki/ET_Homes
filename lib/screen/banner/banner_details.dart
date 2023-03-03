import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_project/services/owner.dart';
import 'package:real_estate_project/model/properties/owner_property.dart';
import 'package:real_estate_project/utility/shimmer/home/recent_listing.dart';
import 'package:real_estate_project/widgets/home/recent_listings.dart';

import '../../widgets/noproperty_found.dart';

class BannerDetailsScreen extends StatefulWidget {
  const BannerDetailsScreen({super.key});

  @override
  State<BannerDetailsScreen> createState() => _BannerDetailsScreenState();
}

class _BannerDetailsScreenState extends State<BannerDetailsScreen> {
  late Future<List<SinglePropertyOwnerModel>> _bannerData;

  @override
  void didChangeDependencies() {
    var ownerID = ModalRoute.of(context)!.settings.arguments as List;
    _bannerData = PropertyOwnerApi.getPropertyOfSingleOwner(ownerID[0]);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var ownerImage = ModalRoute.of(context)!.settings.arguments as List;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColor.lightBackground,
      //   elevation: 0.0,
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   leading: IconButton(
      //     onPressed: () => Navigator.of(context).pop(),
      //     icon: Icon(
      //       Icons.arrow_back_ios_new,
      //       color: Colors.black,
      //     ),
      //   ),
      //   title: Text(
      //     "${owner[1]}".toUpperCase(),
      //     style: appBarStyle(screenSize),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: ownerImage[1],
              height: screenSize.height * 0.26,
              width: screenSize.width,
              // placeholder: (context, url) => Container(
              //   height: screenSize.width > 370
              //       ? screenSize.height * 0.22
              //       : screenSize.height * 0.26,
              //   width: screenSize.width * 0.5,
              //   color: Colors.grey.shade200,
              // ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
            FutureBuilder<List<SinglePropertyOwnerModel>>(
              future: _bannerData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const NoPropertyFoundWidget(
                        fromTop: 0.225, text: "Please Try Again!");
                  } else {
                    List<SinglePropertyOwnerModel>? data = snapshot.data;

                    if (data!.isEmpty) {
                      return const NoPropertyFoundWidget(fromTop: 0.225);
                    }

                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.only(top: 10),
                        physics: const ScrollPhysics(),
                        itemCount: data.length,
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
                  // return ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: 6,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (ctx, index) {
                  //       return FeaturedAndMostlyShimmer();
                  //     });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
