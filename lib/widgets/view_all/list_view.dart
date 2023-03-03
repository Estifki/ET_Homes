// import 'package:badges/badges.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:real_estate_project/const/const.dart';

// // ignore: must_be_immutable
// class ViewAllPropertyListViewWidget extends StatelessWidget {
//   String id;
//   String propertyName;
//   int price;
//   int bedroom;
//   int bathroom;
//   int area;
//   String address;
//   String type;
//   String imgUrl;

//   ViewAllPropertyListViewWidget(
//       {required this.id,
//       required this.propertyName,
//       required this.price,
//       required this.imgUrl,
//       required this.bedroom,
//       required this.bathroom,
//       required this.area,
//       required this.address,
//       required this.type});

//   var formattedPrice = NumberFormat("###,###.0#", "en_US");

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return InkWell(
//       onTap: () => Navigator.of(context).pushNamed(
//         AppRoutes.propertyDetail,
//         arguments: [id, propertyName],
//       ),
//       child: Container(
//         height: screenSize.width > 370
//             ? screenSize.height * 0.31
//             : screenSize.height * 0.35,
//         width: screenSize.width,
//         margin: EdgeInsets.only(left: 6, right: 6, top: 10, bottom: 4),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(10),
//         )),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             //
//             //Image View
//             //
//             Stack(children: [
//               Container(
//                 height: screenSize.height * 0.22,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10),
//                   ),
//                   child: CachedNetworkImage(
//                     imageUrl: imgUrl,
//                     width: screenSize.width,
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                     placeholder: (ctx, _) => Container(
//                       height: screenSize.width > 370
//                           ? screenSize.height * 0.3
//                           : screenSize.height * 0.35,
//                       width: screenSize.width,
//                       color: Colors.grey.shade200,
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 right: 0.0,
//                 top: screenSize.width * 0.04,
//                 child: Badge(
//                   elevation: 0.0,
//                   padding: EdgeInsets.all(0),
//                   badgeColor: Colors.transparent,
//                   badgeContent: Container(
//                     alignment: Alignment.center,
//                     height: screenSize.height * 0.031,
//                     width: screenSize.width * 0.12,
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(4),
//                         bottomLeft: Radius.circular(4),
//                       ),
//                     ),
//                     child: Text(
//                       type.replaceFirst("r", "R").replaceFirst("s", "S"),
//                       style: TextStyle(
//                           fontSize: screenSize.width * 0.032,
//                           color: Colors.black,
//                           fontFamily: AppFonts.regular),
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//             //
//             //Property Name
//             //
//             Padding(
//               padding: EdgeInsets.only(
//                   left: screenSize.width * 0.04,
//                   right: screenSize.width * 0.02,
//                   top: screenSize.height * 0.012),
//               child: Text(
//                 propertyName,
//                 maxLines: 1,
//                 style: TextStyle(
//                     fontSize: screenSize.width * 0.039,
//                     overflow: TextOverflow.ellipsis,
//                     fontFamily: AppFonts.regular),
//               ),
//             ),
//             //
//             //Property Amenties
//             //
//             BookMarkAmenties(
//               bedRoom: bedroom.toString(),
//               bathRoom: bathroom.toString(),
//               propertyArea: area.toString(),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(
//                     left: screenSize.width * 0.06,
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       AppIcons().locationPin,
//                       SizedBox(width: 5),
//                       Text(
//                         address,
//                         style: TextStyle(
//                             fontSize: screenSize.width * 0.035,
//                             fontFamily: AppFonts.regular),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(right: screenSize.width * 0.017),
//                   child: Text(
//                     "ETB ${formattedPrice.format(price)}",
//                     maxLines: 1,
//                     style: TextStyle(
//                         fontSize: screenSize.width * 0.04,
//                         color: AppColor.primaryColorCustom,
//                         fontFamily: AppFonts.regular),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
// class BookMarkAmenties extends StatelessWidget {
//   String bedRoom;
//   String bathRoom;
//   String propertyArea;

//   BookMarkAmenties(
//       {required this.bathRoom,
//       required this.bedRoom,
//       required this.propertyArea});
//   var textsize = TextStyle(fontSize: 13, fontFamily: AppFonts.regular);

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return Padding(
//       padding: EdgeInsets.only(
//         top: 2,
//         left: screenSize.width * 0.06,
//       ),
//       child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Row(
//           children: [
//             AppIcons().bedIcon,
//             Padding(
//               padding: EdgeInsets.only(left: screenSize.width * 0.008),
//               child: Text(
//                 bedRoom,
//                 style: textsize,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(width: 8),
//         Row(
//           children: [
//             AppIcons().bathIcon,
//             Padding(
//               padding: EdgeInsets.only(left: screenSize.width * 0.008),
//               child: Text(
//                 bathRoom,
//                 style: textsize,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(width: 8),
//         Row(
//           children: [
//             AppIcons().areaIcon,
//             Padding(
//               padding: EdgeInsets.only(left: screenSize.width * 0.008),
//               child: Text(
//                 propertyArea + " Sq.M",
//                 style: textsize,
//               ),
//             ),
//           ],
//         ),
//       ]),
//     );
//   }
// }
