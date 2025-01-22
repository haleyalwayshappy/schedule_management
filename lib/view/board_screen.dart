import 'package:flutter/material.dart';

import '../model/task_status.dart';
import '../theme/res/color_palette.dart';
import '../widgets/task_section_widget.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "일정관리",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Palette.whiteColor,
        body: SafeArea(
          child: Column(
            children: [
              Container(height: 0.5, color: Colors.grey), // 구분선
              Expanded(
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: TaskStatus.values.map((status) {
                      return Expanded(
                        child: TaskSectionWidget(status: status),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
