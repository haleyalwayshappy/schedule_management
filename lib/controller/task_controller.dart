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
  Future<void> moveTask(Schedule schedule, TaskStatus from, TaskStatus to,
      {int? oldIndex, int? newIndex}) async {
    final fromList = taskMap[from]!;
    final toList = taskMap[to]!;

    // 기존 리스트에서 제거
    fromList.remove(schedule);

    // 상태 업데이트 (수평 이동일 경우)
    if (from != to) {
      schedule.status = to;
    }

    // 새로운 리스트에 삽입
    if (newIndex != null && newIndex >= 0 && newIndex < toList.length) {
      // 지정된 위치에 삽입
      toList.insert(newIndex, schedule);
    } else {
      // 최하단에 위치 (추가)
      schedule.index = toList.length;
      toList.add(schedule);
    }

    // 리스트 정렬
    toList.sort((a, b) => a.index.compareTo(b.index));

    // 위치 저장 Firebase 업데이트
    try {
      await scheduleController.updateTaskStatus(
        schedule.id,
        schedule.index,
        schedule.status,
      );
      print("Firebase: Status and Index updated for ${schedule.title}");
    } catch (e) {
      print("Error updating status/index in Firebase: $e");
    }

    // 디버깅
    print("=== Task Move Completed ===");
    print(
        "Task '${schedule.title}' moved from ${from.label} to ${to.label}, Index: ${schedule.index}");
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
