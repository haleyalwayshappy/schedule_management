import 'package:flutter/material.dart';
import 'package:schedule_management/theme/typo.dart';

import 'color_palette.dart';

// 불필요한가 싶긴하지만 재사용성을 위해 제작
// 텍스트 스타일
class AppTextStyles {
  static TextStyle noticeTextStyle = TextStyle(
    fontSize: 18,
    fontFamily: 'Pretendard',
    fontWeight: Pretendard().semiBold,
    color: Palette.primaryColor,
  );
}
