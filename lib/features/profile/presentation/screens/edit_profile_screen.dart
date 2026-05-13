import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/utils/app_image_picker.dart';
import 'package:kisan_app/core/utils/app_overlays.dart';
import 'package:kisan_app/core/utils/extensions/context_extensions.dart';
import 'package:kisan_app/core/widgets/common/custom_app_bar.dart';
import 'package:kisan_app/core/widgets/common/custom_avatar.dart';
import 'package:kisan_app/core/widgets/common/custom_dropdown.dart';
import 'package:kisan_app/core/widgets/common/custom_text_field.dart';
import 'package:kisan_app/core/widgets/common/gradient_button.dart';
import 'package:kisan_app/core/widgets/common/location_prediction_field.dart';
import 'package:kisan_app/features/auth/data/models/user_model.dart';
import 'package:kisan_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _hometownController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  String? _selectedPronoun;
  double? _latitude;
  double? _longitude;

  // Use ValueNotifier for localized rebuilds
  final ValueNotifier<XFile?> _pickedImageNotifier = ValueNotifier<XFile?>(
    null,
  );

  final List<String> _pronounsList = [
    'She/Her',
    'He/Him',
    'They/Them',
    'Prefer not to say',
  ];

  @override
  void initState() {
    super.initState();

    // Populate fields from AuthBloc
    final user = context.read<AuthBloc>().state.user;
    if (user != null) {
      _nameController.text = user.name;
      _hometownController.text = user.address ?? '';
      _bioController.text = user.bio ?? '';
      _ageController.text = user.age ?? '';
      _selectedPronoun = user.pronouns;
      _latitude = user.latitude;
      _longitude = user.longitude;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _hometownController.dispose();
    _bioController.dispose();
    _pickedImageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);

    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              20.heightBox,

              // --- PROFILE PHOTO ---
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ValueListenableBuilder<XFile?>(
                    valueListenable: _pickedImageNotifier,
                    builder: (context, pickedImage, _) {
                      if (pickedImage != null) {
                        return CircleAvatar(
                          radius: 80,
                          backgroundImage: FileImage(File(pickedImage.path)),
                        );
                      }
                      return CustomAvatar(
                        imageUrl: user?.profileImage,
                        radius: 80,
                      );
                    },
                  ),
                  Positioned(
                    bottom: 2,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        final imageFile =
                            await AppImagePicker.cameraImagePicker(
                              context,
                              crop: true,
                              cropStyle: CropStyle.circle,
                            );

                        if (imageFile != null) {
                          _pickedImageNotifier.value = XFile(imageFile.path);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              12.heightBox,
              Text(
                'TAP TO UPDATE PHOTO',
                style: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.black87,
                  fontSize: 10,
                ),
              ),
              24.heightBox,

              // --- FORM FIELDS ---
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey[100]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CustomTextField(
                  label: 'NAME',
                  hint: "Editorial Wanderer",
                  fillColorNotShow: false,
                  controller: _nameController,
                  // showShadow: true,
                ),
              ),
              16.heightBox,
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey[100]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CustomTextField(
                  label: 'AGE',
                  hint: "25 year",
                  controller: _ageController,
                  // showShadow: true,
                ),
              ),
              16.heightBox,
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey[100]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CustomDropdown<String>(
                  label: 'PRONOUNS',
                  value: _selectedPronoun,
                  hint: 'Select your pronouns',
                  items: _pronounsList,
                  itemLabel: (s) => s,
                  onChanged: (v) {
                    setState(() {
                      _selectedPronoun = v;
                    });
                  },
                ),
              ),
              16.heightBox,
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey[100]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: LocationPredictionField(
                  controller: _hometownController,
                  label: 'LOCATION',
                  hint: "Where do you live?",
                  prefixIcon: Icons.location_on_outlined,
                  onSelected: (prediction) {
                    _latitude = prediction.lat;
                    _longitude = prediction.lng;
                  },
                ),
              ),
              16.heightBox,
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey[100]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'BIO',
                      hint:
                          "Passionate solo traveler, photographer, and tea enthusiast. Exploring the hidden corners of the world through an editorial lens. Staying safe, inspired, and always curious.",
                      controller: _bioController,
                      maxLines: 6,
                      // showShadow: true,
                    ),
                    12.heightBox,
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _bioController,
                        builder: (context, value, _) {
                          return Text(
                            '${value.text.length}/250 characters',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Colors.grey[400],
                              fontSize: 10,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              32.heightBox,

              // --- ACTIONS ---
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.successMessage != null &&
                      state.successMessage == 'Profile updated successfully!') {
                    _showSuccessDialog(context);
                  }
                  if (state.errorMessage != null) {
                    AppOverlays.showSnackBar(
                      context: context,
                      message: state.errorMessage!,
                      type: SnackBarType.error,
                    );
                  }
                },
                builder: (context, state) {
                  return GradientButton(
                    text: 'Save Changes',
                    isLoading: state.isLoading,
                    onPressed: () {
                      final currentUser = state.user;
                      if (currentUser == null) return;

                      // Create updated user entity
                      final updatedUser = (currentUser as UserModel).copyWith(
                        name: _nameController.text,
                        address: _hometownController.text,
                        bio: _bioController.text,
                        pronouns: _selectedPronoun,
                        age: _ageController.text,
                        latitude: _latitude,
                        longitude: _longitude,
                      );

                      context.read<AuthBloc>().add(
                        AuthUpdateProfileRequested(
                          user: updatedUser,
                          imageFile: _pickedImageNotifier.value,
                        ),
                      );
                    },
                  );
                },
              ),

              40.heightBox,
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
                color: AppColors.success.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: AppColors.success,
                size: 60,
              ),
            ),
            24.heightBox,
            const Text(
              'Profile Updated!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            12.heightBox,
            Text(
              'Your changes have been saved successfully. Your travel story is now up to date.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                height: 1.5,
              ),
            ),
            32.heightBox,
            GradientButton(
              text: 'Perfect',
              height: 50,
              onPressed: () {
                Navigator.pop(context); // Close dialog
                context.pop(); // Go back to profile
              },
            ),
            8.heightBox,
          ],
        ),
      ),
    );
  }
}
