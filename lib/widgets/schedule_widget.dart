import 'package:flutter/material.dart';

import '../theme/res/color_palette.dart';
import '../theme/res/typo.dart';

/// TODO : 일정 위젯
/// 1.제목 title
/// 2.담당자 assignee
/// 3.내용 content
/// 4.날짜 date

class ScheduleWidget extends StatelessWidget {
  final String title;
  final String content;
  final String assignee;
  final String date;
  final Color color; // task별 색상 분리

  const ScheduleWidget(
      {super.key,
      required this.title,
      required this.content,
      required this.assignee,
      required this.date,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8, left: 6, right: 6),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(.2),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            // 제목
            Text(
              title,
              style: TextStyle(
                  color: Palette.blackColor,
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: Pretendard().semiBold),
            ),
            const SizedBox(height: 12),

            // 내용
            Text(
              content,
              style: TextStyle(
                  color: Palette.contentFontColor,
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: Pretendard().regular),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),

            // 하단 정보
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  assignee,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontFamily: 'Pretendard',
                    fontWeight: Pretendard().light,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontFamily: 'Pretendard',
                    fontWeight: Pretendard().light,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
