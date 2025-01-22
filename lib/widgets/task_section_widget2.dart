import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_management/controller/task_controller.dart';
import 'package:schedule_management/model/task_status.dart';
import 'package:schedule_management/theme/res/color_palette.dart';
import 'package:schedule_management/widgets/schedule_widget.dart';

import '../model/schedule.dart';
import '../theme/res/typo.dart';

/// TODO :작업 위젯
/// ['할일','급한일','진행중','완료']
class TaskSectionWidget2 extends StatelessWidget {
  final TaskStatus status;
  final TaskController _controller = Get.find();

  TaskSectionWidget2({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // List<Schedule> schedules = generateDummyData();

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Palette.boardBackgroundColor,
        // border: Border.all(color: status.color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              status.label, // 상태
              style: TextStyle(
                color: status.color,
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: Pretendard().semiBold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() {
            final schedules = _controller.taskMap[status];
            return ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // 내부 스크롤 금지
              itemCount: schedules!.length,
              onReorder: (oldIndex, newIndex) {
                if (newIndex > oldIndex) newIndex -= 1;

                final movedItem = schedules.removeAt(oldIndex);

                // 옮기려는 위치의 섹션 결정
                if (newIndex < 0 || newIndex >= schedules.length) {
                  _controller.moveTask(
                    movedItem,
                    movedItem.status,
                    _determineNewStatus(newIndex),
                  );
                } else {
                  schedules.insert(newIndex, movedItem);
                }
              },
              itemBuilder: (context, index) {
                final schedule = schedules[index];
                return ScheduleWidget(
                    key: ValueKey(schedule),
                    color: status.color,
                    title: schedule.title,
                    content: schedule.content,
                    assignee: schedule.assignee,
                    date: "2024년 12월 24일");
              },
            );
          }),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  // 상태 변경을 위한 새 섹션 결정 로직
  TaskStatus _determineNewStatus(int newIndex) {
    switch (newIndex) {
      case 0:
        return TaskStatus.todo;
      case 1:
        return TaskStatus.urgent;
      case 2:
        return TaskStatus.inProgress;
      case 3:
        return TaskStatus.done;
      default:
        return TaskStatus.todo;
    }
  }
}
