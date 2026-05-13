import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/constants/enums/app_enums.dart';
import 'package:kisan_app/core/constants/sample_html.dart';
import 'package:kisan_app/core/utils/app_router.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';
import 'package:kisan_app/core/utils/ui_feedback.dart';
import 'package:kisan_app/core/widgets/common/custom_app_bar.dart';
import 'package:kisan_app/core/widgets/common/custom_avatar.dart';
import 'package:kisan_app/core/widgets/common/gradient_button.dart';
import 'package:kisan_app/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../core/constants/app_assets.dart';
import '../widgets/profile_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.successMessage != null) {
          UIFeedback.showSnackbar(context, state.successMessage!);
        }
        if (state.errorMessage != null) {
          UIFeedback.showSnackbar(context, state.errorMessage!, isError: true);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(showBackButton: false),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.status == AuthStatus.authenticated) {
              return const _AuthenticatedProfileView();
            } else {
              return const _GuestProfileView();
            }
          },
        ),
      ),
    );
  }
}

class _AuthenticatedProfileView extends StatelessWidget {
  const _AuthenticatedProfileView();

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);

    if (user == null) {
      return const Center(child: Text('User profile not found.'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          20.heightBox,

          // --- HEADER: AVATAR & INFO ---
          Row(
            children: [
              CustomAvatar(imageUrl: user.profileImage, radius: 45),
              15.widthBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.color2D2F2F,
                        fontSize: 22,
                      ),
                    ),
                    2.heightBox,
                    Text(
                      user.email,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          40.heightBox,

          // --- MENU SECTION ---
          ProfileMenuTile(
            icon: Icons.person_outline_rounded,
            title: "My Profile",
            onTap: () => context.push(AppRouter.editProfile),
          ),
          // ProfileMenuTile(
          //   icon: Icons.airplanemode_active_rounded,
          //   title: context.l10n.myTripsTitle,
          //   onTap: () {},
          // ),
          ProfileMenuTile(
            icon: Icons.lock_reset_rounded,
            title: context.l10n.changePassword,
            onTap: () => context.push(AppRouter.changePassword),
          ),
          ProfileMenuTile(
            // icon: Icons.help_outline_rounded,
            title: context.l10n.faqs,
            onTap: () => context.push(AppRouter.faqs),
            showImage: true,
            imageUrl: AppAssets.FAQIcon,
          ),
          ProfileMenuTile(
            // icon: Icons.support_agent_rounded,
            title: context.l10n.contactUs,
            imageUrl: AppAssets.contatcusIcon,
            showImage: true,
            onTap: () => context.push(AppRouter.contactUs),
          ),
          ProfileMenuTile(
            // icon: Icons.description_outlined,
            title: "Terms & Conditions",
            showImage: true,
            imageUrl: AppAssets.termsAndConditionIcon,
            onTap: () => context.push(
              AppRouter.termsOfService,
              extra: {
                'title': 'Terms & Conditions',
                'htmlContent': SampleHtml.termsOfService,
              },
            ),
          ),
          ProfileMenuTile(
            // icon: Icons.privacy_tip_outlined,
            title: context.l10n.privacyPolicy,
            showImage: true,
            imageUrl: AppAssets.privacysIcon,
            onTap: () => context.push(
              AppRouter.privacyPolicy,
              extra: {
                'title': context.l10n.privacyPolicy,
                'htmlContent': SampleHtml.privacyPolicy,
              },
            ),
          ),
          ProfileMenuTile(
            title: "Community Guidelines",
            showImage: true,
            imageUrl: AppAssets.communityIcon,
            onTap: () => context.push(
              AppRouter.communityGuidelines,
              extra: {
                'title': 'Community Guidelines',
                'htmlContent': SampleHtml.communityGuidelines,
              },
            ),
          ),
          ProfileMenuTile(
            //icon: Icons.logout_rounded,
            imageUrl: AppAssets.logoutIcon,
            title: "Logout",
            showImage: true,
            onTap: () => _showLogoutDialog(context),
          ),
          // ProfileMenuTile(
          //   icon: Icons.settings_outlined,
          //   title: context.l10n.appSettings,
          //   onTap: () => context.push(AppRouter.settings),
          // ),

          // const SizedBox(height: 40),

          // --- LOGOUT ACTION ---
          // GradientButton(
          //   text: context.l10n.logout,
          //   onPressed: () => _showLogoutDialog(context),
          //   icon: Icons.logout_rounded,
          // ),
          16.heightBox,
          OutlinedButton(
            onPressed: () => _showDeleteAccountDialog(context),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              side: BorderSide(color: AppColors.primary.withOpacity(0.15)),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Delete Account',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),

          // 24.heightBox,
          // Text(
          //   context.l10n.versionText,
          //   style: context.textTheme.bodySmall?.copyWith(
          //     color: Colors.grey[400],
          //   ),
          // ),
          20.heightBox,
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.logout_rounded,
                color: AppColors.primary,
                size: 32,
              ),
            ),
            24.heightBox,
            Text(
              'Logout?',
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            12.heightBox,
            Text(
              'Are you sure you want to log out? You will need to sign in again to access your travel stories.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            32.heightBox,
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                16.widthBox,
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.read<AuthBloc>().add(AuthLogoutRequested());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                12.heightBox,
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
              size: 28,
            ),
            const SizedBox(width: 12),
            const Text(
              'Delete Account?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: const Text(
          'This action is irreversible. All your data, including booked trips and profile details, will be permanently removed from HerStay.',
          style: TextStyle(height: 1.5),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Stay with Us',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthBloc>().add(const AuthDeleteAccountRequested());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Yes, Delete',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _GuestProfileView extends StatelessWidget {
  const _GuestProfileView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          20.heightBox,

          // --- HEADER: GUEST LOGO ---
          Center(
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    size: 50,
                    color: AppColors.primary,
                  ),
                ),
                16.heightBox,
                Text(
                  'Guest Traveler',
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                4.heightBox,
                Text(
                  'Join our safe travel community',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          30.heightBox,

          // --- JOIN BANNER ---
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.primary.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.primary.withOpacity(0.1)),
            ),
            child: Column(
              children: [
                Text(
                  'Unlock full features',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                12.heightBox,
                Text(
                  'Sign up to book trips, chat with verified hosts, and save your travel preferences.',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                24.heightBox,
                GradientButton(
                  text: 'Login / Sign Up',
                  onPressed: () => context.push(AppRouter.login),
                  height: 50,
                ),
              ],
            ),
          ),

          30.heightBox,

          // --- MENU SECTION (Limited) ---
          // ProfileMenuTile(
          //   icon: Icons.lock_reset_rounded,
          //   title: context.l10n.changePassword,
          //   onTap: () => context.push(AppRouter.changePassword),
          // ),
          ProfileMenuTile(
            title: context.l10n.faqs,
            onTap: () => context.push(AppRouter.faqs),
            showImage: true,
            imageUrl: AppAssets.FAQIcon,
          ),

          // ProfileMenuTile(
          //   icon: Icons.settings_outlined,
          //   title: context.l10n.appSettings,
          //   onTap: () => context.push(AppRouter.settings),
          // ),
          ProfileMenuTile(
            // icon: Icons.description_outlined,
            title: "Terms & Conditions",
            showImage: true,
            imageUrl: AppAssets.termsAndConditionIcon,
            onTap: () => context.push(
              AppRouter.termsOfService,
              extra: {
                'title': 'Terms & Conditions',
                'htmlContent': SampleHtml.termsOfService,
              },
            ),
          ),
          ProfileMenuTile(
            // icon: Icons.privacy_tip_outlined,
            title: context.l10n.privacyPolicy,
            showImage: true,
            imageUrl: AppAssets.privacysIcon,
            onTap: () => context.push(
              AppRouter.privacyPolicy,
              extra: {
                'title': context.l10n.privacyPolicy,
                'htmlContent': SampleHtml.privacyPolicy,
              },
            ),
          ),
          ProfileMenuTile(
            title: "Community Guidelines",
            showImage: true,
            imageUrl: AppAssets.communityIcon,
            onTap: () => context.push(
              AppRouter.communityGuidelines,
              extra: {
                'title': 'Community Guidelines',
                'htmlContent': SampleHtml.communityGuidelines,
              },
            ),
          ),
          // 24.heightBox,
          // Text(
          //   context.l10n.versionText,
          //   style: context.textTheme.bodySmall?.copyWith(
          //     color: Colors.grey[400],
          //   ),
          // ),
          20.heightBox,
        ],
      ),
    );
  }
}
