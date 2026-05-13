import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class CustomGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final IconData? icon;
  final IconData? prefixIcon;
  final bool isLoading;

  const CustomGradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
    this.isLoading = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (isLoading) ? null : onTap,
        borderRadius: BorderRadius.circular(32),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primary.withValues(alpha: 0.35),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: (isLoading)
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (prefixIcon != null) ...[
                        const SizedBox(width: 10),
                        Icon(prefixIcon, color: AppColors.whiteColor, size: 22),
                      ],
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          text,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                      if (icon != null) ...[
                        const SizedBox(width: 10),
                        Icon(icon, color: AppColors.whiteColor, size: 22),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
