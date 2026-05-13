class OnboardingEntity {
  final String? tagline;
  final String title;
  final String description;
  final String assetPath;
  final String? secondaryAssetPath;
  final List<String> coloredWords;

  OnboardingEntity({
    this.tagline,
    required this.title,
    required this.description,
    required this.assetPath,
    this.secondaryAssetPath,
    this.coloredWords = const [],
  });
}
