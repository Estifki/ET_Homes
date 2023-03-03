import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/const/const.dart';
import 'package:real_estate_project/model/properties/filtered_properties.dart';
import 'package:real_estate_project/services/provider/dark_theme.dart';

import '../../services/filter.dart';
import 'package:lottie/lottie.dart';
import '../../widgets/home/recent_listings.dart';
import '../../widgets/noproperty_found.dart';

// ignore: must_be_immutable
class FilteredPropertyScreen extends StatefulWidget {
  dynamic minPrice;
  dynamic maxPrice;
  dynamic bedRooms;
  dynamic bathRooms;
  dynamic minArea;
  dynamic propertyType;
  dynamic owner;

  FilteredPropertyScreen(
      {super.key,
      required this.minPrice,
      required this.maxPrice,
      required this.bedRooms,
      required this.bathRooms,
      required this.minArea,
      required this.owner,
      required this.propertyType});

  @override
  State<FilteredPropertyScreen> createState() => _FilteredPropertyScreenState();
}

class _FilteredPropertyScreenState extends State<FilteredPropertyScreen> {
  late Future<List<FilteredPropertiesModel>> _filteredPropertyData;

  @override
  void initState() {
    super.initState();
    _filteredPropertyData = FilterApi.getFilteredProperies(
        propertyType: widget.propertyType,
        minPrice: widget.minPrice,
        maxPrice: widget.maxPrice,
        bedRooms: widget.bedRooms,
        bathRooms: widget.bathRooms,
        minArea: widget.minArea,
        owner: widget.owner);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Provider.of<DarkThemeProvider>(context).isDarkMode
          ? Colors.black
          : Colors.white,
      appBar: AppBar(
        backgroundColor: Provider.of<DarkThemeProvider>(context).isDarkMode
            ? Colors.black
            : Colors.white,
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
          "Your Search",
          style: appBarStyle(screenSize),
        ),
      ),
      body: FutureBuilder<List<FilteredPropertiesModel>>(
        future: _filteredPropertyData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<FilteredPropertiesModel>? data = snapshot.data;
            if (data!.isEmpty) {
              return const NoPropertyFoundWidget();
            }

            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 6),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return RecentListingsWidget(
                    id: data[index].id,
                    propertyName: data[index].name,
                    price: data[index].price,
                    bedroom: data[index].details.bedroom,
                    bathroom: data[index].details.bathroom,
                    area: data[index].details.area,
                    type: data[index].type,
                    address: data[index].address.city,
                    imgUrl: data[index].images[0],
                  );
                });
          } else if (snapshot.hasError) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenSize.height * 0.25),
                  Center(
                    child: SizedBox(
                      height: screenSize.width * 0.38,
                      child: SvgPicture.asset(AppAssets.noPropertyFound,
                          fit: BoxFit.contain),
                    ),
                  ),
                ]);
          }
          return Center(
            child: Provider.of<DarkThemeProvider>(context).isDarkMode
                ? const CircularProgressIndicator()
                : Lottie.asset(
                    AppAssets.searching,
                    height: screenSize.height * 0.15,
                  ),
          );
        },
      ),
    );
  }
}
