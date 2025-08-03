import 'package:flutter/material.dart';
import 'package:flutter_test_tpm/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/homecontroller.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeController());
  final loginController = Get.put(LoginController());

  String _formattedDateTime() {
    return DateFormat('EEEE, d MMMM yyyy – HH:mm:ss').format(DateTime.now());
  }

  Widget infoRow(IconData icon, String label, String value,
      {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 26, color: Colors.blue.shade600),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: valueColor ?? Colors.black87,
                  ),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Absensi Kehadiran',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () async {
              loginController.logout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Obx(() {
          final pos = controller.currentPosition.value;

          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.shade200, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Halo,',
                        style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    FutureBuilder<String?>(
                      future: loginController.getSavedUserName(),
                      builder: (context, snapshot) {
                        print(snapshot.data);
                        final userName = snapshot.data ?? 'Belum Login';
                        return Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 18),
                    Text(_formattedDateTime(),
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.shade200, width: 1.5),
                ),
                child: Column(
                  children: [
                    infoRow(
                      Icons.location_pin,
                      'Lokasi Saat Ini',
                      pos != null
                          ? 'Lat: ${pos.latitude.toStringAsFixed(6)}, Lng: ${pos.longitude.toStringAsFixed(6)}'
                          : 'Tidak tersedia',
                      valueColor: pos != null
                          ? Colors.green.shade600
                          : Colors.red.shade400,
                    ),
                    Divider(
                        color: Colors.grey.shade300, height: 28, thickness: 1),
                    infoRow(
                      Icons.gps_fixed,
                      'Status Lokasi',
                      controller.isLocationValid.value
                          ? 'Dalam Radius (Valid)'
                          : 'Diluar Radius (Tidak Valid)',
                      valueColor: controller.isLocationValid.value
                          ? Colors.green.shade600
                          : Colors.red.shade400,
                    ),
                    Divider(
                        color: Colors.grey.shade300, height: 28, thickness: 1),
                    infoRow(
                      Icons.check_circle_outline,
                      'Status Absensi',
                      controller.hasCheckedInToday.value
                          ? 'Sudah Absen'
                          : 'Belum Absen',
                      valueColor: controller.hasCheckedInToday.value
                          ? Colors.green.shade600
                          : Colors.orange.shade700,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue.shade400, width: 3),
                    color: Colors.white,
                  ),
                  child: ClipOval(
                    child: controller.selfieFile.value != null
                        ? Image.file(
                            controller.selfieFile.value!,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: Colors.blue.shade50,
                            child: Icon(
                              Icons.account_circle_outlined,
                              color: Colors.blue.shade200,
                              size: 120,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: controller.takeSelfie,
                      icon: const Icon(Icons.camera_alt_outlined,
                          color: Colors.white, size: 18),
                      label: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                        child: Text(
                          'Ambil Selfie',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        minimumSize: const Size.fromHeight(48),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    final enabled = controller.isLocationValid.value &&
                        controller.selfieFile.value != null &&
                        !controller.hasCheckedInToday.value;

                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: enabled ? controller.checkIn : null,
                        icon: const Icon(
                          Icons.check_circle_outline,
                          size: 18,
                        ),
                        label: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 8),
                          child: Text(
                            controller.hasCheckedInToday.value
                                ? 'Sudah Absen'
                                : 'Absen Sekarang',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              enabled ? Colors.green.shade600 : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          minimumSize: const Size.fromHeight(48),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
