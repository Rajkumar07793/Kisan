import 'dart:async';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kisan_app/core/constants/app_database_constants.dart';
import 'package:kisan_app/core/constants/enums/app_enums.dart';
import 'package:kisan_app/core/error/exceptions.dart';
import 'package:kisan_app/core/utils/app_logs.dart';
import 'package:kisan_app/core/utils/app_overlays.dart';
import 'package:kisan_app/core/utils/app_router.dart';
import 'package:kisan_app/features/auth/domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _supabase;
  final _controller = StreamController<AuthStatus>();
  final _appLinks = AppLinks();
  bool _isEmailConfirmation = false;

  AuthRepositoryImpl(this._supabase) {
    _init();
  }

  void _init() {
    _supabase.auth.onAuthStateChange.listen(
      (data) {
        final session = data.session;
        final event = data.event;

        if (session != null) {
          AppLogs.success(
            'Auth status: Authenticated (${event.name})',
            name: 'AuthRepositoryImpl',
          );

          // Show success message if signed in via deep link / email confirmation
          if (event == AuthChangeEvent.signedIn) {
            // We use a small delay to ensure the UI is ready to show the overlay
            Future.delayed(const Duration(milliseconds: 500), () {
              final context = AppRouter.rootNavigatorKey.currentContext;
              if (context != null) {
                final message = _isEmailConfirmation
                    ? 'Email verified successfully! You now have full access to all features, including chat and calls.'
                    : 'Welcome back to HerStay!';

                AppOverlays.showSnackBar(
                  context: context,
                  message: message,
                  type: SnackBarType.success,
                );

                _isEmailConfirmation = false; // Reset flag
              }
            });
          }

          // Handle Password Reset Link
          if (event == AuthChangeEvent.passwordRecovery) {
            Future.delayed(const Duration(milliseconds: 500), () {
              final context = AppRouter.rootNavigatorKey.currentContext;
              if (context != null) {
                // Navigate to the change password screen
                context.push(AppRouter.changePassword, extra: true);
                AppOverlays.showSnackBar(
                  context: context,
                  message: 'Please set your new password.',
                  type: SnackBarType.info,
                );
              }
            });
          }

          _controller.add(AuthStatus.authenticated);
        } else {
          AppLogs.info(
            'Auth status: Unauthenticated',
            name: 'AuthRepositoryImpl',
          );
          _controller.add(AuthStatus.unauthenticated);
        }
      },
      onError: (error) {
        AppLogs.error(
          'Auth state error',
          error: error,
          name: 'AuthRepositoryImpl',
        );

        // Handle Deep Link errors (like expired OTP)
        if (error is AuthException) {
          Future.delayed(const Duration(milliseconds: 500), () {
            final context = AppRouter.rootNavigatorKey.currentContext;
            if (context != null) {
              AppOverlays.showSnackBar(
                context: context,
                message: _handleAuthException(error),
                type: SnackBarType.error,
              );
            }
          });
        }
      },
    );

    // Listen for Deep Links to detect Email Confirmations
    _appLinks.uriLinkStream.listen((uri) {
      final fragment = uri.fragment;
      if (fragment.contains('type=signup')) {
        AppLogs.info(
          'Detected Email Confirmation Deep Link',
          name: 'AuthRepositoryImpl',
        );
        _isEmailConfirmation = true;
      }
    });
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    try {
      final response = await _supabase
          .from(AppDatabaseConstants.usersTable)
          .select()
          .eq(AppDatabaseConstants.columnId, user.id)
          .single();

      return UserModel.fromJson(response);
    } catch (e) {
      AppLogs.error(
        'Get current user error',
        error: e,
        name: 'AuthRepositoryImpl',
      );
      return null;
    }
  }

  @override
  Stream<AuthStatus> get status => _controller.stream;

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      AppLogs.log('Attempting sign in for: $email', name: 'AuthRepositoryImpl');
      await _supabase.auth.signInWithPassword(email: email, password: password);
      AppLogs.success('Sign in successful', name: 'AuthRepositoryImpl');
    } on AuthException catch (e) {
      throw AuthFailure(_handleAuthException(e));
    } catch (e) {
      AppLogs.error('Sign in error', error: e, name: 'AuthRepositoryImpl');
      throw AuthFailure(
        'An unexpected error occurred during sign in. Please try again.',
      );
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String phoneCode,
    required String countryCode,
    List<String> inspirations = const [],
  }) async {
    final trimmedEmail = email.trim();
    final trimmedPhone = phone.trim();
    try {
      // 1. Check if phone already exists
      await _checkUniqueness(
        column: AppDatabaseConstants.columnPhone,
        value: trimmedPhone,
        errorMessage: 'This phone number is already registered.',
      );

      // 2. Check if email already exists
      await _checkUniqueness(
        column: AppDatabaseConstants.columnEmail,
        value: trimmedEmail,
        errorMessage: 'This email is already registered. Please login instead.',
      );

      AppLogs.log(
        'Attempting sign up for: $trimmedEmail',
        name: 'AuthRepositoryImpl',
      );
      await _supabase.auth.signUp(
        email: trimmedEmail,
        password: password,
        data: {
          AppDatabaseConstants.columnName: name,
          AppDatabaseConstants.columnPhone: trimmedPhone,
          AppDatabaseConstants.columnPhoneCode: phoneCode,
          AppDatabaseConstants.columnCountryCode: countryCode,
          AppDatabaseConstants.columnPassword: password,
          AppDatabaseConstants.columnInspirations: inspirations,
        },
      );
      AppLogs.success('Sign up initiated', name: 'AuthRepositoryImpl');

      // Note: We no longer perform a manual upsert here.
      // We are now using a Supabase Database Trigger (defined in supabase/schema.sql)
      // to automatically create the user profile in the 'public.users' table
      // using the 'data' passed above. This avoids RLS issues during signup.
    } on AuthException catch (e) {
      throw AuthFailure(_handleAuthException(e));
    } catch (e) {
      AppLogs.error('Sign up error', error: e, name: 'AuthRepositoryImpl');
      throw AuthFailure(
        'An unexpected error occurred during sign up. Please try again.',
      );
    }
  }

  String _handleAuthException(AuthException e) {
    AppLogs.error(
      'Supabase Auth Exception',
      error: e.message,
      name: 'AuthRepositoryImpl',
    );

    // Supabase error messages are usually descriptive, but we can map them to friendlier ones
    final message = e.message.toLowerCase();
    if (message.contains('invalid login credentials')) {
      return 'Invalid email or password. Please check your credentials and try again.';
    } else if (message.contains('email not confirmed')) {
      return 'Your email has not been confirmed yet. Please check your inbox.';
    } else if (message.contains('user already registered')) {
      return 'This email is already registered. Please try logging in instead.';
    } else if (message.contains('network error')) {
      return 'A network error occurred. Please check your internet connection.';
    } else if (message.contains('too many requests')) {
      return 'Too many attempts. Please try again later.';
    } else if (message.contains('invalid format')) {
      return 'Invalid code format. Please check the code and try again.';
    } else if (message.contains('otp expired')) {
      return 'The code has expired. Please request a new one.';
    } else if (message.contains('token is invalid')) {
      return 'The code is invalid. Please check and try again.';
    }
    return e.message;
  }

  @override
  Future<void> verifyOTP({
    required String token,
    required String email,
    bool isEmail = true,
  }) async {
    try {
      AppLogs.log('Verifying OTP for: $email', name: 'AuthRepositoryImpl');
      await _supabase.auth.verifyOTP(
        token: token,
        type: isEmail ? OtpType.signup : OtpType.sms,
        email: isEmail ? email : null,
        phone: isEmail ? null : email,
      );
      AppLogs.success(
        'OTP Verification successful',
        name: 'AuthRepositoryImpl',
      );
    } on AuthException catch (e) {
      throw AuthFailure(_handleAuthException(e));
    } catch (e) {
      AppLogs.error('Verification error', error: e, name: 'AuthRepositoryImpl');
      throw AuthFailure('An unexpected error occurred during verification.');
    }
  }

  @override
  Future<void> resendOTP({required String email, bool isEmail = true}) async {
    final trimmedEmail = email.trim();
    try {
      AppLogs.log(
        'Resending OTP for: $trimmedEmail',
        name: 'AuthRepositoryImpl',
      );
      await _supabase.auth.resend(
        email: isEmail ? trimmedEmail : null,
        phone: isEmail ? null : trimmedEmail,
        type: isEmail ? OtpType.signup : OtpType.sms,
      );
      AppLogs.success('OTP Resent successful', name: 'AuthRepositoryImpl');
    } on AuthException catch (e) {
      throw AuthFailure(_handleAuthException(e));
    } catch (e) {
      AppLogs.error('Resend error', error: e, name: 'AuthRepositoryImpl');
      throw AuthFailure('An unexpected error occurred while resending code.');
    }
  }

  @override
  Future<void> signOut() async {
    AppLogs.log('Signing out', name: 'AuthRepositoryImpl');
    await _supabase.auth.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      AppLogs.log('Deleting user record: $userId', name: 'AuthRepositoryImpl');

      // Delete from public users table and return the deleted row to verify
      final response = await _supabase
          .from(AppDatabaseConstants.usersTable)
          .delete()
          .eq(AppDatabaseConstants.columnId, userId)
          .select();

      if (response.isEmpty) {
        AppLogs.error(
          'No record deleted. Check RLS policies.',
          name: 'AuthRepositoryImpl',
        );
        throw AuthFailure(
          'Deletion failed. You might not have permission to delete this record.',
        );
      }

      AppLogs.success(
        'User record deleted successfully',
        name: 'AuthRepositoryImpl',
      );

      // Sign out
      await signOut();
    } catch (e) {
      AppLogs.error(
        'Delete account error',
        error: e,
        name: 'AuthRepositoryImpl',
      );
      throw AuthFailure('Failed to delete account. Please try again.');
    }
  }

  @override
  Future<void> updateProfile({
    required UserEntity user,
    XFile? imageFile,
  }) async {
    try {
      AppLogs.info(
        'Updating profile for user: ${user.id}',
        name: 'AuthRepositoryImpl',
      );

      String profileImageUrl = user.profileImage;

      // 1. Upload image if provided
      if (imageFile != null) {
        final file = File(imageFile.path);
        final fileExtension = imageFile.path.split('.').last;
        final fileName =
            '${user.id}_${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
        final filePath = 'profiles/$fileName';

        AppLogs.info(
          'Uploading new profile image: $filePath',
          name: 'AuthRepositoryImpl',
        );

        await _supabase.storage
            .from(AppDatabaseConstants.avatarsBucket)
            .upload(
              filePath,
              file,
              fileOptions: const FileOptions(
                cacheControl: '3600',
                upsert: true,
              ),
            );

        // Get public URL
        profileImageUrl = _supabase.storage
            .from(AppDatabaseConstants.avatarsBucket)
            .getPublicUrl(filePath);
        AppLogs.success(
          'New profile image uploaded: $profileImageUrl',
          name: 'AuthRepositoryImpl',
        );
      }

      // 2. Update user table
      final updateData = {
        AppDatabaseConstants.columnName: user.name,
        AppDatabaseConstants.columnProfileImage: profileImageUrl,
        AppDatabaseConstants.columnBio: user.bio,
        AppDatabaseConstants.columnPronouns: user.pronouns,
        AppDatabaseConstants.columnAge: user.age,
        AppDatabaseConstants.columnAddress: user.address,
        AppDatabaseConstants.columnLatitude: user.latitude,
        AppDatabaseConstants.columnLongitude: user.longitude,
        AppDatabaseConstants.columnUpdatedAt: DateTime.now().toIso8601String(),
      };

      await _supabase
          .from(AppDatabaseConstants.usersTable)
          .update(updateData)
          .eq(AppDatabaseConstants.columnId, user.id);

      AppLogs.success(
        'Profile updated successfully in database',
        name: 'AuthRepositoryImpl',
      );
    } catch (e) {
      AppLogs.error(
        'Update profile error',
        error: e,
        name: 'AuthRepositoryImpl',
      );
      throw AuthFailure('Failed to update profile. Please try again.');
    }
  }

  @override
  String? get currentUserId => _supabase.auth.currentUser?.id;

  @override
  Future<void> resetPassword({required String email}) async {
    final trimmedEmail = email.trim();
    try {
      AppLogs.log(
        'Requesting password reset for: $trimmedEmail',
        name: 'AuthRepositoryImpl',
      );
      await _supabase.auth.resetPasswordForEmail(trimmedEmail);
      AppLogs.success('Password reset email sent', name: 'AuthRepositoryImpl');
    } on AuthException catch (e) {
      throw AuthFailure(_handleAuthException(e));
    } catch (e) {
      AppLogs.error(
        'Reset password error',
        error: e,
        name: 'AuthRepositoryImpl',
      );
      throw AuthFailure(
        'An unexpected error occurred while requesting password reset.',
      );
    }
  }

  @override
  Future<void> updatePassword({required String newPassword}) async {
    try {
      AppLogs.log('Updating password', name: 'AuthRepositoryImpl');
      await _supabase.auth.updateUser(UserAttributes(password: newPassword));
      AppLogs.success(
        'Password updated successfully',
        name: 'AuthRepositoryImpl',
      );
    } on AuthException catch (e) {
      throw AuthFailure(_handleAuthException(e));
    } catch (e) {
      AppLogs.error(
        'Update password error',
        error: e,
        name: 'AuthRepositoryImpl',
      );
      throw AuthFailure(
        'An unexpected error occurred while updating your password.',
      );
    }
  }

  void dispose() {
    _controller.close();
  }

  Future<void> _checkUniqueness({
    required String column,
    required String value,
    required String errorMessage,
  }) async {
    final existing = await _supabase
        .from(AppDatabaseConstants.usersTable)
        .select(AppDatabaseConstants.columnId)
        .eq(column, value)
        .maybeSingle();

    if (existing != null) {
      throw AuthException(errorMessage);
    }
  }
}
