import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/localization/locale_bloc.dart';
import 'package:kisan_app/core/theme/theme_bloc.dart';
import 'package:kisan_app/core/utils/app_router.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';
import 'package:kisan_app/core/utils/extensions/size_extensions.dart';
import 'package:kisan_app/core/utils/ui_feedback.dart';
import 'package:kisan_app/core/widgets/common/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.appSettings),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- APPEARANCE SECTION ---
            _SettingsSectionHeader(title: context.l10n.appearance),
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                final isDark = state.themeMode == ThemeMode.dark;
                return _SettingsToggleTile(
                  icon: isDark
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  title: isDark
                      ? context.l10n.darkMode
                      : context.l10n.lightMode,
                  value: isDark,
                  onChanged: (value) {
                    context.read<ThemeBloc>().add(
                      ThemeChanged(value ? ThemeMode.dark : ThemeMode.light),
                    );
                  },
                );
              },
            ),

            24.height,

            // --- LANGUAGE SECTION ---
            _SettingsSectionHeader(title: context.l10n.changeLanguage),
            BlocBuilder<LocaleBloc, LocaleState>(
              builder: (context, state) {
                // final isHindi = state.locale.languageCode == 'hi';
                return Column(
                  children: [
                    _SettingsRadioTile<String>(
                      title: 'English',
                      value: 'en',
                      groupValue: state.locale.languageCode,
                      onChanged: (value) {
                        context.read<LocaleBloc>().add(
                          ChangeLocale(Locale('en')),
                        );
                      },
                    ),
                    _SettingsRadioTile<String>(
                      title: 'हिंदी',
                      value: 'hi',
                      groupValue: state.locale.languageCode,
                      onChanged: (value) {
                        context.read<LocaleBloc>().add(
                          const ChangeLocale(Locale('hi')),
                        );
                      },
                    ),
                  ],
                );
              },
            ),

            24.height,

            // --- NOTIFICATIONS SECTION ---
            _SettingsSectionHeader(title: context.l10n.notifications),
            _SettingsToggleTile(
              icon: Icons.notifications_none_rounded,
              title: 'Travel Alerts',
              value: true,
              onChanged: (value) {
                UIFeedback.showSnackbar(context, context.l10n.comingSoon);
              },
            ),

            24.height,

            // --- LEGAL SECTION ---
            _SettingsSectionHeader(title: 'Legal'),
            _SettingsNavTile(
              icon: Icons.privacy_tip_outlined,
              title: context.l10n.privacyPolicy,
              onTap: () => context.push(AppRouter.privacyPolicy),
            ),
            _SettingsNavTile(
              icon: Icons.description_outlined,
              title: context.l10n.termsOfService,
              onTap: () => context.push(AppRouter.termsOfService),
            ),

            40.height,
            Center(
              child: Text(
                context.l10n.versionText,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSectionHeader extends StatelessWidget {
  final String title;
  const _SettingsSectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title.toUpperCase(),
        style: context.textTheme.labelLarge?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SettingsToggleTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsToggleTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outline.withOpacity(0.1)),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: context.textTheme.bodyLarge),
        trailing: Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
      ),
    );
  }
}

class _SettingsRadioTile<T> extends StatelessWidget {
  final String title;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;

  const _SettingsRadioTile({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outline.withOpacity(0.1)),
      ),
      child: RadioListTile<T>(
        title: Text(title, style: context.textTheme.bodyLarge),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class _SettingsNavTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsNavTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outline.withOpacity(0.1)),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: context.textTheme.bodyLarge),
        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
