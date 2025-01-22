import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_management/view/board_screen.dart';

import 'controller/task_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(TaskController()); // GetX 컨트롤러 초기화

    return GetMaterialApp(
      title: 'Schedule Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BoardScreen(),
    );
  }
}
