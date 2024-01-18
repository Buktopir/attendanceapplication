import 'package:flutter/material.dart';

class AtdnBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  AtdnBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.table_chart, color: Colors.black),
          label: 'Tables',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work, color: Colors.black),
          label: 'Shift',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money, color: Colors.black),
          label: 'Payroll',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings, color: Colors.black),
          label: 'Settings',
        ),
      ],
    );
  }
}
