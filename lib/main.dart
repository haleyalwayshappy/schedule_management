import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_management/view/board_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Schedule Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BoardScreen(),
    );
  }
}
