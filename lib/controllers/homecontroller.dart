import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_tpm/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../models/attendance.dart';
import 'package:hive/hive.dart';

class HomeController extends GetxController {
  final kantorLat = -6.745362;
  final kantorLng = 111.235254;
  final maxRadius = 100.0;

  var userName = ''.obs;
  var userId = ''.obs;
  var currentPosition = Rx<Position?>(null);
  var isLocationValid = false.obs;
  var selfieFile = Rx<File?>(null);
  var hasCheckedInToday = false.obs;
  var attendanceHistory = <Attendance>[].obs;

  final picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _initLocation();
    checkAttendanceToday();
    loadAttendanceHistory();
  }

  Future<void> _initLocation() async {
    try {
      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentPosition.value = pos;
      double distance = Geolocator.distanceBetween(
          pos.latitude, pos.longitude, kantorLat, kantorLng);
      isLocationValid.value = distance <= maxRadius;
    } catch (e) {
      currentPosition.value = null;
      isLocationValid.value = false;
    }
  }

  Future<void> takeSelfie() async {
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      final dir = await getApplicationDocumentsDirectory();
      final savedFile = await File(picked.path)
          .copy('${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
      selfieFile.value = savedFile;
    }
  }

  void checkIn() {
    if (isLocationValid.value && selfieFile.value != null) {
      final box = Hive.box<Attendance>('attendanceBox');

      final today = DateTime.now();
      final attendanceExists = box.values.any((att) =>
          att.userId == userId.value &&
          att.date.year == today.year &&
          att.date.month == today.month &&
          att.date.day == today.day);

      if (attendanceExists) {
        Get.snackbar('Info', 'Kamu sudah melakukan absensi hari ini',
            backgroundColor: const Color(0xFFF2DEDE),
            colorText: const Color(0xFFA94442));
        return;
      }

      box.add(Attendance(
        date: DateTime.now(),
        locationValid: isLocationValid.value,
        photoPath: selfieFile.value!.path,
        userId: userId.value,
      ));

      hasCheckedInToday.value = true;
      selfieFile.value = null;
      loadAttendanceHistory();
      Get.snackbar('Berhasil', 'Absensi berhasil dilakukan',
          backgroundColor: const Color(0xFFDFF0D8),
          colorText: const Color(0xFF3C763D));
    } else {
      Get.snackbar('Gagal', 'Lokasi atau selfie belum valid',
          backgroundColor: const Color(0xFFF2DEDE),
          colorText: const Color(0xFFA94442));
    }
  }

  Future<void> checkAttendanceToday() async {
    final box = Hive.box<Attendance>('attendanceBox');
    final today = DateTime.now();

    final savedUserId = await LoginController.getSavedUserId();

    if (savedUserId == null || savedUserId.isEmpty) {
      hasCheckedInToday.value = false;
      return;
    }

    userId.value = savedUserId;

    final attendanceToday = box.values.firstWhereOrNull((att) =>
        att.userId == userId.value &&
        att.date.year == today.year &&
        att.date.month == today.month &&
        att.date.day == today.day);

    hasCheckedInToday.value = attendanceToday != null;
  }

  Future<void> loadAttendanceHistory() async {
    final savedUserId = await LoginController.getSavedUserId();

    if (savedUserId == null || savedUserId.isEmpty) {
      attendanceHistory.value = [];
      return;
    }

    userId.value = savedUserId;

    final box = Hive.box<Attendance>('attendanceBox');
    final userAttendance =
        box.values.where((att) => att.userId == userId.value).toList();

    attendanceHistory.value = userAttendance;
  }

  void updateUserId(String newUserId, String newUserName) {
    userId.value = newUserId;
    userName.value = newUserName;
    loadAttendanceHistory();
  }
}
