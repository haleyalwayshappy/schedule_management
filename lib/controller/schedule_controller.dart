import 'package:get/get.dart';
import 'package:schedule_management/model/task_status.dart';
import 'package:schedule_management/service/firebase_service.dart';

import '../model/schedule.dart';

class ScheduleController extends GetxController {
  final FirebaseService fsService;

  // 파이어베이스에서 가져온 스케쥴 리스트
  var schedules = <Schedule>[].obs;

  // 선택된 날짜
  Rx<DateTime> selectedDate = DateTime.now().obs;

  ScheduleController(this.fsService);

  @override
  void onInit() {
    super.onInit();
    loadAllSchedules();
  }

  /* 스케쥴 전체 불러오기 */
  Future<void> loadAllSchedules() async {
    try {
      schedules.value = await fsService.loadAllSchedules();
      print("Schedules loaded: ${schedules.length}");
    } catch (e) {
      throw Exception("Failed to load all schedules: $e");
    }
  }

  /* 스케쥴 추가 */
  Future<void> addSchedule(String title, String content, String assignee,
      DateTime date, TaskStatus task) async {
    try {
      int newIndex = schedules.length + 1;
      String newId = 'schedule_${date.day}_${newIndex.toString()}';

      Schedule newSchedule = Schedule(
        index: newIndex,
        id: newId,
        title: title,
        content: content,
        assignee: assignee,
        date: date,
        status: task,
      );

      await fsService.addSchedule(newId, newSchedule);
      schedules.add(newSchedule);
    } catch (e) {
      throw Exception("Failed to save schedule: $e");
    }
  }

  /* 스케쥴 수정
  * ; bool 형을 주어 성공, 실패시 noti 진행 (괜찮으면 추후에 add , Delete 에도 하자) */
  Future<bool> updateSchedule(Schedule schedule) async {
    try {
      await fsService.updateSchedule(schedule);

      // 기존 리스트에서 해당 스케쥴 찾기
      int index = schedules.indexWhere((s) => s.id == schedule.id);
      if (index != -1) {
        schedules[index] = schedule; // 수정된 값 반영
        schedules.refresh(); // ui에 새로고침
      }
      return true;
    } catch (e) {
      throw Exception("Failed to update schedule: $e");
    }
  }

/* TODO status 단일 수정 ( 위치이동 시 필요 ) */
  Future<bool> updateTaskStatus(String id) async {
    try {
      await fsService.updateTaskStatus(id);

      return true;
    } catch (e) {
      throw Exception("Failed to update taskStatus: $e");
    }
  }

  /* 스케쥴 삭제 */
  Future<void> deleteSchedule(String id) async {
    try {
      await fsService.deleteSchedule(id);
      schedules.removeWhere((schedule) => schedule.id == id);
    } catch (e) {
      throw Exception("Failed to delete schedule: $e");
    }
  }

  /* 선택된 날짜 업데이트 */
  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }
}
