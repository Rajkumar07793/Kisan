import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kisan_app/core/constants/app_assets.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/utils/extensions/size_extensions.dart';

import '../../../../core/utils/app_overlays.dart';
import '../../../../core/utils/app_validations.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/widgets/common/custom_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/common_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onResetPassword() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthResetPasswordRequested(email: _emailController.text.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          AppOverlays.showSnackBar(
            context: context,
            message: state.errorMessage!,
            type: SnackBarType.error,
          );
        } else if (state.isLoading == false &&
            _emailController.text.isNotEmpty) {
          AppOverlays.showSnackBar(
            context: context,
            message:
                'If an account exists, a reset link has been sent to your email.',
            type: SnackBarType.success,
          );
          context.pop(); // Go back to login
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: const SizedBox.shrink(),
          backgroundColor: Colors.transparent,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 40, right: 18, left: 18),
            child: Row(
              children: [
                Text(
                  context.l10n.appTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: AppColors.primary,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_back,
                        size: 22,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        context.l10n.backToLogin,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withValues(alpha: 0.02),
                AppColors.primary.withValues(alpha: 0.01),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 80),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  40.height,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 40,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          offset: const Offset(0, 4),
                          blurRadius: 12,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            height: 70,
                            width: 70,
                            fit: BoxFit.contain,
                            AppAssets.forgotIcon,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            context.l10n.forgotPassword,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          textAlign: TextAlign.center,
                          context.l10n.forgotPasswordSubtitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.color5A5C5C,
                          ),
                        ),
                        35.heightBox,
                        CustomTextField(
                          label: context.l10n.emailLabel,
                          hint: 'name@example.com',
                          controller: _emailController,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            size: 20,
                            color: AppColors.color5A5C5C,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: AppValidations.validateEmail,
                        ),
                        35.heightBox,
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return CustomGradientButton(
                              text: context.l10n.resetPassword,
                              isLoading: state.isLoading == true,
                              onTap: _onResetPassword,
                            );
                          },
                        ),
                        35.heightBox,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
