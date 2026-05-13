import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';

enum SnackBarType { success, error, info, warning }

class AppOverlays {
  /// --- CUSTOM SNACKBAR ---
  static void showSnackBar({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final color = _getColorByType(type);
    final icon = _getIconByType(type);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: duration,
        elevation: 4,
      ),
    );
  }

  /// --- CUSTOM TOAST ---
  static void showToast({
    required String message,
    SnackBarType type = SnackBarType.info,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: _getColorByType(type),
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  /// --- CUSTOM DIALOG ---
  static Future<void> showCustomDialog({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = "OK",
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    SnackBarType type = SnackBarType.info,
  }) async {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _getColorByType(type).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getIconByType(type),
                  color: _getColorByType(type),
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryLight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  if (cancelText != null)
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onCancel?.call();
                        },
                        child: Text(
                          cancelText,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                  if (cancelText != null) const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onConfirm?.call();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getColorByType(type),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(confirmText),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Color _getColorByType(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return const Color(0xFF2E7D32);
      case SnackBarType.error:
        return const Color(0xFFD32F2F);
      case SnackBarType.warning:
        return const Color(0xFFFFA000);
      case SnackBarType.info:
        return AppColors.primary;
    }
  }

  static IconData _getIconByType(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle_outline;
      case SnackBarType.error:
        return Icons.error_outline;
      case SnackBarType.warning:
        return Icons.warning_amber_rounded;
      case SnackBarType.info:
        return Icons.info_outline;
    }
  }
}
