import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/constants/enums/app_enums.dart';
import 'package:kisan_app/core/constants/env_config.dart';
import 'package:kisan_app/core/utils/app_overlays.dart';
import 'package:kisan_app/core/utils/app_router.dart';

import '../../../../core/utils/app_validations.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/widgets/common/custom_app_bar.dart';
import '../../../../core/widgets/common/custom_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/common_button.dart';
import 'package:kisan_app/core/utils/extensions/size_extensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(
    text: kDebugMode ? 'rajkumar07793@gmail.com' : '',
  );
  final _passwordController = TextEditingController(
    text: kDebugMode ? '123456' : '',
  );

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthLoginRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.go(AppRouter.roleSelect);
        } else if (state.errorMessage != null) {
          if (state.errorMessage!.contains('confirmed')) {
            context.pushNamed(
              AppRouter.verifyEmailScreen,
              queryParameters: {'email': _emailController.text.trim()},
            );
          } else {
            AppOverlays.showSnackBar(
              context: context,
              message: state.errorMessage!,
              type: SnackBarType.error,
            );
          }
        }
      },
      child: Scaffold(
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
                AppColors.primary.withValues(alpha: 0.01),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    EnvConfig.appName,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
                  ),
                  10.height,
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: AppColors.color2D2F2F,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      text: "किफायती, सुरक्षित और ",
                      children: [
                        TextSpan(
                          text: "बेहतर खेती ",
                          style: TextStyle(
                            color: AppColors.primary.withValues(alpha: 0.6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(text: "की शुरुआत यहाँ से।"),
                      ],
                    ),
                  ),
                  10.height,
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          offset: Offset(0, 4),
                          blurRadius: 12,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.welcomeBack,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: AppColors.blackColor,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "अपनी कृषि यात्रा जारी रखने के लिए विवरण दर्ज करें।",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.color5A5C5C,
                          ),
                        ),
                        10.height,
                        CustomTextField(
                          label: context.l10n.emailLabel,
                          hint: 'user@kheti-kisaani.com',
                          controller: _emailController,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            size: 20,
                            color: AppColors.color5A5C5C,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: AppValidations.validateEmail,
                        ),
                        10.height,
                        CustomTextField(
                          label: context.l10n.passwordLabel,
                          hint: '********',
                          controller: _passwordController,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            size: 20,
                            color: AppColors.color5A5C5C,
                          ),
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 20,
                              color: AppColors.color5A5C5C,
                            ),
                          ),
                          validator: AppValidations.validatePassword,
                        ),
                        2.height,
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              context.push(AppRouter.forgotPasswordScreen);
                            },
                            child: Text(context.l10n.forgotPassword),
                          ),
                        ),
                        10.height,
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return CustomGradientButton(
                              text: context.l10n.login,
                              icon: Icons.arrow_forward,
                              isLoading: state.isLoading == true,
                              onTap: _onLogin,
                            );
                          },
                        ),
                        15.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 2,
                              width: 80,
                              color: Colors.black.withValues(alpha: 0.10),
                            ),
                            SizedBox(width: 10),
                            Text(
                              context.l10n.or,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: AppColors.color2D2F2F,
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 2,
                              width: 80,
                              color: Colors.black.withValues(alpha: 0.10),
                            ),
                          ],
                        ),
                        15.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              context.l10n.noAccount,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.onSurface
                                    .withOpacity(0.5),
                              ),
                            ),
                            TextButton(
                              onPressed: () => context.push(AppRouter.signup),
                              child: Text(context.l10n.signup),
                            ),
                          ],
                        ),
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
