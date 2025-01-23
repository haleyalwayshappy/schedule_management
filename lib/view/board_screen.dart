import 'package:flutter/material.dart';

import '../model/task_status.dart';
import '../theme/app_text_styles.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "일정을 3초간 클릭하면 Task간 이동이 가능합니다.",
                  style: AppTextStyles.noticeTextStyle,
                ),
              ),

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
