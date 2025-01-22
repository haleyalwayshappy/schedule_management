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
  Future<void> addSchedule(String newId, Schedule schedule) async {
    try {
      await _firestore
          .collection('schedules')
          .doc(newId)
          .set(schedule.toJson());
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

  /* status 단일 수정 ( 위치이동 시 필요 ) */
  Future<bool> updateTaskStatus(String id) async {
    try {
      return true;

      return true;
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
