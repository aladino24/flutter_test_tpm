import 'package:flutter/material.dart';
import 'package:flutter_test_tpm/app_data.dart';
import 'package:flutter_test_tpm/controllers/homecontroller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;
  final homeController = Get.put(HomeController());

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Email dan password tidak boleh kosong',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    final matchedUser = AppData.users.firstWhereOrNull(
      (user) => user.email == email && user.password == password,
    );

    isLoading.value = false;

    if (matchedUser != null) {
      AppData.currentUser.value = matchedUser;
      homeController.updateUserId(matchedUser.id, matchedUser.name);
      await saveLoginStatus(matchedUser.id, matchedUser.name);
      Get.offAllNamed('/main');
    } else {
      Get.snackbar(
        'Gagal Login',
        'Email atau password salah',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }


  Future<void> saveLoginStatus(String userId, String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userName', userName);
    await prefs.setString('userId', userName);
  }

  static Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<String?> getSavedUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  // username
  Future<String?> getSavedUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    Get.offAllNamed('/login');
  }

  @override
  void onClose() {
    super.onClose();
  }
}
