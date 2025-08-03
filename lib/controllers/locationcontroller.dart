import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final RxBool isLocationGranted = false.obs;
  final RxBool isServiceEnabled = false.obs;

  Future<void> requestLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    isServiceEnabled.value = serviceEnabled;

    if (!serviceEnabled) {
      debugPrint('Layanan lokasi tidak aktif.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Permission lokasi ditolak.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint('Permission lokasi ditolak secara permanen.');
      return;
    }

    isLocationGranted.value = true;
    debugPrint('Permission lokasi diberikan.');
  }
}
