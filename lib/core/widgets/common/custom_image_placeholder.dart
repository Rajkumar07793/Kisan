import 'package:flutter/material.dart';

class CustomImagePlaceholder extends StatelessWidget {
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final IconData icon;

  const CustomImagePlaceholder({
    super.key,
    required this.height,
    this.width,
    this.borderRadius,
    this.icon = Icons.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        // image: const DecorationImage(
        //   image: AssetImage('assets/images/myTripImage1.png'),
        //   fit: BoxFit.cover,
        // ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
          ),
        ),
        child: Icon(icon, color: Colors.grey, size: height),
      ),
    );
  }
}
