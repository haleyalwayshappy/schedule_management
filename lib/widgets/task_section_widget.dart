import 'package:flutter/material.dart';
import 'package:schedule_management/model/task_status.dart';
import 'package:schedule_management/theme/res/color_palette.dart';
import 'package:schedule_management/widgets/schedule_widget.dart';

import '../model/schedule.dart';
import '../theme/res/typo.dart';

/// TODO :작업 위젯
/// ['할일','급한일','진행중','완료']
class TaskSectionWidget extends StatelessWidget {
  final TaskStatus status;
  const TaskSectionWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    List<Schedule> schedules = generateDummyData();

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Palette.boardBackgroundColor,
          // border: Border.all(color: status.color),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                status.label,
                style: TextStyle(
                    color: status.color,
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: Pretendard().semiBold),
              ),
            ),
            Column(
              children: schedules.map((schedule) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: GestureDetector(
                    child: ScheduleWidget(
                      color: status.color,
                      title: schedule.title,
                      content: schedule.content,
                      assignee: schedule.assignee,
                      date:
                          "${schedule.date.year}년 ${schedule.date.month}월 ${schedule.date.day}일", // DateTime -> String 변환
                    ),
                    onTap: () {
                      //TODO 디테일 페이지로 이동
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
