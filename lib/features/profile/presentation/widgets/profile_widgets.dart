import 'package:flutter/material.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';

class ProfileMenuTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final bool showTrailing;
  final bool showImage;
  final String? imageUrl;

  const ProfileMenuTile({
    super.key,
    this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.showTrailing = true,
    this.showImage = false,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: showImage == true
            ? Image.asset(height: 40, width: 40, fit: BoxFit.contain, imageUrl!)
            : Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: (iconColor ?? AppColors.primary).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? AppColors.primary,
                  size: 20,
                ),
              ),
        title: Text(
          title,
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: showTrailing
            ? const Icon(Icons.chevron_right_rounded, color: AppColors.primary)
            : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
