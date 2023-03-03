import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

class LocationProvider with ChangeNotifier {
  double _distanceFromCurrentPostion = 0.0;
  double get distanceFromCurrnetPostion => _distanceFromCurrentPostion;

  Future<Position> GetUserCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      rethrow;
    }
  }

  getDistance(double lat, double long) async {
    Position userPosition = await GetUserCurrentPosition();
    double distanceInMeter = Geolocator.distanceBetween(
        userPosition.latitude, userPosition.longitude, lat, long);
    _distanceFromCurrentPostion =
        double.parse((distanceInMeter / 1000).toStringAsFixed(2));
    notifyListeners();
  }
}
