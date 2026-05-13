import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kisan_app/core/constants/app_assets.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/constants/enums/app_enums.dart';
import 'package:kisan_app/core/utils/extensions/size_extensions.dart';

import '../../../../core/constants/env_config.dart';
import '../../../../core/utils/app_overlays.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/widgets/common/custom_app_bar.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/common_button.dart';
import '../widgets/custom_otp_field.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;
  const VerifyEmailScreen({super.key, required this.email});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _pinController = TextEditingController();
  final ValueNotifier<int> _resendCountdown = ValueNotifier<int>(60);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _resendCountdown.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown.value > 0) {
        _resendCountdown.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void _onVerify() {
    if (_pinController.text.length == 6) {
      context.read<AuthBloc>().add(
        AuthOTPVerifyRequested(token: _pinController.text, email: widget.email),
      );
    } else {
      AppOverlays.showSnackBar(
        context: context,
        message: 'Please enter a 6-digit code',
        type: SnackBarType.error,
      );
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    _timer?.cancel();
    _resendCountdown.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        backgroundColor: Colors.transparent,
        title: '',
        showBackButton: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.02),
              AppColors.primary.withValues(alpha: 0.05),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              85.height,
              Center(
                child: Image.asset(
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                  AppAssets.verifyEmailIcon,
                ),
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  EnvConfig.appName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 35,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: context.l10n.weHaveSentDigitCodeTo,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.color5A5C5C,
                      fontSize: 15,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: " ${widget.email} ",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: context.l10n.toVerifyYourExplorerIdentity,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.color5A5C5C,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              50.height,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      offset: Offset(0, 4),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomOTPField(
                      controller: _pinController,
                      onCompleted: (pin) => _onVerify(),
                    ),
                    35.heightBox,
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state.status == AuthStatus.authenticated) {
                          _showSuccessDialog(context);
                        } else if (state.errorMessage != null) {
                          AppOverlays.showSnackBar(
                            context: context,
                            message: state.errorMessage!,
                            type: SnackBarType.error,
                          );
                        } else if (state.successMessage != null) {
                          AppOverlays.showSnackBar(
                            context: context,
                            message: state.successMessage!,
                            type: SnackBarType.success,
                          );
                          // Reset timer if it was a resend success
                          if (state.successMessage!.contains('resent')) {
                            _startTimer();
                          }
                        }
                      },
                      builder: (context, state) {
                        return CustomGradientButton(
                          text: context.l10n.verify,
                          isLoading: state.isLoading == true,
                          onTap: _onVerify,
                        );
                      },
                    ),
                    35.heightBox,
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        context.l10n.didNotReceiveCode,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.color5A5C5C,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: ValueListenableBuilder<int>(
                        valueListenable: _resendCountdown,
                        builder: (context, seconds, child) {
                          final isButtonDisabled = seconds > 0;
                          return GestureDetector(
                            onTap: isButtonDisabled
                                ? null
                                : () {
                                    context.read<AuthBloc>().add(
                                      AuthOTPResendRequested(
                                        email: widget.email,
                                      ),
                                    );
                                  },
                            child: Text(
                              textAlign: TextAlign.center,
                              isButtonDisabled
                                  ? 'Resend in 00:${seconds.toString().padLeft(2, '0')}'
                                  : context.l10n.resendCode,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: isButtonDisabled
                                    ? AppColors.color5A5C5C
                                    : AppColors.primary,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            20.heightBox,
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: 60,
              ),
            ),
            24.heightBox,
            const Text(
              'Verification Successful!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            12.heightBox,
            Text(
              'Your explorer identity has been verified successfully. Your journey with ${EnvConfig.appName} starts now.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                height: 1.5,
              ),
            ),
            32.heightBox,
            CustomGradientButton(
              text: 'Start Journey',
              onTap: () {
                context.go(AppRouter.home);
              },
            ),
            8.heightBox,
          ],
        ),
      ),
    );
  }
}
