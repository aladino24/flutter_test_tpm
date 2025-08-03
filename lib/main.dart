import 'package:flutter/material.dart';
import 'package:flutter_test_tpm/controllers/locationcontroller.dart';
import 'package:flutter_test_tpm/controllers/login_controller.dart';
import 'package:flutter_test_tpm/models/attendance.dart';
import 'package:flutter_test_tpm/routes.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init('${appDocDir.path}/hive');
  Hive.registerAdapter(AttendanceAdapter());
  await Hive.openBox<Attendance>('attendanceBox');

  final locationController = Get.put(LocationController());
  await locationController.requestLocationPermission();

  final isLoggedIn = await LoginController.checkLoginStatus();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Absensi App',
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? '/main' : '/login',
      getPages: AppRoutes.routes,
    );
  }
}
