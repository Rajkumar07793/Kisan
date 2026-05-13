import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(Supabase.instance.client);
});

class AuthRepository {
  final SupabaseClient _supabase;

  AuthRepository(this._supabase);

  /// Sign in with phone number (sends OTP)
  Future<void> signInWithPhone(String phone) async {
    try {
      await _supabase.auth.signInWithOtp(
        phone: phone,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Verify OTP
  Future<AuthResponse> verifyOtp({
    required String phone,
    required String token,
  }) async {
    try {
      final response = await _supabase.auth.verifyOTP(
        phone: phone,
        token: token,
        type: OtpType.sms,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  /// Get current user
  User? get currentUser => _supabase.auth.currentUser;

  /// Stream of auth changes
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;
}
