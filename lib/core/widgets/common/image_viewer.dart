import 'package:flutter/material.dart';

/// A reusable full-screen image viewer with pinch-to-zoom support.
///
/// Usage:
/// ```dart
/// // For a network image
/// ImageViewer.show(context, imageUrl: 'https://...');
///
/// // For an asset image
/// ImageViewer.show(context, assetPath: 'assets/images/map.png');
/// ```
class ImageViewer extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final String? heroTag;

  const ImageViewer._({this.imageUrl, this.assetPath, this.heroTag});

  /// Shows a full-screen image viewer as a dialog.
  static void show(
    BuildContext context, {
    String? imageUrl,
    String? assetPath,
    String? heroTag,
  }) {
    assert(
      imageUrl != null || assetPath != null,
      'Either imageUrl or assetPath must be provided.',
    );
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => ImageViewer._(
        imageUrl: imageUrl,
        assetPath: assetPath,
        heroTag: heroTag,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageWidget = imageUrl != null
        ? Image.network(
            imageUrl!,
            fit: BoxFit.contain,
            loadingBuilder: (_, child, progress) {
              if (progress == null) return child;
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            },
            errorBuilder: (_, __, ___) => const Icon(
              Icons.broken_image_outlined,
              color: Colors.white54,
              size: 64,
            ),
          )
        : Image.asset(assetPath!, fit: BoxFit.contain);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          // Tapping the background dismisses the viewer
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(color: Colors.black87),
          ),

          // Zoomable image
          Center(
            child: heroTag != null
                ? Hero(
                    tag: heroTag!,
                    child: InteractiveViewer(
                      minScale: 0.5,
                      maxScale: 5.0,
                      child: imageWidget,
                    ),
                  )
                : InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 5.0,
                    child: imageWidget,
                  ),
          ),

          // Close button
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            right: 16,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
