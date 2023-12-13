import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationController {
  Position? position;

  /// For init the Location of the user and store it to position variable
  Future initLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
    }
    return position;
  }

  ///To get the Address from the position
  Future<String> getAddress() async {
    List<Placemark> placeMark = [];
    Placemark place;
    if (position != null) {
      placeMark = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      debugPrint("Location: $placeMark");
      place = placeMark[0];
      return '${place.subLocality}${place.subLocality == "" ? "" : ","}${place.locality},${place.subAdministrativeArea}';
    } else {
      await initLocation();
      if (position != null) {
        placeMark = await placemarkFromCoordinates(
            position!.latitude, position!.longitude);
        place = placeMark[0];
        debugPrint(place.toString());
        return '${place.subLocality} ${place.subLocality == "" ? "" : ","}${place.locality},${place.subAdministrativeArea}';
      } else {
        return Future.error('Error');
      }
    }
  }

  Future<String> getCity() async {
    List<Placemark> placeMark = [];
    Placemark place;
    if (position != null) {
      placeMark = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      place = placeMark[0];
      return '${place.administrativeArea}';
      // return placeMark[0].country!;
    } else {
      await initLocation();
      if (position != null) {
        placeMark = await placemarkFromCoordinates(
            position!.latitude, position!.longitude);
        place = placeMark[0];
        return '${place.administrativeArea}';
      } else {
        return Future.error('Error');
      }
    }
  }
}
