import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:kisan_app/core/constants/app_colors.dart';

import '../../utils/extensions/context_extensions.dart';

class CustomPhoneField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String? hint;
  final String initialCountryCode;
  final Function(PhoneNumber)? onChanged;
  final String? Function(PhoneNumber?)? validator;
  final bool showShadow;

  const CustomPhoneField({
    super.key,
    this.controller,
    required this.label,
    this.hint,
    this.initialCountryCode = 'IN',
    this.onChanged,
    this.validator,
    this.showShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
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
          child: IntlPhoneField(
            controller: controller,
            initialCountryCode: initialCountryCode,
            onChanged: onChanged,
            validator: (phone) {
              if (validator != null) {
                return validator!(phone);
              }
              return null;
            },
            dropdownIconPosition: IconPosition.trailing,
            dropdownTextStyle: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: AppColors.blackColor,
            ),
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: AppColors.blackColor,
            ),
            flagsButtonPadding: const EdgeInsets.only(left: 16),
            showDropdownIcon: true,
            dropdownIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
              color: AppColors.color5A5C5C,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColors.color5A5C5C.withOpacity(0.6),
              ),
              filled: true,
              fillColor: AppColors.fillColor.withOpacity(0.6),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide(color: context.colorScheme.error),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              counterText: '', // Hide default counter
            ),
          ),
        ),
      ],
    );
  }
}
