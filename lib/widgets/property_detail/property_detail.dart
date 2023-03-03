import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';

import 'package:provider/provider.dart';
import 'package:real_estate_project/services/provider/dark_theme.dart';
import 'package:real_estate_project/utility/toast/show_message.dart';
import 'package:real_estate_project/widgets/property_detail/related_properties.dart';
import '../../screen/agent/agent.dart';
import '../../screen/auth.dart';
import '../../services/auth/auth.dart';
import '../../utility/google_maps.dart';
import '../../services/provider/save_for_later.dart';
import '/const/const.dart';

import '../../services/provider/location.dart';
import '/widgets/property_detail/amenties.dart';

import '/model/property_detail.dart';
import 'agent.dart';

// ignore: must_be_immutable
class PropertyDetailWidget extends StatefulWidget {
  String id;
  String propertyName;
  dynamic price;
  String paymentStatus;
  bool isFurnished;
  String description;
  String ownerName;
  String ownerID;
  String area;
  dynamic bedRoom;
  dynamic bathRoom;
  dynamic yearBuilt;
  String propertyType;
  String city;
  String address;
  double latitude;
  double longtitude;
  List<String> imgUrl;
  List<dynamic> amenties;
  Agents agent;
  List relatedProperties;
  dynamic companyNameForAgent;

  PropertyDetailWidget({
    super.key,
    required this.id,
    required this.propertyName,
    required this.price,
    required this.paymentStatus,
    required this.isFurnished,
    required this.description,
    required this.ownerName,
    required this.ownerID,
    required this.area,
    required this.bedRoom,
    required this.bathRoom,
    required this.yearBuilt,
    required this.propertyType,
    required this.city,
    required this.address,
    required this.latitude,
    required this.longtitude,
    required this.agent,
    required this.imgUrl,
    required this.amenties,
    required this.relatedProperties,
    required this.companyNameForAgent,
  });

  @override
  State<PropertyDetailWidget> createState() => _PropertyDetailWidgetState();
}

