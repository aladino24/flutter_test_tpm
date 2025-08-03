import 'package:flutter_test_tpm/screens/home_screen.dart';
import 'package:flutter_test_tpm/screens/main_screen.dart';
import 'package:get/get.dart';
import 'screens/login_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
    ),
    GetPage(
      name: '/main',
      page: () => const MainScreen(),
    ),
    GetPage(
      name: '/home',
      page: () => HomeScreen(),
    ),
    // GetPage(
    //   name: '/history',
    //   page: () => HistoryScreen(),
    // ),
  ];
}
