import 'package:geolocator/geolocator.dart';

class Location {
  var longitude;
  var latitude;
  Future<Position> getCurrentLocation() async {
    try {
      final Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      this.latitude = position.latitude;
      this.longitude = position.longitude;
      return position;
    } catch(err) {
      print(err);
      return null;
    }
  }

}
