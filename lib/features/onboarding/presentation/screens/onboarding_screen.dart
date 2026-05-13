import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kisan_app/core/constants/app_assets.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/constants/env_config.dart';
import 'package:kisan_app/core/constants/shared_preference_keys.dart';
import 'package:kisan_app/core/services/injection_container.dart';
import 'package:kisan_app/core/utils/app_router.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';
import 'package:kisan_app/core/widgets/common/custom_loader.dart';
import 'package:kisan_app/core/widgets/common/gradient_button.dart';
import 'package:kisan_app/data/providers/local/storage_service.dart';
import 'package:kisan_app/features/onboarding/domain/entities/onboarding_entity.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  Future<void> _completeOnboarding() async {
    await sl<StorageService>().setBool(
      SharedPreferenceKeys.hasSeenOnboarding,
      true,
    );
    if (mounted) {
      context.go(AppRouter.home);
    }
  }

  List<OnboardingEntity> _getPages(BuildContext context) => [
    OnboardingEntity(
      tagline: context.l10n.onboarding1Tagline,
      title: context.l10n.onboarding1Title,
      description: context.l10n.onboarding1Desc,
      assetPath: AppAssets.onboarding1,
      coloredWords: const ['kisan_app'],
    ),
    OnboardingEntity(
      tagline: context.l10n.onboarding2Tagline,
      title: context.l10n.onboarding2Title,
      description: context.l10n.onboarding2Desc,
      assetPath: AppAssets.onboarding4,
      coloredWords: const ['safety'],
    ),
    OnboardingEntity(
      tagline: context.l10n.onboarding3Tagline,
      title: context.l10n.onboarding3Title,
      description: context.l10n.onboarding3Desc,
      assetPath: AppAssets.onboarding2,
      coloredWords: const ['Be', 'yourself,'],
    ),
    OnboardingEntity(
      tagline: context.l10n.onboarding4Tagline,
      title: context.l10n.onboarding4Title,
      description: context.l10n.onboarding4Desc,
      assetPath: AppAssets.onboarding2,
      coloredWords: const ['in', 'control'],
    ),
    OnboardingEntity(
      tagline: context.l10n.onboarding5Tagline,
      title: context.l10n.onboarding5Title,
      description: context.l10n.onboarding5Desc,
      assetPath: AppAssets.onboarding3,
      coloredWords: const ['together.'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = _getPages(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // --- TOP BAR ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    EnvConfig.appName,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                  TextButton(
                    onPressed: _completeOnboarding,
                    child: Text(
                      context.l10n.skip,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- MAIN PAGE CONTENT ---
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  return OnboardingPage(entity: pages[index]);
                },
              ),
            ),

            // --- BOTTOM SECTION ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                children: [
                  // Specific Figma Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 6,
                        width: _currentPage == index ? 24 : 6,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  48.heightBox,

                  // New Gradient Button
                  GradientButton(
                    text: _currentPage == pages.length - 1
                        ? context.l10n.getStarted
                        : context.l10n.next,
                    icon: _currentPage == pages.length - 1
                        ? null
                        : Icons.arrow_forward,
                    onPressed: () {
                      if (_currentPage < pages.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } else {
                        _completeOnboarding();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingEntity entity;

  const OnboardingPage({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // --- ILLUSTRATION BOX (Handles Single or Asymmetric Layout) ---
          Expanded(
            flex: 3,
            child: entity.secondaryAssetPath != null
                ? Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Main Image Component
                      Positioned.fill(
                        top: 0,
                        right: 40,
                        bottom: 40,
                        child: _buildAsset(entity.assetPath),
                      ),
                      // Overlapping Secondary Image
                      Positioned(
                        right: 0,
                        bottom: 40,
                        child: Container(
                          height: 140,
                          width: 140,
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _buildAsset(entity.secondaryAssetPath!),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : _buildAsset(entity.assetPath),
          ),
          40.heightBox,

          // --- TEXT CONTENT ---
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: entity.description.contains('•')
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  if (entity.tagline != null) ...[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        entity.tagline!,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    12.heightBox,
                  ],
                  Align(
                    alignment: Alignment.center,
                    child: _buildTitle(context),
                  ),
                  16.heightBox,
                  Text(
                    entity.description,
                    style: context.textTheme.bodyMedium?.copyWith(height: 1.5),
                    textAlign: entity.description.contains('•')
                        ? TextAlign.left
                        : TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper to build either SVG or standard Image
  Widget _buildAsset(String path) {
    if (path.endsWith('.svg')) {
      return SvgPicture.asset(
        path,
        fit: BoxFit.contain,
        placeholderBuilder: (context) => const CustomLoader(size: 40),
      );
    } else {
      return Image.asset(path, fit: BoxFit.contain);
    }
  }

  Widget _buildTitle(BuildContext context) {
    if (entity.coloredWords.isEmpty) {
      return Text(
        entity.title,
        style: context.textTheme.headlineMedium?.copyWith(
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      );
    }

    final children = <TextSpan>[];
    final parts = entity.title.split(' ');

    for (var i = 0; i < parts.length; i++) {
      final part = parts[i];
      final isColored = entity.coloredWords.contains(part);
      children.add(
        TextSpan(
          text: '$part${i == parts.length - 1 ? '' : ' '}',
          style: TextStyle(
            color: isColored ? AppColors.primary : Colors.black87,
          ),
        ),
      );
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: context.textTheme.headlineMedium,
        children: children,
      ),
    );
  }
}
