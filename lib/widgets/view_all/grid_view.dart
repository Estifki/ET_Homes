// import 'package:badges/badges.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:real_estate_project/const/const.dart';

// // ignore: must_be_immutable
// class ViewAllPropertyGridViewWidget extends StatelessWidget {
//   String id;
//   String propertyName;
//   int price;
//   int bedroom;
//   int bathroom;
//   int area;
//   String address;
//   String type;
//   String imgUrl;

//   ViewAllPropertyGridViewWidget(
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
//         margin: EdgeInsets.only(left: 6, right: 5, top: 7, bottom: 6),
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(children: [
//                 //
//                 //Image View
//                 //
//                 Container(
//                   height: screenSize.width * 0.33,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(8),
//                       topRight: Radius.circular(8),
//                     ),
//                     image: DecorationImage(
//                         image: NetworkImage(imgUrl), fit: BoxFit.cover),
//                   ),
//                 ),
//                 Positioned(
//                   right: 0.0,
//                   top: screenSize.width * 0.03,
//                   child: Badge(
//                     elevation: 0.0,
//                     padding: EdgeInsets.all(0),
//                     badgeColor: Colors.transparent,
//                     badgeContent: Container(
//                       alignment: Alignment.center,
//                       height: screenSize.height * 0.031,
//                       width: screenSize.width * 0.12,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(4),
//                           bottomLeft: Radius.circular(4),
//                         ),
//                       ),
//                       child: Text(
//                         type.replaceFirst("r", "R").replaceFirst("s", "S"),
//                         style: TextStyle(
//                             fontSize: screenSize.width * 0.032,
//                             color: Colors.black,
//                             fontFamily: AppFonts.regular),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0.0,
//                   left: 0.0,
//                   child: Container(
//                     width: screenSize.width,
//                     color: Colors.black.withOpacity(0.5),
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           top: screenSize.width * 0.01,
//                           left: screenSize.width * 0.02),
//                       child: Text(
//                         "ETB ${formattedPrice.format(price)}",
//                         maxLines: 1,
//                         style: TextStyle(
//                             fontSize: screenSize.width * 0.04,
//                             color: Colors.white,
//                             overflow: TextOverflow.ellipsis,
//                             fontFamily: AppFonts.regular),
//                       ),
//                     ),
//                   ),
//                 ),
//               ]),

//               //
//               // Property Name
//               //
//               Padding(
//                 padding: EdgeInsets.only(
//                     left: screenSize.width * 0.02,
//                     top: screenSize.width * 0.01),
//                 child: Text(
//                   propertyName,
//                   maxLines: 1,
//                   style: TextStyle(
//                       fontSize: screenSize.width * 0.039,
//                       overflow: TextOverflow.ellipsis,
//                       fontFamily: AppFonts.regular),
//                 ),
//               ),
//               //
//               // Property Name
//               //
//               BookMarkAmenties(
//                 bedRoom: bedroom.toString(),
//                 bathRoom: bathroom.toString(),
//                 propertyArea: area.toString(),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                   left: screenSize.width * 0.035,
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     AppIcons().locationPin,
//                     SizedBox(width: 3),
//                     Text(
//                       address,
//                       maxLines: 1,
//                       style: TextStyle(
//                           fontSize: screenSize.width * 0.035,
//                           overflow: TextOverflow.ellipsis,
//                           fontFamily: AppFonts.regular),
//                     ),
//                   ],
//                 ),
//               ),
//             ]),
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

//   var textsize = TextStyle(
//     fontSize: 13,
//     fontFamily: AppFonts.regular,
//   );

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return Padding(
//       padding: EdgeInsets.only(
//         top: 2,
//         left: screenSize.width * 0.035,
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
