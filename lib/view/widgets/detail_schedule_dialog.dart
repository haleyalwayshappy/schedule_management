import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_management/controller/schedule_controller.dart';
import 'package:schedule_management/theme/app_text_styles.dart';
import 'package:schedule_management/theme/color_palette.dart';
import 'package:schedule_management/theme/typo.dart';
import 'package:toastification/toastification.dart';

import 'custom_button.dart';
import 'update_schedule_dialog.dart';

/* 상세 페이지 */
class DetailScheduleDialog {
  static void show(String scheduleId) {
    final ScheduleController _controller = Get.find();
    final scheduleDetail = _controller.schedules
        .firstWhere((scheduleDetail) => scheduleDetail.id == scheduleId);
    final selectedStatus = scheduleDetail.status;

    if (scheduleDetail == null) {
      Get.snackbar("오류", "일정을 찾을 수 없습니다.");
      return;
    }
    showDialog(
      context: Get.context!, // 이전 context(최신)
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Palette.boardBackgroundColor,
          contentPadding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.width * 0.7,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "일정",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Pretendard',
                      fontWeight: Pretendard().bold,
                      color: Palette.primaryColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  ChoiceChip(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: selectedStatus.color,
                        width: 1.0,
                      ),
                    ),
                    label: Text(
                      selectedStatus.label,
                      style: TextStyle(
                        color: Palette.whiteColor,
                      ),
                    ),
                    backgroundColor: Palette.whiteColor,
                    selectedColor: selectedStatus.color.withOpacity(0.8),
                    // selected: isSelected,
                    onSelected: (selected) {}, selected: true,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("날짜", style: AppTextStyles.noticeTextStyle),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${scheduleDetail.date.year}-${scheduleDetail.date.month}-${scheduleDetail.date.day}',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: Pretendard().semiBold,
                          fontSize: 14,
                          color: Palette.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text("작성자", style: AppTextStyles.noticeTextStyle),
                      const SizedBox(width: 10),
                      Text(
                        scheduleDetail.assignee,
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: Pretendard().semiBold,
                          fontSize: 14,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text("제목", style: AppTextStyles.noticeTextStyle),
                  const SizedBox(height: 10),
                  Text(
                    scheduleDetail.title,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: Pretendard().regular,
                      fontSize: 14,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text("내용", style: AppTextStyles.noticeTextStyle),
                  const SizedBox(height: 10),
                  Text(
                    scheduleDetail.content,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: Pretendard().regular,
                      fontSize: 14,
                      letterSpacing: -0.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  label: "취소",
                  onPressed: () {
                    Get.back();
                  },
                ),
                CustomButton(
                  label: "삭제",
                  onPressed: () async {
                    Get.back();
                    await _controller.deleteSchedule(scheduleDetail.id);
                    toastification.show(
                      icon: const Icon(Icons.notification_important),
                      title: Text("일정이 삭제 되었습니다."),
                      autoCloseDuration: const Duration(seconds: 3),
                    );
                  },
                ),
                CustomButton(
                  label: "수정",
                  onPressed: () {
                    Get.back();
                    UpdateScheduleDialog.show(scheduleDetail);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
