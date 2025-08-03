# Aplikasi Absensi Kehadiran

Aplikasi ini merupakan sistem absensi mobile menggunakan Flutter dan GetX. Pengguna dapat login, mencatat kehadiran, dan melihat riwayat absensi berdasarkan lokasi dan waktu.

## 🚀 Cara Menjalankan Aplikasi

1. **Clone repository**

   ```bash
   git clone https://github.com/aladino24/flutter_test_tpm.git
   cd nama-folder-proyek
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Jalankan emulator atau sambungkan perangkat fisik**

4. **Run aplikasi**
   ```bash
   flutter run
   ```

## 🧩 Plugin yang Digunakan

| Plugin                                                              | Deskripsi                                   |
| ------------------------------------------------------------------- | ------------------------------------------- |
| [`get`](https://pub.dev/packages/get)                               | State management dan navigasi               |
| [`geolocator`](https://pub.dev/packages/geolocator)                 | Mengambil lokasi pengguna (GPS)             |
| [`permission_handler`](https://pub.dev/packages/permission_handler) | Mengelola permission perangkat              |
| [`hive`](https://pub.dev/packages/hive)                             | Penyimpanan lokal tanpa database            |
| [`hive_flutter`](https://pub.dev/packages/hive_flutter)             | Integrasi Hive dengan Flutter               |
| [`intl`](https://pub.dev/packages/intl)                             | Format tanggal/waktu                        |
| [`flutter_screenutil`](https://pub.dev/packages/flutter_screenutil) | Menyesuaikan tampilan ke semua ukuran layar |
| [`path_provider`](https://pub.dev/packages/path_provider)           | Mendapatkan direktori lokal perangkat       |

## 📌 Catatan Khusus

- Pastikan perangkat memiliki GPS aktif dan mengizinkan akses lokasi.
- Untuk absensi lokasi, emulator mungkin tidak memberikan lokasi yang akurat. Gunakan perangkat asli untuk pengujian yang lebih baik.
- Hive harus diinisialisasi terlebih dahulu sebelum digunakan.

## ✍️ Struktur Direktori

```
lib/
├── controllers/      # File controller GetX
├── models/           # Model data absensi
├── screens/            # Tampilan UI
│   └── login_screen.dart
│   └── home_screen.dart
├── main.dart         # Entry point aplikasi
├── routes.dart
├── app_data.dart     # Definisikan koordinat kantor, akun user serta jarak absensi
```

## 📧 Kontak Pengembang

Aladino Zulmar  
📱 LinkedIn/GitHub: github.com/aladino24
