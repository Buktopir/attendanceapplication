import 'package:attendanceapplication/src/features/login/login.dart';
import 'package:attendanceapplication/src/features/register/register.dart';
import 'package:attendanceapplication/src/features/main/main.dart';

final routes = {
  '/': (context) => LoginScreen(),  '/login': (context) => LoginScreen(),
  '/main': (context) => MainScreen(),
  '/register': (context) => RegisterScreen(),
};