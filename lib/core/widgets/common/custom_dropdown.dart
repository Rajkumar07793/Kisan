import 'package:flutter/material.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';
import 'package:kisan_app/core/utils/extensions/size_extensions.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final String hint;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemLabel;
  final String? label;
  final bool isLoading;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
    required this.itemLabel,
    this.label,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: context.textTheme.titleMedium?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          8.height,
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.fillColor.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(35),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              hint: Text(
                hint,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
              isExpanded: true,
              icon: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    )
                  : const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey,
                    ),
              items: items.map((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    itemLabel(item),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.textPrimaryLight,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
