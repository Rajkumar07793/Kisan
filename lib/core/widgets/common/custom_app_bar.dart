import 'package:flutter/material.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/constants/env_config.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final bool showMenuButton;
  final bool showBackButton;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final bool? showCircleAvtar;
  final bool avatarOnRight;
  final VoidCallback? onAvatarTap;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.centerTitle = false,
    this.showMenuButton = false,
    this.showBackButton = false,
    this.flexibleSpace,
    this.bottom,
    this.backgroundColor,
    this.showCircleAvtar = false,
    this.avatarOnRight = false,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    // final authState = context.watch<AuthBloc>().state;
    // final isAuthenticated = authState.status == AuthStatus.authenticated;
    // final displayImageUrl = authState.user?.profileImage;

    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.backgroundLight,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle,
      leading: _buildLeading(context),
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      title:
          titleWidget ??
          Row(
            children: [
              // if (showCircleAvtar == true &&
              //     !avatarOnRight &&
              //     isAuthenticated) ...[
              //   GestureDetector(
              //     onTap: onAvatarTap,
              //     child: CustomAvatar(imageUrl: displayImageUrl, radius: 26),
              //   ),
              //   8.width,
              // ],
              Text(
                title ?? EnvConfig.appName,
                style: context.textTheme.titleLarge?.copyWith(
                  color: const Color.fromARGB(255, 13, 10, 11),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
      actions: [
        if (actions != null) ...actions!,
        // if (showCircleAvtar == true && avatarOnRight && isAuthenticated) ...[
        //   Padding(
        //     padding: const EdgeInsets.only(right: 16.0),
        //     child: GestureDetector(
        //       onTap: onAvatarTap,
        //       child: CustomAvatar(imageUrl: displayImageUrl, radius: 18),
        //     ),
        //   ),
        // ],
      ],
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;

    if (showMenuButton) {
      return IconButton(
        icon: const Icon(Icons.menu, color: AppColors.primary),
        onPressed: () => Scaffold.of(context).openDrawer(),
      );
    }

    if (showBackButton && Navigator.of(context).canPop()) {
      return IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 20,
          color: AppColors.primary,
        ),
        onPressed: () => Navigator.of(context).pop(),
      );
    }

    return null;
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}
