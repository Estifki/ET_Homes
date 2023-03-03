import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:badges/badges.dart' as bd;
import '../../const/const.dart';
import '../home/amenies.dart';

// ignore: must_be_immutable
class RelatedProprtiesWidget extends StatelessWidget {
  String id;
  String propertyName;
  int bedroom;
  int bathroom;
  int area;
  String address;
  String type;
  String imgUrl;

  RelatedProprtiesWidget(
      {super.key,
      required this.id,
      required this.propertyName,
      required this.bedroom,
      required this.bathroom,
      required this.area,
      required this.address,
      required this.type,
      required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Stack(children: [
      InkWell(
        onTap: () => Navigator.pushNamed(context, AppRoutes.propertyDetail,
            arguments: [id, propertyName]),
        child: Container(
          width: screenSize.width * 0.5,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                SizedBox(
                  height: screenSize.width > 370
                      ? screenSize.height * 0.14
                      : screenSize.height * 0.18,
                  width: screenSize.width * 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl: imgUrl,
                      placeholder: (context, url) => Container(
                        height: screenSize.width > 370
                            ? screenSize.height * 0.165
                            : screenSize.height * 0.185,
                        width: screenSize.width * 0.5,
                        color: Colors.grey.shade200,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    right: screenSize.width * 0.0,
                    top: screenSize.width * 0.02,
                    // child: bd.Badge(
                    //   // elevation: 0.0,
                    //   // padding: const EdgeInsets.all(0),
                    //   // badgeColor: Colors.transparent,
                    //   badgeContent: Container(
                    //       alignment: Alignment.center,
                    //       height: screenSize.height * 0.031,
                    //       width: screenSize.width * 0.11,
                    //       decoration: const BoxDecoration(
                    //         color: AppColor.primaryColorCustom,
                    //         borderRadius: BorderRadius.only(
                    //           topLeft: Radius.circular(4),
                    //           bottomLeft: Radius.circular(4),
                    //         ),
                    //       ),
                    //       child: Text(
                    //         type.replaceFirst("r", "R").replaceFirst("s", "S"),
                    //         style: TextStyle(
                    //             fontSize: screenSize.width * 0.032,
                    //             color: Colors.white,
                    //             fontFamily: AppFonts.medium),
                    //       )),
                    // ),
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
                    ))
              ]),
              const SizedBox(height: 5),
              Text(
                StringUtils.capitalize(propertyName, allWords: true),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: AppTextSize.propertyNameSize,
                    fontFamily: AppFonts.semiBold),
              ),
              const SizedBox(height: 3),
              HomeAmentiesWidget(
                bathRoom: bathroom.toString(),
                bedRoom: bedroom.toString(),
                propertyArea: area.toString(),
              ),
              const SizedBox(height: 3),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppIcons().locationPin,
                  SizedBox(width: screenSize.width * 0.008),
                  SizedBox(
                    width: screenSize.width * 0.38,
                    child: Text(
                      address,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: AppTextSize.subTextSize,
                          color: AppColor.shadeGrey,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: AppFonts.medium),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
