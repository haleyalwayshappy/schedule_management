import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_management/model/task_status.dart';

/* 스케쥴 model class */
class Schedule {
  String id;
  String title;
  String content;
  String assignee;
  DateTime date;
  TaskStatus status;
  int index; // 추가된 필드: 리스트 내 순서를 관리

  Schedule({
    required this.id,
    required this.title,
    required this.content,
    required this.assignee,
    required this.date,
    required this.index, // 필수 매개변수로 설정
    this.status = TaskStatus.todo,
  });

  // ---- Firebase 용 json변환 로직 ----

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assignee': assignee,
      'title': title,
      'content': content,
      'date': date,
      'status': status.name,
      'index': index,
    };
  }

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      assignee: json['assignee'] as String,
      date: (json['date'] as Timestamp).toDate(),
      index: json['index'] as int,
      status: TaskStatus.fromName(json['status'] as String),
    );
  }

  // ---------------------------

  // ----- 안쓰는 것(초반부 더미데이터) ----

  List<Schedule> generateDummyData() {
    final random = Random();
    final assignees = [
      "John Doe",
      "Jane Smith",
      "Jack Brown",
      "Emily Davis",
      "Chris Johnson"
    ];
    final titles = [
      "Fix UI bug in login page",
      "Prepare presentation for meeting",
      "Update API documentation",
      "Plan marketing strategy",
      "Refactor old codebase",
      "Test new feature integration",
      "Resolve customer complaints",
      "Schedule team meeting",
      "Research competitor analysis",
      "Implement new design system",
    ];
    final contents = [
      "Lorem Ipsum is simply dummy text of the printing industry.",
      "This task is high priority and needs to be done soon.",
      "Ensure compatibility with all major browsers.",
      "Coordinate with the design team for better results.",
      "Prepare the deployment pipeline for the next release.",
    ];

    List<Schedule> dummyData = List.generate(20, (index) {
      return Schedule(
        index: index,
        id: "schedule_$index",
        title: titles[random.nextInt(titles.length)],
        content: contents[random.nextInt(contents.length)],
        assignee: assignees[random.nextInt(assignees.length)],
        date: DateTime(
          2025,
          random.nextInt(12) + 1,
          random.nextInt(30) + 1,
        ),
      );
    });
    return dummyData;
  }

  //   -----------------------------
}
