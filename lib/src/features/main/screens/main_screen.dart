import 'package:attendanceapplication/src/features/main/main.dart';
import 'package:attendanceapplication/src/features/main/screens/news/screen/news_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: [
                NewsScreen(),
                CalendarScreen(),
                CalendarScreen(),
                PayRollScreen(),
                PayRollScreen(),
                // Добавьте другие экраны по аналогии
              ],
            ),
          ),
          AtdnBottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ],
      ),
    );
  }
}







