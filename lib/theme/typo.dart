import 'package:flutter/material.dart';

/* 글씨 타입 */
abstract class Typo {
  const Typo({
    required this.name,
    required this.light,
    required this.regular,
    required this.semiBold,
  });

  final String name;
  final FontWeight light;
  final FontWeight regular;
  final FontWeight semiBold;
}

class Pretendard implements Typo {
  const Pretendard();

  @override
  final String name = 'Pretendard';

  @override
  final FontWeight light = FontWeight.w300;

  @override
  final FontWeight regular = FontWeight.w500;

  @override
  final FontWeight semiBold = FontWeight.w600;

  @override
  final FontWeight bold = FontWeight.w800;
}
