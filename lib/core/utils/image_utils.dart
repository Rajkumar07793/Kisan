class ImageUtils {
  /// Transforms a Supabase public URL to include resizing parameters.
  /// Note: This requires Supabase Image Transformation to be enabled on the project.
  static String getOptimizedImageUrl(
    String url, {
    int? width,
    int? height,
    int quality = 80,
  }) {
    if (url.isEmpty || !url.contains('supabase.co')) return url;

    // Check if it's already a transformed URL
    if (url.contains('/render/image/')) return url;

    try {
      // Basic pattern: https://[project-id].supabase.co/storage/v1/object/public/[bucket]/[path]
      // Target pattern: https://[project-id].supabase.co/storage/v1/render/image/public/[bucket]/[path]?width=...
      if (url.contains('/storage/v1/object/public/')) {
        String optimized = url.replaceFirst(
          '/storage/v1/object/public/',
          '/storage/v1/render/image/public/',
        );

        final List<String> params = [];
        if (width != null) params.add('width=${width * 2}'); // 2x for retina
        if (height != null) params.add('height=${height * 2}');
        params.add('quality=$quality');
        params.add('format=webp'); // Better compression

        if (params.isNotEmpty) {
          optimized += (optimized.contains('?') ? '&' : '?') + params.join('&');
        }
        return optimized;
      }
    } catch (e) {
      return url;
    }

    return url;
  }
}
