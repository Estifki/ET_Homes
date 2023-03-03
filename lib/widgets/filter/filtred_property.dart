import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:badges/badges.dart' as bd;
import '../../const/const.dart';
import '../home/amenies.dart';

// ignore: must_be_immutable
class FilteredPropertyWidget extends StatelessWidget {
  String id;
  String propertyName;
  int price;
  int bedroom;
  int bathroom;
  int area;
  String address;
  String type;
  String imgUrl;

  FilteredPropertyWidget(
      {super.key,
      required this.id,
      required this.propertyName,
      required this.price,
      required this.bedroom,
      required this.bathroom,
      required this.area,
      required this.type,
      required this.address,
      required this.imgUrl});

  var formattedPrice = NumberFormat("###,###.0#", "en_US");

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(AppRoutes.propertyDetail, arguments: [id, propertyName]),
      child: Container(
        height: screenSize.width > 370
            ? screenSize.height * 0.19
            : screenSize.height * 0.2,
        width: screenSize.width,
        margin: const EdgeInsets.only(left: 10, right: 12, bottom: 12),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              SizedBox(
                height: screenSize.width > 370
                    ? screenSize.height * 0.19
                    : screenSize.height * 0.2,
                width: screenSize.width * 0.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: imgUrl,
                    // placeholder: (context, url) => Center(
                    //     child: Container(
                    //   color: Colors.grey.shade300,
                    // )),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  left: screenSize.width * 0.0,
                  top: screenSize.width * 0.02,
                  // child: bd.Badge(
                  //   // elevation: 0.0,
                  //   // padding: const EdgeInsets.all(0.0),
                  //   // badgeColor: Colors.transparent,
                  //   badgeContent: Container(
                  //       alignment: Alignment.center,
                  //       height: screenSize.height * 0.031,
                  //       width: screenSize.width * 0.11,
                  //       decoration: const BoxDecoration(
                  //         color: AppColor.primaryColorCustom,
                  //         borderRadius: BorderRadius.only(
                  //           bottomRight: Radius.circular(4),
                  //           topRight: Radius.circular(4),
                  //         ),
                  //       ),
                  //       child: Text(
                  //         type.replaceFirst("r", "R").replaceFirst("s", "S"),
                  //         style: TextStyle(
                  //             fontSize: screenSize.width * 0.032,
                  //             color: Colors.white,
                  //             fontFamily: AppFonts.medium),
                  //       )),
                  child: Container(
                    alignment: Alignment.center,
                    height: screenSize.height * 0.031,
                    width: screenSize.width * 0.12,
                    decoration: const BoxDecoration(
                      color: AppColor.primaryColorCustom,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                      ),
                    ),
                    child: Text(
                      type.replaceFirst("r", "R").replaceFirst("s", "S"),
                      style: TextStyle(
                        fontSize: screenSize.width * 0.032,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ]),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringUtils.capitalize(propertyName, allWords: true),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: AppTextSize.propertyNameSize,
                        fontFamily: AppFonts.semiBold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    HomeAmentiesWidget(
                      bathRoom: bathroom.toString(),
                      bedRoom: bedroom.toString(),
                      propertyArea: area.toString(),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      address,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: AppTextSize.subTextSize,
                          color: Colors.grey.shade700,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: AppFonts.medium),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3.0, right: 4),
                          child: Text(
                            "${formattedPrice.format(price)} ETB",
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: AppFonts.bold,
                                color: AppColor.primaryColorCustom,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
