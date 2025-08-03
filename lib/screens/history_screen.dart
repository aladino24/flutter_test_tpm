import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/homecontroller.dart';

class HistoryScreen extends StatelessWidget {
  final controller = Get.find<HomeController>();

  HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Absensi',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Obx(() {
        final history = controller.attendanceHistory;
        if (history.isEmpty) {
          return const Center(child: Text('Belum ada data absensi'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: history.length,
          itemBuilder: (context, index) {
            final att = history[index];
            final formattedDate =
                DateFormat('EEEE, d MMM yyyy – HH:mm').format(att.date);
            final statusText = att.locationValid ? 'Berhasil' : 'Gagal';

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                leading: Icon(
                  att.locationValid ? Icons.check_circle : Icons.cancel,
                  color: att.locationValid ? Colors.green : Colors.red,
                  size: 32,
                ),
                title: Text(
                  formattedDate,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
                subtitle: Text(
                  'Absensi $statusText',
                  style: TextStyle(
                    color: att.locationValid ? Colors.green : Colors.red,
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Detail Absensi'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(formattedDate,
                              style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 10),
                          Text(
                            'Status: ${att.locationValid ? 'Berhasil (dalam radius)' : 'Gagal (di luar radius)'}',
                            style: TextStyle(
                              color: att.locationValid
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          att.photoPath.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(att.photoPath),
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Text('Tidak ada foto'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Tutup'),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}
