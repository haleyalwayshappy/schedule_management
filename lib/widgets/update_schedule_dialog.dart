import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_management/model/schedule.dart';
import 'package:toastification/toastification.dart';

import '../controller/schedule_controller.dart';
import '../theme/app_text_styles.dart';
import '../theme/color_palette.dart';
import '../theme/typo.dart';
import 'custom_button.dart';

class UpdateScheduleDialog {
  static void show(Schedule scheduleDetail) {
    final ScheduleController _controller = Get.find();
    final TextEditingController assigneeController = TextEditingController();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();

    Rx<DateTime> selectedDate = Rx<DateTime>(scheduleDetail.date);

    showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Palette.boardBackgroundColor, // 배경색 설정

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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "수정",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Pretendard',
                      fontWeight: Pretendard().bold,
                      color: Palette.primaryColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("작성자", style: AppTextStyles.noticeTextStyle),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: assigneeController,
                          minLines: 1,
                          maxLines: 1,
                          autocorrect: false,
                          enableSuggestions: false,
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: Pretendard().semiBold,
                            fontSize: 14,
                            letterSpacing: -0.4,
                          ),
                          decoration: InputDecoration(
                            hintText: scheduleDetail.assignee,
                            hintStyle: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: Pretendard().semiBold,
                              fontSize: 14,
                              letterSpacing: -0.4,
                              color: Palette.blackColor,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text("날짜", style: AppTextStyles.noticeTextStyle),
                      TextButton(
                        onPressed: () async {
                          final DateTime? dateTime = await showDatePicker(
                              context: context,
                              initialDate: selectedDate.value,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(3000),
                              builder: (BuildContext context, Widget? child) {
                                // 오로지 배경색을 위해
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    dialogBackgroundColor:
                                        Palette.boardBackgroundColor,
                                    colorScheme: ColorScheme.light(
                                      primary: Palette.primaryColor,
                                      onPrimary: Palette.whiteColor,
                                      onSurface: Palette.blackColor,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Palette.primaryColor,
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              });
                          if (dateTime != null) {
                            selectedDate.value = dateTime;
                          }
                        },
                        child: Obx(
                          () => Text(
                            '${selectedDate.value.year}-${selectedDate.value.month}-${selectedDate.value.day}',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: Pretendard().semiBold,
                              fontSize: 14,
                              color: Palette.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text("제목", style: AppTextStyles.noticeTextStyle),
                  TextField(
                    controller: titleController,
                    minLines: 1,
                    maxLines: 2,
                    autocorrect: false,
                    enableSuggestions: false,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: Pretendard().regular,
                      fontSize: 14,
                      letterSpacing: -0.4,
                    ),
                    decoration: InputDecoration(
                      hintText: scheduleDetail.title,
                      hintStyle: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        letterSpacing: -0.4,
                        color: Palette.blackColor,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("내용", style: AppTextStyles.noticeTextStyle),
                  TextField(
                    controller: contentController,
                    minLines: 3,
                    maxLines: 20,
                    autocorrect: false,
                    enableSuggestions: false,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: Pretendard().regular,
                      fontSize: 14,
                      letterSpacing: -0.4,
                    ),
                    decoration: InputDecoration(
                      hintText: scheduleDetail.content,
                      hintStyle: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        letterSpacing: -0.4,
                        color: Palette.blackColor,
                      ),
                      border: InputBorder.none,
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
                    Get.back(); // 다이얼로그 닫기
                  },
                ),
                ToastificationWrapper(
                  child: CustomButton(
                    label: "수정",
                    onPressed: () async {
                      // 수정 버튼 클릭 시 데이터 수정
                      Schedule editSchedule = Schedule(
                        id: scheduleDetail.id,
                        index: scheduleDetail.index,
                        title: titleController.text.isNotEmpty
                            ? titleController.text
                            : scheduleDetail.title,
                        content: contentController.text.isNotEmpty
                            ? contentController.text
                            : scheduleDetail.content,
                        assignee: assigneeController.text.isNotEmpty
                            ? assigneeController.text
                            : scheduleDetail.assignee,
                        date: _controller.selectedDate.value,
                        status: scheduleDetail.status,
                      );

                      final success =
                          await _controller.updateSchedule(editSchedule);
                      if (success) {
                        Get.back();
                        toastification.show(
                          context: context,
                          icon: const Icon(Icons.check),
                          title: Text("일정이 수정되었습니다."),
                          autoCloseDuration: const Duration(seconds: 3),
                        );
                      } else {
                        toastification.show(
                          context: context,
                          icon: const Icon(Icons.dangerous_outlined),
                          title: Text("일정 수정 중 오류가 생겼습니다."),
                          autoCloseDuration: const Duration(seconds: 3),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
