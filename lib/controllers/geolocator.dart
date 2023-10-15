import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo5/widgets/myToast.dart';

class GeolocatorController {
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Os serviços de localização estão desativados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('As permissões de localização foram negadas');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'As permissões de localização foram negadas permanentemente, não podemos solicitar permissões.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  static formatarEndereco(String end) async {
    try {
      List<Location> locations = await locationFromAddress(end);
      if (locations.isNotEmpty) {
        double latitude = locations.first.latitude;
        double longitude = locations.first.longitude;

        return LatLng(latitude, longitude);
      } else {
        MyToast.gerarToast('Digite um endereço válido');
      }
    } catch (e) {
      MyToast.gerarToast('Digite um endereço válido');
    }
  }
}
