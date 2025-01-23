import 'package:schedule_management/model/task_status.dart';

import '../model/schedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /* Schedule Service */
/* 스케쥴 전체 불러오기 (전체건) */
  Future<List<Schedule>> loadAllSchedules() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('schedules').orderBy('index').get();
      return querySnapshot.docs
          .map((doc) => Schedule.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(" failed to load  all schedules : $e");
    }
  }

  /* 스케쥴 상세 불러오기 (한건) */
  Future<void> loadScheduleDetail(String id) async {
    try {
      //   TODO : 특정 다이어리 값 불러오는 로직
      //   TODO : schedule 에 값 저장
    } catch (e) {
      throw Exception(" failed to load detail schedule : $e");
    }
  }

  /* 스케쥴 추가 */
  Future<void> addSchedule({
    required String title,
    required String content,
    required String assignee,
    required DateTime date,
    required TaskStatus task,
    required int existingSchedulesCount,
  }) async {
    try {
      // ID 및 인덱스 생성
      int newIndex = existingSchedulesCount + 1;
      String newId = 'schedule_${date.day}_${newIndex.toString()}';
      // Schedule 객체 생성
      Schedule newSchedule = Schedule(
        index: newIndex,
        id: newId,
        title: title,
        content: content,
        assignee: assignee,
        date: date,
        status: task,
      );

      // Firebase에 저장
      await _firestore
          .collection('schedules')
          .doc(newId)
          .set(newSchedule.toJson());
    } catch (e) {
      throw Exception(" failed to save schedule : $e");
    }
  }

  /* 스케쥴 수정 */
  Future<void> updateSchedule(Schedule schedule) async {
    try {
      await _firestore
          .collection('schedules')
          .doc(schedule.id)
          .update(schedule.toJson());
    } catch (e) {
      throw Exception(" failed to update schedule : $e");
    }
  }

/* TODO index, status 단일 수정 ( 위치이동 시 필요 ) */
  Future<void> updateTaskStatus(String id, int index, TaskStatus status) async {
    try {
      await _firestore.collection('schedules').doc(id).update({
        'status': status.name,
        'index': index,
      });
    } catch (e) {
      throw Exception("Failed to update taskStatus: $e");
    }
  }

  /* 스케쥴 삭제 */
  Future<void> deleteSchedule(String id) async {
    try {
      await _firestore.collection('schedules').doc(id).delete();
    } catch (e) {
      throw Exception(" failed to delete schedule : $e");
    }
  }
}
