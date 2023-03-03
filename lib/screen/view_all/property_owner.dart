import 'package:flutter/material.dart';
import 'package:real_estate_project/const/const.dart';

import '../../model/owners.dart';
import '../../services/owner.dart';
import '../../utility/shimmer/home/featured&mostly.dart.dart';
import '../../widgets/noproperty_found.dart';
import '../../widgets/view_all/property_owners.dart';

class ViewAllPropertyOwnersScreen extends StatefulWidget {
  const ViewAllPropertyOwnersScreen({super.key});

  @override
  State<ViewAllPropertyOwnersScreen> createState() =>
      _ViewAllPropertyOwnersScreenState();
}

class _ViewAllPropertyOwnersScreenState
    extends State<ViewAllPropertyOwnersScreen> {
  late Future<List<PropertyOwnersModel>> _ownersData;

  @override
  void initState() {
    _ownersData = PropertyOwnerApi.getPropertyOwners();
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
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: Text(
          "Property Owners",
          style: appBarStyle(screenSize),
        ),
      ),
      body: FutureBuilder<List<PropertyOwnersModel>>(
        future: _ownersData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const NoPropertyFoundWidget(text: "Try Again!");
            } else {
              List<PropertyOwnersModel>? data = snapshot.data;

              return GridView.builder(
                shrinkWrap: true,
                itemCount: data!.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(
                    top: 10,
                    left: screenSize.width * 0.04,
                    right: screenSize.width * 0.04),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 1.15,
                  maxCrossAxisExtent: screenSize.width * 0.5,
                  mainAxisSpacing: screenSize.width * 0.04,
                  crossAxisSpacing: screenSize.width * 0.04,
                ),
                itemBuilder: (ctx, index) {
                  return ViewAllPropertyOwnersWidget(
                    id: data[index].id,
                    title: data[index].name,
                    imgUrl: data[index].logo,
                  );
                },
              );
            }
          } else {
            return GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(
                    top: 6,
                    left: screenSize.width * 0.02,
                    right: screenSize.width * 0.02),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  // childAspectRatio: 1.
                  maxCrossAxisExtent: screenSize.width * 0.5,
                  mainAxisSpacing: screenSize.width * 0.04,
                  crossAxisSpacing: screenSize.width * 0.04,
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
