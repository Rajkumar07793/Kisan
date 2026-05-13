import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:kisan_app/core/constants/enums/app_enums.dart';

import '../entities/user_entity.dart';

abstract class AuthRepository {
  /// Stream of authentication status
  Stream<AuthStatus> get status;

  /// Gets the current authenticated user
  Future<UserEntity?> getCurrentUser();

  Future<void> updateProfile({required UserEntity user, XFile? imageFile});

  /// Signs in with Email and Password
  Future<void> signIn({required String email, required String password});

  /// Signs up with Email and Password
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String phoneCode,
    required String countryCode,
    List<String> inspirations = const [],
  });

  Future<void> verifyOTP({
    required String token,
    required String email,
    bool isEmail = true,
  });

  /// Resends OTP code for email or phone
  Future<void> resendOTP({required String email, bool isEmail = true});

  /// Signs out the current user
  Future<void> signOut();

  /// Deletes the current user account
  Future<void> deleteAccount();

  /// Gets the current authenticated user ID
  String? get currentUserId;

  /// Resets password for the given email
  Future<void> resetPassword({required String email});

  /// Updates the password for the current user
  Future<void> updatePassword({required String newPassword});
}
