import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/services/provider/dark_theme.dart';

import '../../const/const.dart';
import '../../screen/filter/filter.dart';

CustomAppBar(BuildContext ctx, Widget widget) {
  Size screenSize = MediaQuery.of(ctx).size;
  return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      title: Text(
        "Zulu RealEstate",
        style: appBarStyle(screenSize),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //
            //Dark Theme
            //
            widget,
            //
            //Filter Icon
            //
            GestureDetector(
              onTap: () => showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor:
                      Provider.of<DarkThemeProvider>(ctx, listen: false)
                              .isDarkMode
                          ? Colors.black
                          : AppColor.lightBackground,
                  context: ctx,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  builder: (context) {
                    return Wrap(children: const [
                      FilterScreen(
                        ownerIdForFilter: "",
                      ),
                    ]);
                  }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon(Icons.abc,
                  //     size: 32,
                  //     color: Provider.of<DarkThemeProvider>(ctx).isDarkMode
                  //         ? AppColor.darkBackground
                  //         : AppColor.lightBackground),
                  Padding(
                    padding: EdgeInsets.only(right: screenSize.width * 0.045),
                    child: SvgPicture.asset(
                      "assets/icons/Filter.svg",
                      height: screenSize.width * 0.052,
                      color: Provider.of<DarkThemeProvider>(ctx).isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ]);
}

// import 'package:flutter/material.dart';

// import '../../const/const.dart';

// class CustomSliverAppBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return SliverAppBar(
//       backgroundColor: AppColor.primaryColorCustom,
//       centerTitle: true,
//       toolbarHeight: 56,
//       pinned: true,
//       forceElevated: true,
//       floating: true,
//       expandedHeight: screenSize.width < 370
//           ? screenSize.height * 0.3
//           : screenSize.height * 0.24,
//       title: Text(
//         "Zulu RealEst",
//         style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: screenSize.width * 0.05),
//       ),
//       flexibleSpace: Stack(children: [
//         FlexibleSpaceBar(
//           background: Opacity(
//             opacity: 0.2,
//             child: Image.asset(
//               "assets/images/img03.jpg",
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Positioned(
//             bottom: 13,
//             right: 12,
//             child: GestureDetector(
//               onTap: () {
//                 showModalBottomSheet(
//                     isScrollControlled: true,
//                     context: context,
//                     builder: (context) {
//                       return Container(
//                         height: screenSize.height * 0.8,
//                       );
//                     });
//               },
//               child: Container(
//                 height: screenSize.width * 0.08,
//                 width: screenSize.width * 0.08,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(6),
//                   color: Colors.white,
//                 ),
//                 child: Icon(
//                   Icons.filter_list_rounded,
//                   size: 28,
//                 ),
//               ),
//             ))
//       ]),
//       leading: Icon(Icons.menu),
//     );
//   }
// }
