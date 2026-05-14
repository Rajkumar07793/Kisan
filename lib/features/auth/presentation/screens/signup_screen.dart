import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kisan_app/core/constants/app_assets.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/constants/enums/app_enums.dart';
import 'package:kisan_app/core/utils/app_overlays.dart';
import 'package:kisan_app/core/utils/app_router.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';
import 'package:kisan_app/core/utils/extensions/size_extensions.dart';

import '../../../../core/utils/app_validations.dart';
import '../../../../core/widgets/common/custom_app_bar.dart';
import '../../../../core/widgets/common/custom_phone_field.dart';
import '../../../../core/widgets/common/custom_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/common_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(
    text: kDebugMode ? 'Kheti-Kisaani User' : '',
  );
  final _emailController = TextEditingController(
    text: kDebugMode ? 'rajkumar07793@gmail.com' : '',
  );
  final _passwordController = TextEditingController(
    text: kDebugMode ? '123456' : '',
  );
  final _phoneController = TextEditingController(
    text: kDebugMode ? '9977783414' : '',
  );

  ValueNotifier<bool> hideAndShowPassword = ValueNotifier<bool>(true);
  // ValueNotifier<List<int>> selected = ValueNotifier<List<int>>([]);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _phoneCode = '+91';
  String _countryCode = 'IN';

  void _onSignUp(List<String> dataList) {
    if (_formKey.currentState!.validate()) {
      // final selectedInspirations = selected.value
      //     .map((index) => dataList[index])
      //     .toList();

      context.read<AuthBloc>().add(
        AuthSignUpRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          name: _nameController.text.trim(),
          phone: _phoneController.text.trim(),
          phoneCode: _phoneCode,
          countryCode: _countryCode,
          // inspirations: selectedInspirations,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> dataList = [
      context.l10n.nature,
      context.l10n.culture,
      context.l10n.wellness,
    ];
    List<String> imagesList = [
      AppAssets.cloudIcon,
      AppAssets.cultureIcon,
      AppAssets.wellnessIcon,
    ];
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          // If already authenticated (e.g. auto-login enabled in Supabase), go to home
          context.go(AppRouter.home);
        } else if (state.errorMessage != null) {
          AppOverlays.showSnackBar(
            context: context,
            message: state.errorMessage!,
            type: SnackBarType.error,
          );
        } else if (state.isLoading == false &&
            _emailController.text.isNotEmpty &&
            ModalRoute.of(context)?.isCurrent == true) {
          // If signup was requested and loading finished without error,
          // and we are still on this screen, navigate to verification
          context.push(
            AppRouter.verifyEmailScreen,
            extra: _emailController.text.trim(),
          );
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          backgroundColor: Colors.transparent,
          title: '',
        ),
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 70),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.l10n.createAccount,
                  style: context.textTheme.headlineMedium?.copyWith(
                    color: AppColors.color2D2F2F,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                10.height,
                Text(
                  context.l10n.startYourCurated,
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                50.height,
                CustomTextField(
                  label: context.l10n.nameLabel,
                  hint: context.l10n.nameHint,
                  controller: _nameController,
                  prefixIcon: Icon(
                    Icons.person_outline,
                    size: 20,
                    color: AppColors.color5A5C5C,
                  ),
                  validator: AppValidations.validateName,
                ),
                24.height,
                CustomTextField(
                  label: context.l10n.emailLabel,
                  hint: context.l10n.emailHint,
                  controller: _emailController,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 20,
                    color: AppColors.color5A5C5C,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidations.validateEmail,
                ),
                24.height,
                CustomPhoneField(
                  label: context.l10n.mobileNumber,
                  hint: context.l10n.mobileNumberHint,
                  controller: _phoneController,
                  onChanged: (phone) {
                    _phoneCode = phone.countryCode;
                    _countryCode = phone.countryISOCode;
                  },
                ),

                24.height,
                ValueListenableBuilder<bool>(
                  valueListenable: hideAndShowPassword,
                  builder: (context, hideShow, child) {
                    return CustomTextField(
                      label: context.l10n.passwordLabel,
                      hint: context.l10n.passwordHint,
                      controller: _passwordController,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        size: 20,
                        color: AppColors.color5A5C5C,
                      ),
                      suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          hideAndShowPassword.value = !hideShow;
                        },
                        icon: Icon(
                          hideShow ? Icons.visibility_off : Icons.visibility,
                          size: 22,
                          color: AppColors.color5A5C5C,
                        ),
                      ),
                      obscureText: hideShow,
                      validator: AppValidations.validatePassword,
                    );
                  },
                ),
                30.height,
                // Text(
                //   context.l10n.whatInspiresYou,
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.w600,
                //     color: AppColors.blackColor,
                //   ),
                //   textAlign: TextAlign.start,
                // ),
                // 25.height,
                // ValueListenableBuilder<List<int>>(
                //   valueListenable: selected,
                //   builder: (context, selectedIndices, child) {
                //     return SizedBox(
                //       height: 40,
                //       child: ListView.separated(
                //         separatorBuilder: (context, index) =>
                //             SizedBox(width: 10),
                //         shrinkWrap: true,
                //         itemCount: dataList.length,
                //         scrollDirection: Axis.horizontal,
                //         itemBuilder: (context, index) {
                //           final isSelected = selectedIndices.contains(index);
                //           return GestureDetector(
                //             onTap: () {
                //               if (selectedIndices.contains(index)) {
                //                 selected.value = List.from(selected.value)
                //                   ..remove(index);
                //               } else {
                //                 selected.value = List.from(selected.value)
                //                   ..add(index);
                //               }
                //             },
                //             child: Container(
                //               padding: EdgeInsets.symmetric(
                //                 horizontal: 10,
                //                 vertical: 10,
                //               ),
                //               decoration: BoxDecoration(
                //                 color: isSelected
                //                     ? AppColors.primary.withValues(alpha: 0.08)
                //                     : AppColors.fillColor.withValues(
                //                         alpha: 0.4,
                //                       ),
                //                 borderRadius: BorderRadius.all(
                //                   Radius.circular(20),
                //                 ),
                //                 border: Border.all(
                //                   color: Colors.black.withValues(alpha: 0.06),
                //                 ),
                //               ),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 mainAxisSize: MainAxisSize.min,
                //                 children: [
                //                   Image.asset(
                //                     imagesList[index],
                //                     height: 16,
                //                     width: 16,
                //                     fit: BoxFit.contain,
                //                     color: isSelected
                //                         ? AppColors.primary
                //                         : AppColors.color2D2F2F,
                //                   ),
                //                   SizedBox(width: 8),
                //                   Text(
                //                     dataList[index],
                //                     style: context.textTheme.bodyMedium
                //                         ?.copyWith(
                //                           color: isSelected
                //                               ? AppColors.primary
                //                               : context.colorScheme.onSurface
                //                                     .withValues(alpha: 0.5),
                //                         ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           );
                //         },
                //       ),
                //     );
                //   },
                // ),
                45.height,
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return CustomGradientButton(
                      text: context.l10n.signup,
                      icon: Icons.arrow_forward,
                      isLoading: state.isLoading == true,
                      onTap: () => _onSignUp(dataList),
                    );
                  },
                ),

                15.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.l10n.alreadyHaveAnAccount,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.pop(AppRouter.login),
                      child: Text(context.l10n.logIn),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
