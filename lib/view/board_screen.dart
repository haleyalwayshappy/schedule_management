import 'package:flutter/material.dart';

import '../model/task_status.dart';
import '../theme/color_palette.dart';
import '../widgets/add_Schedule_dialog.dart';
import '../widgets/custom_button.dart';
import '../widgets/task_section_widget.dart';

class BoardScreen extends StatelessWidget {
  // ScheduleController controller = Get.find();

  BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "일정관리",
            style: TextStyle(
              color: Palette.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
          backgroundColor: Palette.whiteColor,
          toolbarHeight: 60.0, // AppBar 높이
          actions: [
            CustomButton(
                label: "일정추가",
                onPressed: () {
                  AddScheduleDialog.show(context);
                })
          ],
        ),
        backgroundColor: Palette.whiteColor,
        body: SafeArea(
          child: Column(
            children: [
              // Container(height: 0.5, color: Colors.grey), // 구분선
              Expanded(
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: TaskStatus.values.map((status) {
                      return Expanded(
                        child: TaskSectionWidget(status: status),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
