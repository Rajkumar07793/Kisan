import 'package:flutter/material.dart';
import 'package:kisan_app/core/constants/app_colors.dart';

class RoleSelectScreen extends StatelessWidget {
  final Function(String) onSelect;

  const RoleSelectScreen({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryDark,
              AppColors.primary,
              AppColors.primaryLight,
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '🌾',
                style: TextStyle(fontSize: 72),
              ),
              const SizedBox(height: 8),
              const Text(
                'किसान सेवा',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              const Text(
                'Kisan Seva',
                style: TextStyle(
                  color: Color(0xFFC8E6C9),
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'ट्रैक्टर सेवा — जुताई, कटाई, गन्ना लोडिंग और बहुत कुछ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFA5D6A7),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Text(
                      'आप कौन हैं? • Who are you?',
                      style: TextStyle(
                        color: Color(0xFFE8F5E9),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _RoleButton(
                      onTap: () => onSelect('kisan'),
                      icon: '👨‍🌾',
                      title: 'किसान / Farmer',
                      subtitle: 'ट्रैक्टर बुक करें',
                      isDark: false,
                    ),
                    const SizedBox(height: 14),
                    _RoleButton(
                      onTap: () => onSelect('owner'),
                      icon: '🚜',
                      title: 'ट्रैक्टर मालिक',
                      subtitle: 'Tractor Owner',
                      isDark: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'बुकिंग बिल्कुल मुफ्त • Booking is completely free',
                style: TextStyle(
                  color: Color(0xFF81C784),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  final VoidCallback onTap;
  final String icon;
  final String title;
  final String subtitle;
  final bool isDark;

  const _RoleButton({
    required this.onTap,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.12) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isDark
              ? Border.all(color: Colors.white.withOpacity(0.4), width: 2)
              : null,
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 36),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isDark ? Colors.white : AppColors.primaryDark,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isDark ? const Color(0xFFC8E6C9) : AppColors.gray500,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
