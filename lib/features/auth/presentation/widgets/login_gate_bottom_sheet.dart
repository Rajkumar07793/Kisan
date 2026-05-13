import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/utils/app_router.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';
import 'package:kisan_app/core/widgets/common/gradient_button.dart';

class LoginGateBottomSheet extends StatelessWidget {
  const LoginGateBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LoginGateBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 32),
          const Icon(
            Icons.lock_outline_rounded,
            size: 64,
            color: AppColors.primary,
          ),
          const SizedBox(height: 24),
          Text(
            'Join the Community',
            style: context.textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Create an account to join trips, chat with hosts, and connect with other travelers.',
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          GradientButton(
            text: 'Sign Up Now',
            onPressed: () {
              context.pop();
              context.push(AppRouter.signup);
            },
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              context.pop();
              context.push(AppRouter.login);
            },
            child: RichText(
              text: TextSpan(
                style: context.textTheme.bodyMedium,
                children: const [
                  TextSpan(text: 'Already have an account? '),
                  TextSpan(
                    text: 'Login',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
