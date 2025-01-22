import 'package:get/get.dart';
import 'package:schedule_management/controller/schedule_controller.dart';
import '../model/schedule.dart';
import '../model/task_status.dart';

/*  이동 및 화면 기능 관련 */
class TaskController extends GetxController {
  ScheduleController scheduleController = Get.find();
  final taskMap = {
    TaskStatus.todo: <Schedule>[].obs,
    TaskStatus.urgent: <Schedule>[].obs,
    TaskStatus.inProgress: <Schedule>[].obs,
    TaskStatus.done: <Schedule>[].obs,
  };

  @override
  void onInit() {
    super.onInit();
    // ScheduleController.schedules를 구독 해서 상태를 구분한다.
    ever(scheduleController.schedules, (_) {
      categorizeTasks();
    });

    // 초기 상태 분류
    categorizeTasks();
  }

  /*  상태 분류 */
  void categorizeTasks() {
    for (var status in TaskStatus.values) {
      taskMap[status]!.assignAll(
        scheduleController.schedules
            .where((schedule) => schedule.status == status)
            .toList(),
      );
    }
  }

  /* Schedule 이동 로직 */
  void moveTask(Schedule schedule, TaskStatus from, TaskStatus to,
      {int? oldIndex, int? newIndex}) {
    // 수직 이동
    if (from == to && oldIndex != null && newIndex != null) {
      final taskList = taskMap[from]!;

      // `index` 값 업데이트
      taskList[oldIndex].index = newIndex;

      // 리스트 정렬
      taskList.sort((a, b) => a.index.compareTo(b.index));

      // 디버깅 출력
      print("=== Same Section Move ===");
      print("From Index: $oldIndex, To Index: $newIndex");
      print("Updated Task List in Section ${from.label}:");
      for (var task in taskList) {
        print(" - ${task.title} (Index: ${task.index})");
      }

      return;
    }

    // 수평이동
    if (from != to) {
      // 섹션 간 이동
      taskMap[from]?.remove(schedule);
      schedule.status = to;

      final taskList = taskMap[to]!;
      schedule.index = taskList.length; // 새로 추가된 항목은 가장 마지막에 위치
      taskList.add(schedule);

      // 리스트 정렬
      taskList.sort((a, b) => a.index.compareTo(b.index));

      // 디버깅 출력
      print("=== Cross Section Move ===");
      print(
          "Moved Task: ${schedule.title} (From: ${from.label} -> To: ${to.label})");
      print("Updated Task List in Section ${to.label}:");
      for (var task in taskList) {
        print(" - ${task.title} (Index: ${task.index})");
      }
    }
  }

  void updateTaskOrderWithinSection(
      TaskStatus status, int oldIndex, int newIndex) {
    final taskList = taskMap[status]!;
    if (newIndex != oldIndex) {
      // 엄격한 조건 완화
      final movedTask = taskList.removeAt(oldIndex);
      taskList.insert(newIndex, movedTask);

      // 디버깅 출력
      print("=== Task Order Updated ===");
      print("Updated Task List for Section ${status.label}:");
      for (var task in taskList) {
        print(" - ${task.title}");
      }
    }
  }

// void _initializeDummyData() {
//   final dummyData = generateDummyData();
//   // `index` 필드 추가
//   for (int i = 0; i < dummyData.length; i++) {
//     dummyData[i].index = i;
//   }
//   taskMap[TaskStatus.todo]!.assignAll(dummyData);
// }
}
