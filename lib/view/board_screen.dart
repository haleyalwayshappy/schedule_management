import 'package:flutter/material.dart';
import 'package:schedule_management/model/task_status.dart';
import 'package:schedule_management/widgets/schedule_widget.dart';

import '../theme/res/color_palette.dart';
import '../theme/res/typo.dart';
import '../widgets/custom_button.dart';
import '../widgets/task_section_widget.dart';

/// TODO : task 화면
/// 메인 페이지(?) 명칭 정하기 어렵구만..
///
class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "일정관리",
            style: TextStyle(
              color: Palette.primaryColor,
              fontFamily: 'Pretendard',
              fontWeight: Pretendard().bold,
            ),
          ),
          centerTitle: false,
          backgroundColor: Palette.whiteColor, // 앱바 배경색
          actions: [
            CustomButton(
              label: '일정 추가',
              onPressed: () {
                ///TODO :addScreen 에서 값을 넣을 수 있게 한다.
              },
            ),
          ],
        ),
        backgroundColor: Palette.whiteColor, // 바디 배경색
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 앱바 구분선
                Container(
                  height: 0.3,
                  color: Palette.subFontColor,
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: TaskStatus.values.map((status) {
                    return TaskSectionWidget(status: status);
                  }).toList(),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