class _PropertyDetailWidgetState extends State<PropertyDetailWidget> {
  var formattedPrice = NumberFormat("###,###.0#", "en_US");
  bool _isbookMarkLoading = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var amentiesLenToCeil = ((widget.amenties.length) / 3).ceil();
    Provider.of<LocationProvider>(context, listen: false)
        .getDistance(widget.latitude, widget.longtitude);
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              GestureDetector(
                onTap: () => _showFullImages(context, screenSize),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: screenSize.width > 370
                        ? screenSize.height * 0.41
                        : screenSize.height * 0.42,
                    autoPlay: true,
                    viewportFraction: 1,
                    // enlargeCenterPage: true,
                  ),
                  items: widget.imgUrl
                      .map(
                        (item) => CachedNetworkImage(
                          imageUrl: item,
                          width: screenSize.width,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          // placeholder: (ctx, _) => Container(
                          //   height: screenSize.width > 370
                          //       ? screenSize.height * 0.3
                          //       : screenSize.height * 0.35,
                          //   width: screenSize.width,
                          //   color: Colors.grey.shade300,
                          // ),
                          fit: BoxFit.cover,
                        ),
                      )
                      .toList(),
                ),
              ),
              Positioned(
                top: screenSize.height * 0.02,
                left: screenSize.width * 0.04,
                child: _navigatorPop(context),
              ),
              Positioned(
                top: screenSize.width > 370
                    ? screenSize.height * 0.395
                    : screenSize.height * 0.405,
                child: Container(
                  height: screenSize.height * 0.02,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    color: Provider.of<DarkThemeProvider>(context).isDarkMode
                        ? Colors.black
                        : AppColor.lightBackground,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                  ),
                ),
              ),
            ]),
            //
            // Property Name
            //
            Padding(
              padding: EdgeInsets.only(
                  left: screenSize.width * 0.04,
                  right: screenSize.width * 0.03),
              child: Text(
                widget.propertyName.toUpperCase(),
                maxLines: 2,
                style: TextStyle(
                  fontSize: screenSize.width * 0.048,
                  fontFamily: AppFonts.semiBold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            //
            //Address
            //
            Padding(
              padding: EdgeInsets.only(left: screenSize.width * 0.04, top: 4),
              child: Text(
                widget.address,
                maxLines: 2,
                style: TextStyle(
                  fontSize: screenSize.width * 0.038,
                  fontFamily: AppFonts.medium,
                  color: AppColor.thirdColor,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            //
            //price
            //
            Padding(
              padding: EdgeInsets.only(
                  left: screenSize.width * 0.04,
                  top: 10,
                  right: screenSize.width * 0.04),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${formattedPrice.format(widget.price)} ETB",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: screenSize.width * 0.055,
                      fontFamily: AppFonts.semiBold,
                      color: AppColor.primaryColorCustom,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  //
                  // Property Bookmark
                  //
                  _isbookMarkLoading
                      ? const SizedBox()
                      : Consumer<SaveForLaterProvider>(
                          builder: (ctx, favstatus, _) {
                            return favstatus.findPropertByID(widget.id)
                                ? InkWell(
                                    onTap: () async {
                                      setState(() {
                                        _isbookMarkLoading = true;
                                      });
                                      try {
                                        Provider.of<SaveForLaterProvider>(
                                                context,
                                                listen: false)
                                            .cleanData();
                                        await Provider.of<SaveForLaterProvider>(
                                                context,
                                                listen: false)
                                            .removeSavedProperties(
                                                Provider.of<AuthProvider>(
                                                        context,
                                                        listen: false)
                                                    .userId,
                                                widget.id)
                                            .then((_) {
                                          setState(() {
                                            _isbookMarkLoading = false;
                                          });
                                        });
                                      } catch (e) {
                                        showErrorMessage(
                                            220, context, "Please try Again!");
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/bookmark_filled.svg",
                                      height: 22,
                                      color: Provider.of<DarkThemeProvider>(
                                                  context)
                                              .isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      bool isLogedin =
                                          await Provider.of<AuthProvider>(
                                                  context,
                                                  listen: false)
                                              .tokenStatus;
                                      if (isLogedin) {
                                        try {
                                          setState(() {
                                            _isbookMarkLoading = true;
                                          });
                                          Provider.of<SaveForLaterProvider>(
                                                  context,
                                                  listen: false)
                                              .cleanData();
                                          await Provider.of<
                                                      SaveForLaterProvider>(
                                                  context,
                                                  listen: false)
                                              .addToSavedProperties(
                                                  Provider.of<AuthProvider>(
                                                          context,
                                                          listen: false)
                                                      .userId,
                                                  widget.id)
                                              .then((_) {
                                            setState(() {
                                              _isbookMarkLoading = false;
                                            });
                                          });
                                        } catch (e) {
                                          showErrorMessage(220, context,
                                              "Please try Again!");
                                        }
                                      } else {
                                        showErrorMessage(250, context,
                                            "You Are Not Logged In");
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/bookmark.svg",
                                      height: 22,
                                      color: Provider.of<DarkThemeProvider>(
                                                  context)
                                              .isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  );
                          },
                        ),
                ],
              ),
            ),
            //
            // Property Owner
            //
            _paddingTop(screenSize),
            Padding(
              padding: EdgeInsets.only(
                  left: screenSize.width * 0.04,
                  right: screenSize.width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.ownerName.toUpperCase(),
                        // "${formattedPrice.format(price)} ETB",
                        style: TextStyle(
                            fontSize: screenSize.width * 0.043,
                            fontFamily: AppFonts.semiBold),
                      ),
                      Text(
                        "Owner",
                        style: TextStyle(
                            fontSize: screenSize.width * 0.033,
                            fontFamily: AppFonts.medium,
                            color: AppColor.shadeGrey),
                      )
                    ],
                  ),
                  const Spacer(),
                  //
                  //Is Furnished
                  //
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                            width: 0.5, color: AppColor.primaryColorCustom)),
                    child: widget.isFurnished
                        ? Text(
                            "Furnished",
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: screenSize.width * 0.036,
                              fontFamily: AppFonts.medium,

                              // color: AppColor.thirdColor,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        : Text(
                            "Not Furnished",
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: screenSize.width * 0.036,
                              fontFamily: AppFonts.medium,
                              // color: AppColor.thirdColor,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ),
                ],
              ),
            ),

            //
            //Amenties1
            //

            _paddingTop(screenSize),
            Padding(
              padding: EdgeInsets.only(
                  left: screenSize.width * 0.07,
                  right: screenSize.width * 0.07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Amenties1Widget(
                    quantity: widget.bedRoom,
                    quantityName: "Bedrooms",
                  ),
                  Amenties1Widget(
                    quantity: widget.bathRoom,
                    quantityName: "Bathroom",
                  ),
                  Amenties1Widget(
                    quantity: widget.yearBuilt,
                    quantityName: "Year Built",
                  ),
                  Amenties1Widget(
                    quantity: int.parse(widget.area),
                    quantityName: "Sq.M",
                  ),
                ],
              ),
            ),
            //
            //Payment Status
            //
            _paddingTop(screenSize),
            _propertyInfo(screenSize, "Payment Status"),
            Padding(
              padding: EdgeInsets.only(
                  left: screenSize.width * 0.04,
                  top: 8,
                  right: screenSize.width * 0.04),
              child: Text(
                widget.paymentStatus,
                maxLines: 10,
                style: TextStyle(
                  fontSize: screenSize.width * 0.039,
                  fontFamily: AppFonts.medium,
                  color: AppColor.thirdColor,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            //
            // House information
            //

            _paddingTop(screenSize),
            _propertyInfo(screenSize, "House information"),
            Padding(
              padding: EdgeInsets.only(
                  top: 5,
                  left: screenSize.width * 0.04,
                  right: screenSize.width * 0.04),
              child: ExpandableText(
                widget.description,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: screenSize.width * 0.04,
                    color: AppColor.thirdColor,
                    fontFamily: AppFonts.medium),
                expandText: 'More',
                collapseText: 'Less',
                maxLines: 8,
                linkColor: AppColor.primaryColorCustom,
              ),
            ),
            //
            // Photos
            //

            _paddingTop(screenSize),
            _propertyInfo(screenSize, "Gallery"),
            GestureDetector(
              onTap: () => _showFullImages(context, screenSize),
              child: SizedBox(
                height: screenSize.width > 370
                    ? screenSize.height * 0.14
                    : screenSize.height * 0.15,
                width: screenSize.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        widget.imgUrl.length > 4 ? 4 : widget.imgUrl.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                        width: screenSize.width > 370
                            ? screenSize.width * 0.23
                            : screenSize.width * 0.22,
                        margin: EdgeInsets.only(
                            top: 5, left: screenSize.width * 0.04),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: CachedNetworkImage(
                            imageUrl: widget.imgUrl[index],
                            // placeholder: (ctx, _) => Container(
                            //   height: screenSize.width > 370
                            //       ? screenSize.height * 0.12
                            //       : screenSize.height * 0.14,
                            //   width: screenSize.width > 370
                            //       ? screenSize.width * 0.19
                            //       : screenSize.width * 0.17,
                            //   color: Colors.grey.shade300,
                            // ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
              ),
            ),
            //
            //Amenties
            //
            widget.amenties.isEmpty
                ? const SizedBox()
                : _paddingTop(screenSize),
            widget.amenties.isEmpty
                ? const SizedBox()
                : _propertyInfo(screenSize, "Amenties"),
            const SizedBox(height: 6),
            widget.amenties.isEmpty
                ? const SizedBox()
                : SizedBox(
                    height: (amentiesLenToCeil * 68.0),
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 4,
                      childAspectRatio: 1.9,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(
                          left: screenSize.width * 0.04,
                          right: screenSize.width * 0.04),
                      children: List.generate(
                        widget.amenties.length,
                        (index) =>
                            Amenties2Widget(amenties: widget.amenties[index]),
                      ),
                    ),
                  ),
            //
            //Agent
            //
            const SizedBox(height: 8),
            _propertyInfo(screenSize, "Agent"),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                bool isLogedin =
                    await Provider.of<AuthProvider>(context, listen: false)
                        .tokenStatus;
                if (isLogedin) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => AgentScreen(
                        id: widget.agent.id,
                        firstName: widget.agent.firstName,
                        lastName: widget.agent.lastName,
                        email: widget.agent.email,
                        contact: widget.agent.phone,
                        imgUrl: widget.agent.profile,
                        companyNameForAgent: widget.companyNameForAgent,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => const AuthScreen(),
                    ),
                  );
                }
              },
              child: SizedBox(
                height: 56,
                child: AgentWidget(
                  firstName: widget.agent.firstName,
                  lastName: widget.agent.lastName,
                  imgUrl: widget.agent.profile,
                ),
              ),
            ),
            //
            //Location
            //
            _paddingTop(screenSize),
            _propertyInfo(screenSize, "Location"),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(
                  left: screenSize.width * 0.04,
                  right: screenSize.width * 0.04),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Card(
                        elevation: 0.5,
                        margin: const EdgeInsets.all(0),
                        child: SizedBox(
                          height: screenSize.width > 370
                              ? screenSize.height * 0.28
                              : screenSize.height * 0.32,
                          width: screenSize.width,
                          child: GoogleMapsItem(
                            latitude: widget.latitude,
                            lontitude: widget.longtitude,
                          ),
                        ),
                      ),
                    ),
                    //
                    // Distance from current Location
                    //
                    const SizedBox(height: 15),
                    Consumer<LocationProvider>(builder: (context, distance, _) {
                      double etaCar = distance.distanceFromCurrnetPostion * 0.6;
                      double etaWalking =
                          distance.distanceFromCurrnetPostion * 14;
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.personWalking,
                                  size: 17,
                                  color: AppColor.primaryColorCustom,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "${etaWalking.toStringAsFixed(2)} min",
                                  style: TextStyle(
                                      fontSize: screenSize.width * 0.04,
                                      fontFamily: AppFonts.medium),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.car,
                                    size: 17,
                                    color: AppColor.primaryColorCustom,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${etaCar.toStringAsFixed(2)} min",
                                    style: TextStyle(
                                        fontSize: screenSize.width * 0.04,
                                        fontFamily: AppFonts.medium),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "${distance.distanceFromCurrnetPostion} Km away",
                                    style: TextStyle(
                                        fontSize: screenSize.width * 0.04,
                                        fontFamily: AppFonts.medium),
                                  ),
                                ]),
                          ]);
                    }),
                  ]),
            ),
            const SizedBox(height: 15),
            Center(
              child: TextButton(
                onPressed: () => _showFullMap(screenSize, context),
                child: Text(
                  "View on Map",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.045,
                    color: AppColor.primaryColorCustom,
                    fontFamily: AppFonts.semiBold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            widget.relatedProperties.isEmpty
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.04),
                    child: Text(
                      "Related Properties",
                      style: TextStyle(
                        fontSize: AppTextSize.headerTitleSize,
                        fontFamily: AppFonts.title,
                      ),
                    ),
                  ),
            widget.relatedProperties.isEmpty
                ? Container()
                : GridView.builder(
                    shrinkWrap: true,
                    itemCount: widget.relatedProperties.length > 7
                        ? 7
                        : widget.relatedProperties.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(
                        top: 6,
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
                        id: widget.relatedProperties[index].id,
                        propertyName: widget.relatedProperties[index].name,
                        bedroom:
                            widget.relatedProperties[index].details.bedroom,
                        bathroom:
                            widget.relatedProperties[index].details.bathroom,
                        area: widget.relatedProperties[index].details.area,
                        address: widget.relatedProperties[index].address.city,
                        type: widget.relatedProperties[index].type,
                        imgUrl: widget.relatedProperties[index].images[0],
                      );
                    }),
          ]),
    );
  }

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  _showFullImages(BuildContext context, Size screenSize) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return Stack(children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.imgUrl.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 2.5),
                    child: CachedNetworkImage(
                      imageUrl: widget.imgUrl[index],
                      //  placeholder: ,
                      fit: BoxFit.cover,
                    ),
                  );
                }),
            Positioned(
              top: screenSize.height * 0.06,
              left: screenSize.width * 0.05,
              child: _navigatorPop(context),
            ),
          ]);
        });
  }

  _navigatorPop(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
          size: 19,
        ),
      ),
    );
  }

  _showFullMap(Size screenSize, BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return Stack(children: [
            GoogleMapsItem(
              latitude: widget.latitude,
              lontitude: widget.longtitude,
            ),
            Positioned(
              top: screenSize.height * 0.06,
              left: screenSize.width * 0.05,
              child: _navigatorPop(context),
            ),
          ]);
        });
  }

  _paddingTop(Size screenSize) {
    return Padding(
        padding: EdgeInsets.only(
      top: screenSize.width * 0.06,
    ));
  }

  _propertyInfo(Size screenSize, String title) {
    return Padding(
      padding: EdgeInsets.only(left: screenSize.width * 0.04),
      child: Text(
        title,
        style: TextStyle(
          fontSize: AppTextSize.headerTitleSize - 1.5,
          fontFamily: AppFonts.semiBold,
        ),
      ),
    );
  }
}
