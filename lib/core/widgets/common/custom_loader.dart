import 'package:flutter/material.dart';
import '../../utils/extensions/context_extensions.dart';

class CustomLoader extends StatelessWidget {
  final double size;
  final Color? color;

  const CustomLoader({super.key, this.size = 30.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? context.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
