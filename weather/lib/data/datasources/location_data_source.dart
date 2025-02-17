import 'package:geolocator/geolocator.dart';
import 'package:weather/core/exception/location_error_message.dart';
import 'package:weather/core/exception/location_exception.dart';

class LocationDataSource {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    //위치 서비스 활성화 여부 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationException(
          message: LocationErrorMessage.serviceEnabled.message);
    }

    // 위치 권한 확인
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationException(
            message: LocationErrorMessage.permissionDenied.message);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationException(
          message: LocationErrorMessage.permissionDeniedForever.message);
    }

    //현재 위치 반환
    return await Geolocator.getCurrentPosition();
  }
}
