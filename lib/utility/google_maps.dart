import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps {
  static CameraPosition getPropertyLocation(var lat, var long) {
    return CameraPosition(
      target: LatLng(lat, long),
      zoom: 14.5,
    );
  }
}

// ignore: must_be_immutable
class GoogleMapsItem extends StatelessWidget {
  double latitude;
  double lontitude;

  GoogleMapsItem({super.key, required this.latitude, required this.lontitude});
  final Completer<GoogleMapController> _controller = Completer();

  List<Marker> marker = [];

  @override
  Widget build(BuildContext context) {
    marker.add(Marker(
      draggable: true,
      markerId: const MarkerId(""),
      infoWindow: const InfoWindow(title: ""),
      position: LatLng(latitude, lontitude),
    ));
    return GoogleMap(
      mapType: MapType.normal,
      indoorViewEnabled: true,
      // trafficEnabled: true,
      // liteModeEnabled: true,
      myLocationEnabled: true,
      initialCameraPosition:
          GoogleMaps.getPropertyLocation(latitude, lontitude),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: Set.from(marker),
    );
  }
}
