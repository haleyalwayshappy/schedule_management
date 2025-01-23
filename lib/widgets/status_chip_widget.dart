import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/schedule_controller.dart';
import '../model/task_status.dart';
import '../theme/color_palette.dart';

class StatusChipWidget extends StatelessWidget {
  final Rx<TaskStatus> selectedStatus; // 현재 선택된 상태
  final ScheduleController scheduleController = Get.find();

  StatusChipWidget({super.key, required this.selectedStatus});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: TaskStatus.values.map((status) {
        return Obx(() {
          final isSelected = selectedStatus.value == status;

          return ChoiceChip(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected ? status.color : Palette.boardBackgroundColor,
                width: 1.0,
              ),
            ),
            label: Text(
              status.label,
              style: TextStyle(
                color: isSelected ? Palette.whiteColor : Palette.blackColor,
              ),
            ),
            backgroundColor: Palette.whiteColor,
            selectedColor: status.color.withOpacity(0.8),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) {
                selectedStatus.value = status; // 선택된 status를 업데이트
              }
            },
          );
        });
      }).toList(),
    );
  }
}
