import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_management/service/firebase_service.dart';
import 'package:schedule_management/view/board_screen.dart';

import 'controller/schedule_controller.dart';
import 'controller/task_controller.dart';
import 'firebase_options.dart';

void main() async {
  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(ScheduleController(FirebaseService()));
    Get.put(TaskController());

    return GetMaterialApp(
      title: 'Schedule Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: BoardScreen(),
    );
  }
}
