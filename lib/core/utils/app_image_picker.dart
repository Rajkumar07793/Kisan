import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisan_app/core/constants/app_colors.dart';
import 'package:kisan_app/core/utils/app_logs.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AppImagePicker {
  static final ImagePicker _picker = ImagePicker();

  /// Main entry point to show the image picker sheet
  static Future<File?> cameraImagePicker(
    BuildContext context, {
    CropStyle? cropStyle,
    CropAspectRatio? aspectRatio,
    bool crop = true,
  }) async {
    return showCupertinoModalPopup<File>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              final image = await pickImage(
                context,
                false,
                crop: crop,
                cropStyle: cropStyle,
                aspectRatio: aspectRatio,
              );
              if (context.mounted) Navigator.pop(context, image);
            },
            child: const Text(
              'Take a picture',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: AppColors.primary,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final image = await pickImage(
                context,
                true,
                crop: crop,
                cropStyle: cropStyle,
                aspectRatio: aspectRatio,
              );
              if (context.mounted) Navigator.pop(context, image);
            },
            child: const Text(
              'Gallery',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Close',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  /// Core logic for picking and cropping
  static Future<File?> pickImage(
    BuildContext context,
    bool isGallery, {
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    bool crop = false,
    CropStyle? cropStyle,
    CropAspectRatio? aspectRatio,
  }) async {
    try {
      AppLogs.info(
        'About to pick image with 80% quality',
        name: 'AppImagePicker',
      );

      XFile? pickedFile;
      if (isGallery) {
        pickedFile = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
          maxHeight: 600,
        );
      } else {
        pickedFile = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 80,
          preferredCameraDevice: preferredCameraDevice,
          maxHeight: 600,
        );
      }

      if (pickedFile == null) return null;

      final int length = await pickedFile.length();
      AppLogs.info('Picked image size: $length bytes', name: 'AppImagePicker');

      File? image;

      if (crop) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: aspectRatio,
          compressQuality: length > 100000
              ? length > 200000
                    ? length > 300000
                          ? length > 400000
                                ? 5
                                : 10
                          : 20
                    : 30
              : 50,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Photo',
              toolbarColor: AppColors.primary,
              toolbarWidgetColor: Colors.white,
              cropStyle: cropStyle ?? CropStyle.circle,
              aspectRatioPresets: [CropAspectRatioPreset.square],
              lockAspectRatio: true,
            ),
            IOSUiSettings(
              title: 'Crop Photo',
              cropStyle: cropStyle ?? CropStyle.circle,
              aspectRatioPresets: [CropAspectRatioPreset.square],
              aspectRatioLockEnabled: true,
            ),
          ],
        );

        if (croppedFile != null) {
          image = File(croppedFile.path);
        }
      } else {
        image = File(pickedFile.path);
      }

      AppLogs.success(
        'Image processed: ${image?.path}',
        name: 'AppImagePicker',
      );
      return image;
    } catch (e) {
      AppLogs.error('Image picker error', error: e, name: 'AppImagePicker');
      return null;
    }
  }
}
