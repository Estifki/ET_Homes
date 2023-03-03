import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../const/const.dart';

// ignore: must_be_immutable
class BannerWidget extends StatelessWidget {
  String id;
  String imageUrl;

  BannerWidget({super.key, required this.id, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.bannerDetails,
          arguments: [id, imageUrl]),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
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
        ),
      ),
    );
  }
}
