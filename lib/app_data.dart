import 'package:get/get.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });
}

class AppData {
  static final users = [
    User(id: 'user1', name: 'Aladino Zulmar', email: 'admin@mail.com', password: '123456'),
    User(id: 'user2', name: 'Budi Santoso', email: 'budi@mail.com', password: 'budi123'),
  ];


// Ganti Koordinat Kantor dan Radius untuk absensi
  static const kantorLat = -6.745362;
  static const kantorLng = 111.235254;
  static const maxRadius = 100.0;

  static final currentUser = Rxn<User>();
}
