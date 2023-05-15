import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final currentPositionFutureProvider = FutureProvider<Position>(
  (ref) async {
    bool permissionGiven = false;
    await Geolocator.checkPermission().then((permission) {
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Geolocator.requestPermission();
        //no need to check the result of the requestPermission() call since the app will be restarted
      }
      permissionGiven = true;
    });
    if (!permissionGiven) {
      return Future.error('Permission not given');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  },
);

Future<bool> locationPermissionGiven() async {
  bool permissionGiven = false;
  await Geolocator.checkPermission().then(
    (permission) {
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Geolocator.requestPermission();
        //no need to check the result of the requestPermission() call since the app will be restarted
      }
      permissionGiven = true;
    },
  );
  return permissionGiven;
}
