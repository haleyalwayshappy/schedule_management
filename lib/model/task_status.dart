import 'package:flutter/material.dart';

// 작업 상태 enum class
enum TaskStatus {
  todo("할일", Colors.blue),
  urgent("급한일", Colors.red),
  inProgress("진행중", Colors.orange),
  done("완료", Colors.green);

  final String label;
  final Color color;

  const TaskStatus(this.label, this.color);
  bool isComplete() => this == TaskStatus.done;
}
