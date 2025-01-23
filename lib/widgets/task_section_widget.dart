import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_management/widgets/detail_schedule_dialog.dart';
import '../controller/task_controller.dart';
import '../controller/schedule_controller.dart';
import '../model/schedule.dart';
import '../model/task_status.dart';
import '../widgets/schedule_widget.dart';

class TaskSectionWidget extends StatelessWidget {
  final TaskStatus status;

  TaskSectionWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();

    return DragTarget<Schedule>(
      onWillAcceptWithDetails: (details) => details.data != null,
      onAcceptWithDetails: (details) {
        final draggedData = details.data;
        if (draggedData.status != status) {
          taskController.moveTask(
              schedule: draggedData, from: draggedData.status, to: status);
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
                : null,
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

              // 작업 리스트
              Obx(() {
                final tasks = taskController.taskMap[status]!;
                // 작업이 없을 때 메시지 표시
                if (tasks.isEmpty) {
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
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final schedule = tasks[index];
                      return DragTarget<Schedule>(
                        onWillAcceptWithDetails: (details) {
                          final draggedData = details.data;
                          return draggedData != null &&
                              draggedData.status == status;
                        },
                        onAcceptWithDetails: (details) {
                          final draggedData = details.data;
                          final draggedIndex = tasks.indexOf(draggedData);
                          if (draggedIndex == -1) {
                            print("Error: 해당 목록에서 드래그한 항목 찾을 수 없음.");
                            return;
                          }

                          // 대상 인덱스 계산
                          if (draggedIndex != index) {
                            taskController.updateTaskOrderWithinSection(
                                status: status,
                                oldIndex: draggedIndex,
                                newIndex: index);
                          }
                        },
                        builder: (context, innerCandidateData, _) {
                          return Container(
                            decoration: BoxDecoration(
                              border: innerCandidateData.isNotEmpty
                                  ? Border.all(color: status.color, width: 2.0)
                                  : null, // 드래그앤 드롭 직관적으로 확인
                            ),
                            child: GestureDetector(
                              onTap: () {
                                DetailScheduleDialog.show(schedule.id);
                                print("tap 했다${schedule.id}");
                              },
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
                                childWhenDragging: ScheduleWidget(
                                  color: status.color,
                                  title: schedule.title,
                                  content: schedule.content,
                                  assignee: schedule.assignee,
                                  date:
                                      "${schedule.date.year}년 ${schedule.date.month}월 ${schedule.date.day}일",
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
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              }),
            ],
          ),
        );
      },
    );
  }
}
