import 'package:attendanceapplication/src/features/login/login.dart';
import 'package:attendanceapplication/src/features/register/register.dart';
import 'package:attendanceapplication/src/features/attendance/attendance.dart';

final routes = {
  '/': (context) => LoginScreen(),  '/login': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/attendance': (context) => AttendanceScreen(),
};