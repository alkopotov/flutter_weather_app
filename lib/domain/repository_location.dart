import 'package:geolocator/geolocator.dart';

class LocationRepository {
  Future<Map<String, double>> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return {'latitude': 55.7522, 'longitude': 37.6156};
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return {'latitude': 55.7522, 'longitude': 37.6156};
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return {'latitude': 55.7522, 'longitude': 37.6156};
    }

    return await Geolocator.getCurrentPosition().then(
        (value) => {'latitude': value.latitude, 'longitude': value.longitude});
  }
}
