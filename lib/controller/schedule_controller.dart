import 'package:get/get.dart';
import 'package:schedule_management/model/task_status.dart';
import 'package:schedule_management/service/firebase_service.dart';

import '../model/schedule.dart';

class ScheduleController extends GetxController {
  final FirebaseService fsService;

  var schedules = <Schedule>[].obs; // 파이어베이스에서 가져온 스케쥴 리스트
  Rx<DateTime> selectedDate = DateTime.now().obs; // 선택된 날짜

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  ScheduleController(this.fsService);

  @override
  void onInit() {
    super.onInit();
    loadAllSchedules();
  }

  /* 스케쥴 전체 불러오기 */
  Future<void> loadAllSchedules() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      schedules.value = await fsService.loadAllSchedules();

      print("Schedules loaded: ${schedules.length}");
    } catch (e) {
      throw Exception("Failed to load all schedules: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /* 스케쥴 추가 */
  Future<void> addSchedule({
    required String title,
    required String content,
    required String assignee,
    required DateTime date,
    required TaskStatus task,
  }) async {
    try {
      await fsService.addSchedule(
        title: title,
        content: content,
        assignee: assignee,
        date: date,
        task: task,
        existingSchedulesCount: schedules.length,
      );

      // 성공 시 스케줄 목록 새로고침
      await loadAllSchedules();
    } catch (e) {
      throw Exception("Failed to save schedule: $e");
    }
  }

  /* 스케쥴 수정 */

  Future<void> updateSchedule(Schedule schedule) async {
    try {
      await fsService.updateSchedule(schedule);

      // 기존 리스트에서 해당 스케쥴 찾기
      int index = schedules.indexWhere((s) => s.id == schedule.id);
      if (index != -1) {
        schedules[index] = schedule; // 수정된 값 반영
        schedules.refresh(); // ui에 새로고침
      }
    } catch (e) {
      throw Exception("Failed to update schedule: $e");
    }
  }

  /* TODO index, status 단일 수정 ( 위치이동 시 필요 ) */
  Future<void> updateTaskStatus(
      {required String id,
      required int index,
      required TaskStatus status}) async {
    try {
      await fsService.updateTaskStatus(id, index, status);
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
