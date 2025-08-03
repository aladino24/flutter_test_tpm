import 'package:hive/hive.dart';

part 'attendance.g.dart';

@HiveType(typeId: 0)
class Attendance {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  bool locationValid;

  @HiveField(2)
  String photoPath;

  @HiveField(3)
  String userId; 

  Attendance({
    required this.date,
    required this.locationValid,
    required this.photoPath,
    required this.userId,
  });
}
