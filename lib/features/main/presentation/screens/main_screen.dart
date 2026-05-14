import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';

class MainScreen extends StatelessWidget {
  final String role;
  final VoidCallback onRoleSwitch;
  final StatefulNavigationShell navigationShell;

  const MainScreen({
    super.key,
    required this.role,
    required this.onRoleSwitch,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = role == 'owner'
        ? [
            _TabItem(id: 'home', icon: '🏠', label: context.l10n.navHome),
            _TabItem(
              id: 'my_tractors',
              icon: '🚜',
              label: context.l10n.navMyTractors,
            ),
            _TabItem(
              id: 'bookings',
              icon: '📋',
              label: context.l10n.navBookings,
            ),
            _TabItem(id: 'profile', icon: '👤', label: context.l10n.navProfile),
          ]
        : [
            _TabItem(id: 'home', icon: '🏠', label: context.l10n.navHome),
            _TabItem(id: 'search', icon: '🔍', label: context.l10n.navSearch),
            _TabItem(
              id: 'my_bookings',
              icon: '📋',
              label: context.l10n.navBookings,
            ),
            _TabItem(id: 'profile', icon: '👤', label: context.l10n.navProfile),
          ];

    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.gray200)),
        ),
        child: Row(
          children: List.generate(tabs.length, (index) {
            final tab = tabs[index];
            final isSelected = navigationShell.currentIndex == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => navigationShell.goBranch(index),
                child: Container(
                  color: isSelected ? AppColors.greenPale : Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isSelected)
                        Container(
                          width: 40,
                          height: 2,
                          color: AppColors.primary,
                        ),
                      const Spacer(),
                      Text(tab.icon, style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 2),
                      Text(
                        tab.label,
                        style: TextStyle(
                          fontSize: 10,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.gray500,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildBody() {
    // If we are at the last tab, show profile.
    // Otherwise show the navigation shell (which handles branches 0, 1, 2)
    if (navigationShell.currentIndex == 3) {
      return _ProfileScreen(role: role, onSwitch: onRoleSwitch);
    }
    return navigationShell;
  }
}

class _ProfileScreen extends StatelessWidget {
  final String role;
  final VoidCallback onSwitch;
  const _ProfileScreen({required this.role, required this.onSwitch});

  @override
  Widget build(BuildContext context) {
    final isOwner = role == 'owner';
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            // height: 260,
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 40),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryDark, AppColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      isOwner ? '🚜' : '👨‍🌾',
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  isOwner ? 'रामलाल यादव' : 'अजय कुमार',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  '${isOwner ? context.l10n.host : "किसान"} • जबलपुर, म.प्र.',
                  style: const TextStyle(
                    color: Color(0xFFC8E6C9),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: 210,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.gray200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildProfileItem(
                          '📞',
                          context.l10n.mobileNumber,
                          '9876543210',
                        ),
                        _buildProfileItem(
                          '🏘️',
                          context.l10n.villageLabel,
                          'सेमरिया',
                        ),
                        _buildProfileItem(
                          '🏙️',
                          context.l10n.districtLabel,
                          'जबलपुर',
                        ),
                        _buildProfileItem(
                          '🗺️',
                          context.l10n.stateLabel,
                          'मध्य प्रदेश',
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _ProfileButton(
                    onTap: onSwitch,
                    label: isOwner
                        ? 'किसान मोड में जाएं'
                        : 'ट्रैक्टर मालिक बनें',
                    icon: '🔄',
                    isOutline: true,
                  ),
                  const SizedBox(height: 10),
                  _ProfileButton(
                    onTap: onSwitch,
                    label: context.l10n.logout,
                    icon: '🚪',
                    isRed: true,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(
    String icon,
    String label,
    String val, {
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: AppColors.gray100)),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: AppColors.gray500, fontSize: 12),
              ),
              Text(
                val,
                style: const TextStyle(
                  color: AppColors.gray800,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TabItem {
  final String id;
  final String icon;
  final String label;
  _TabItem({required this.id, required this.icon, required this.label});
}

class _ProfileButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final String icon;
  final bool isOutline;
  final bool isRed;

  const _ProfileButton({
    required this.onTap,
    required this.label,
    required this.icon,
    this.isOutline = false,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isRed
              ? AppColors.redLight
              : (isOutline ? Colors.white : AppColors.primary),
          borderRadius: BorderRadius.circular(14),
          border: isRed
              ? Border.all(color: AppColors.red, width: 1.5)
              : (isOutline
                    ? Border.all(color: AppColors.primary, width: 1.5)
                    : null),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isRed
                    ? AppColors.red
                    : (isOutline ? AppColors.primary : Colors.white),
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
