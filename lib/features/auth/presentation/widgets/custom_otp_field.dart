import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/constants/app_colors.dart';

class CustomOTPField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onCompleted;
  final int length;

  const CustomOTPField({
    super.key,
    required this.controller,
    this.onCompleted,
    this.length = 6,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 55,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.fillColor.withValues(alpha: 0.6),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: AppColors.primary,
        width: 1.5,
      ),
      color: Colors.white,
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      textStyle: defaultPinTheme.textStyle?.copyWith(
        color: AppColors.primary,
      ),
      decoration: defaultPinTheme.decoration?.copyWith(
        color: AppColors.primary.withValues(alpha: 0.05),
      ),
    );

    return Pinput(
      length: length,
      controller: controller,
      keyboardType: TextInputType.number,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      obscureText: false,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      onCompleted: onCompleted,
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      showCursor: true,
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 9),
            width: 20,
            height: 1,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
