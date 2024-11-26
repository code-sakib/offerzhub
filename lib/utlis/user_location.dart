import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:offerzhub/core/globals.dart';
import 'package:offerzhub/utlis/snackbar.dart';

class UserLocation {
  static Future<void> determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    final locationPermission = await Geolocator.checkPermission();

    if (!serviceEnabled || locationPermission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      AppSnackBar.showSnackBar(
          'Enable location permission for personalised experience😐',
          colorGreen: false);
    }

    if (locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse) {
      final Position userPosition = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
          userPosition.latitude, userPosition.longitude);

      Placemark place = placemarks[0];
      userAdd = place.locality?.toLowerCase();
    }
  }
}
