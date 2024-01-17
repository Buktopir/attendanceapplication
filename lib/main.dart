import 'package:attendanceapplication/src/ui/router/router.dart';
import 'package:attendanceapplication/src/ui/theme/light_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AttendanceApplicationApp());
}

class AttendanceApplicationApp extends StatelessWidget {
  const AttendanceApplicationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter Project',
      theme: light_theme,
      routes: routes,
    );
  }
}
