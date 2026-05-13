import 'package:flutter/material.dart';
import 'package:kisan_app/core/constants/app_colors.dart';

class CustomAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final VoidCallback? onTap;
  final bool showBorder;
  final Color? borderColor;

  const CustomAvatar({
    super.key,
    this.imageUrl,
    this.radius = 45,
    this.onTap,
    this.showBorder = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: showBorder ? const EdgeInsets.all(2) : null,
        decoration: showBorder
            ? BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor ?? AppColors.primary.withOpacity(0.5),
                  width: 2,
                ),
              )
            : null,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: AppColors.primary.withOpacity(0.1),
          backgroundImage: hasImage ? NetworkImage(imageUrl!) : null,
          child: !hasImage
              ? Icon(Icons.person, size: radius * 0.9, color: AppColors.primary)
              : null,
        ),
      ),
    );
  }
}
