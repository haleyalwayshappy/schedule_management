import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_management/model/task_status.dart';
import 'package:schedule_management/theme/typo.dart';
import 'package:schedule_management/widgets/custom_button.dart';

import '../controller/schedule_controller.dart';
import '../theme/app_text_styles.dart';
import '../theme/color_palette.dart';

/// 다이얼로그로 스케줄 추가 화면을 구현
class AddScheduleDialog {
  static void show(BuildContext context) {
    final ScheduleController controller = Get.find();
    final TextEditingController assigneeController = TextEditingController();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    DateTime initialDay = DateTime.now();

    showDialog(
      context: context,
      barrierDismissible: false, // 다이얼로그 외부 클릭 시 닫히지 않음
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
                            hintText: "작성자를 입력해 주세요.",
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
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () async {
                          final DateTime? dateTime = await showDatePicker(
                              context: context,
                              initialDate: initialDay,
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
                            controller.updateDate(dateTime);
                          }
                        },
                        child: Obx(
                          () => Text(
                            '${controller.selectedDate.value.year} / ${controller.selectedDate.value.month} / ${controller.selectedDate.value.day}',
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
                      hintText: "제목을 입력해주세요.",
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
                  const SizedBox(height: 20),
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
                      hintText: "내용을 입력해주세요.",
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
                    Get.back();
                  },
                ),
                CustomButton(
                  label: "추가",
                  onPressed: () {
                    controller.addSchedule(
                      titleController.text,
                      contentController.text,
                      assigneeController.text,
                      controller.selectedDate.value,
                      TaskStatus.todo,
                    );

                    Get.back();
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
