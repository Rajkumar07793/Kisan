import 'package:flutter/material.dart';

import '../../utils/extensions/context_extensions.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final TextStyle? labelStyle;
  final bool showShadow;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final fillColorNotShow;

  const CustomTextField({
    super.key,
    this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines,
    this.labelStyle,
    this.showShadow = false,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.fillColorNotShow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              labelStyle ??
              context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: context.colorScheme.primary,
              ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(maxLines == 1 ? 35 : 16),
            boxShadow: showShadow
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.025),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            maxLines: maxLines,
            minLines: minLines,
            validator: validator,
            onChanged: onChanged,
            readOnly: readOnly,
            onTap: onTap,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: context.colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hintStyle: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              filled: true,
              fillColor: context.colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(maxLines == 1 ? 35 : 16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(maxLines == 1 ? 35 : 16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(maxLines == 1 ? 35 : 16),
                borderSide: BorderSide(
                  color: context.colorScheme.primary,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(maxLines == 1 ? 35 : 16),
                borderSide: BorderSide(color: context.colorScheme.error),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
