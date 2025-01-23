import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_management/widgets/add_schedule_dialog.dart';

import '../controller/schedule_controller.dart';
import '../model/task_status.dart';
import '../theme/app_text_styles.dart';
import '../theme/color_palette.dart';
import '../widgets/custom_button.dart';
import '../widgets/task_section_widget.dart';

class BoardScreen extends StatelessWidget {
  final ScheduleController controller = Get.find();

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
              },
            ),
          ],
        ),
        backgroundColor: Palette.whiteColor,
        body: SafeArea(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.isLoading.value) // 로딩 상태 표시
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (controller.errorMessage.isNotEmpty) // 오류 메시지 표시
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      controller.errorMessage.value,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (controller.errorMessage.isEmpty &&
                    !controller.isLoading.value)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "일정을 3초간 클릭하면 이동이 가능합니다.",
                      style: AppTextStyles.noticeTextStyle,
                    ),
                  ),

                // Task Status Rows
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
      ),
    );
  }
}
