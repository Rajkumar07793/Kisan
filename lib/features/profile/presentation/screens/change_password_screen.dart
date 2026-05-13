import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/utils/app_overlays.dart';
import 'package:kisan_app/core/utils/app_router.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';
import 'package:kisan_app/core/widgets/common/custom_app_bar.dart';
import 'package:kisan_app/core/widgets/common/custom_text_field.dart';
import 'package:kisan_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:kisan_app/features/auth/presentation/widgets/common_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  final bool isRecovery;
  const ChangePasswordScreen({super.key, this.isRecovery = false});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleUpdate() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthUpdatePasswordRequested(
          newPassword: _newPasswordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          AppOverlays.showSnackBar(
            context: context,
            message: state.errorMessage!,
            type: SnackBarType.error,
          );
        } else if (state.successMessage != null &&
            state.successMessage!.contains('updated')) {
          AppOverlays.showSnackBar(
            context: context,
            message: state.successMessage!,
            type: SnackBarType.success,
          );
          // If was recovery, go to login, else go back
          if (widget.isRecovery) {
            context.go(AppRouter.login);
          } else {
            context.pop();
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundLight,
          appBar: CustomAppBar(
            title: widget.isRecovery
                ? 'Set New Password'
                : context.l10n.changePassword,
            showBackButton: !widget.isRecovery,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.heightBox,
                  Text(
                    widget.isRecovery
                        ? 'Reset your password'
                        : 'Protect your journey',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.color2D2F2F,
                    ),
                  ),
                  8.heightBox,
                  Text(
                    'Create a strong password to ensure your travel account remains secure.',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.color5A5C5C,
                      height: 1.5,
                    ),
                  ),
                  32.heightBox,

                  // --- OLD PASSWORD (Only if not recovery) ---
                  if (!widget.isRecovery) ...[
                    CustomTextField(
                      controller: _oldPasswordController,
                      label: 'Current Password',
                      hint: 'Enter current password',
                      obscureText: _obscureOld,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureOld ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                          size: 20,
                        ),
                        onPressed: () =>
                            setState(() => _obscureOld = !_obscureOld),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your current password';
                        }
                        return null;
                      },
                    ),
                    24.heightBox,
                  ],

                  // --- NEW PASSWORD ---
                  CustomTextField(
                    controller: _newPasswordController,
                    label: widget.isRecovery ? 'New Password' : 'New Password',
                    hint: 'Enter new password',
                    obscureText: _obscureNew,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNew ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _obscureNew = !_obscureNew),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a new password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  24.heightBox,

                  // --- CONFIRM PASSWORD ---
                  CustomTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirm New Password',
                    hint: 'Re-enter new password',
                    obscureText: _obscureConfirm,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                    validator: (value) {
                      if (value != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  48.heightBox,

                  // --- SUBMIT ---
                  CustomGradientButton(
                    text: widget.isRecovery
                        ? 'Set Password'
                        : 'Update Password',
                    isLoading: state.isLoading == true,
                    onTap: _handleUpdate,
                    icon: Icons.check_circle_outline_rounded,
                  ),
                  30.heightBox,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
