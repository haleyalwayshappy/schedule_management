import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/task_controller.dart';
import '../model/schedule.dart';
import '../model/task_status.dart';
import '../widgets/schedule_widget.dart';

class TaskSectionWidget extends StatelessWidget {
  final TaskStatus status;
  final TaskController _controller = Get.find();

  TaskSectionWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return DragTarget<Schedule>(
      onWillAcceptWithDetails: (details) => details.data != null,
      onAcceptWithDetails: (details) {
        final draggedData = details.data;
        if (draggedData.status != status) {
          _controller.moveTask(draggedData, draggedData.status, status);
        }
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: status.color.withOpacity(0.1),
            border: candidateData.isNotEmpty
                ? Border.all(color: status.color, width: 2.0)
                : null, // 드롭 가능 여부 시각적 표시
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 섹션 제목
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  status.label,
                  style: TextStyle(
                    color: status.color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // 섹션 작업 리스트 또는 빈 상태 표시
              Obx(() {
                final schedules = _controller.taskMap[status]!;
                if (schedules.isEmpty) {
                  // 작업이 없을 때 표시
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Text(
                        "작업이 없습니다",
                        style: TextStyle(
                          color: status.color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }
                // 작업 리스트
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: schedules.length,
                  itemBuilder: (context, index) {
                    final schedule = schedules[index];
                    return DragTarget<Schedule>(
                      onWillAcceptWithDetails: (details) {
                        final draggedData = details.data;
                        return draggedData != null &&
                            draggedData.status == status;
                      },
                      onAcceptWithDetails: (details) {
                        final draggedData = details.data;
                        final draggedIndex = schedules.indexOf(draggedData);
                        if (draggedIndex == -1) {
                          print(
                              "Error: Dragged item not found in the current list.");
                          return;
                        }

                        // 대상 인덱스 계산
                        if (draggedIndex != index) {
                          _controller.updateTaskOrderWithinSection(
                              status, draggedIndex, index);
                        }
                      },
                      builder: (context, innerCandidateData, _) {
                        return Container(
                          decoration: BoxDecoration(
                            border: innerCandidateData.isNotEmpty
                                ? Border.all(color: status.color, width: 2.0)
                                : null, // 드롭 가능 여부 시각적 표시
                          ),
                          child: LongPressDraggable<Schedule>(
                            data: schedule,
                            feedback: Material(
                              color: Colors.transparent,
                              child: ScheduleWidget(
                                color: status.color,
                                title: schedule.title,
                                content: schedule.content,
                                assignee: schedule.assignee,
                                date:
                                    "${schedule.date.year}년 ${schedule.date.month}월 ${schedule.date.day}일",
                              ),
                            ),
                            childWhenDragging: Opacity(
                              opacity: 0.5,
                              child: ScheduleWidget(
                                color: status.color,
                                title: schedule.title,
                                content: schedule.content,
                                assignee: schedule.assignee,
                                date:
                                    "${schedule.date.year}년 ${schedule.date.month}월 ${schedule.date.day}일",
                              ),
                            ),
                            child: ScheduleWidget(
                              color: status.color,
                              title: schedule.title,
                              content: schedule.content,
                              assignee: schedule.assignee,
                              date:
                                  "${schedule.date.year}년 ${schedule.date.month}월 ${schedule.date.day}일",
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
