import 'package:flutter/material.dart';
import '../theme/color_palette.dart';

// 커스텀버튼 (통일감 있는 버튼 스타일)
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(8),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              color: Palette.primaryColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
