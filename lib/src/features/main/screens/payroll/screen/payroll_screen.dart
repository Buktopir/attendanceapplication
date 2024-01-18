import 'package:flutter/material.dart';

class PayRollScreen extends StatefulWidget {
  @override  _PayRollScreenState createState() => _PayRollScreenState();
}

class _PayRollScreenState extends State<PayRollScreen> {
  @override  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payroll'),
      ),
      body: Center(
        child: Text('Payroll'),
      ),
    );
  }
}