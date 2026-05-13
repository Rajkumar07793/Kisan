import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kisan_app/core/utils/image_utils.dart';
import 'package:kisan_app/core/widgets/common/custom_image_placeholder.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? placeholderHeight;
  final double? width;
  final BoxFit fit;
  final Color? color;
  final BlendMode? colorBlendMode;
  final IconData placeholderIcon;
  final BorderRadius? borderRadius;

  const CustomImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.placeholderHeight,
    this.width,
    this.fit = BoxFit.cover,
    this.color,
    this.colorBlendMode,
    this.placeholderIcon = Icons.image,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return CustomImagePlaceholder(
        height: placeholderHeight ?? height,
        width: width,
        icon: placeholderIcon,
        borderRadius: borderRadius,
      );
    }

    final String optimizedUrl = ImageUtils.getOptimizedImageUrl(
      imageUrl,
      width: width?.toInt(),
      height: height?.toInt(),
    );

    final bool isNetwork =
        optimizedUrl.startsWith('http') || optimizedUrl.startsWith('https');
    final bool isSvg = optimizedUrl.toLowerCase().endsWith('.svg');

    if (isSvg) {
      return isNetwork
          ? SvgPicture.network(
              optimizedUrl,
              height: height,
              width: width,
              fit: fit,
              colorFilter: color != null
                  ? ColorFilter.mode(color!, colorBlendMode ?? BlendMode.srcIn)
                  : null,
              placeholderBuilder: (context) => CustomImagePlaceholder(
                height: placeholderHeight ?? height,
                width: width,
                icon: placeholderIcon,
                borderRadius: borderRadius,
              ),
            )
          : SvgPicture.asset(
              imageUrl,
              height: height,
              width: width,
              fit: fit,
              colorFilter: color != null
                  ? ColorFilter.mode(color!, colorBlendMode ?? BlendMode.srcIn)
                  : null,
            );
    }

    return isNetwork
        ? Image.network(
            optimizedUrl,
            height: height,
            width: width,
            fit: fit,
            color: color,
            colorBlendMode: colorBlendMode,
            errorBuilder: (context, error, stackTrace) =>
                CustomImagePlaceholder(
                  height: placeholderHeight ?? height,
                  width: width,
                  icon: placeholderIcon,
                  borderRadius: borderRadius,
                ),
          )
        : Image.asset(
            imageUrl,
            height: height,
            width: width,
            fit: fit,
            color: color,
            colorBlendMode: colorBlendMode,
            errorBuilder: (context, error, stackTrace) =>
                CustomImagePlaceholder(
                  height: placeholderHeight ?? height,
                  width: width,
                  icon: placeholderIcon,
                  borderRadius: borderRadius,
                ),
          );
  }
}
