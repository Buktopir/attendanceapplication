import 'package:attendanceapplication/src/ui/router/router.dart';
import 'package:attendanceapplication/src/ui/theme/light_theme.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AttendanceApplicationApp());
}

class AttendanceApplicationApp extends StatelessWidget {
  const AttendanceApplicationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AttendanceApplication',
      theme: light_theme,
      routes: routes,
    );
  }
}
