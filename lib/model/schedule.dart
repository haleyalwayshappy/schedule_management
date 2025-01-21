import 'dart:math';

import 'package:schedule_management/model/task_status.dart';

// TODO: 스케쥴 model class
class Schedule {
  final String title;
  final String assignee;
  final String content;
  final DateTime date;
  TaskStatus status;

  Schedule(
      {required this.title,
      required this.assignee,
      required this.content,
      required this.date,
      this.status = TaskStatus.todo});
}

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
