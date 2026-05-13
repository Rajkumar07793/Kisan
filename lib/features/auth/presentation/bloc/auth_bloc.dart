import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kisan_app/core/constants/enums/app_enums.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/resend_otp_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../../domain/usecases/update_password_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final LoginUseCase _loginUseCase;
  final SignUpUseCase _signUpUseCase;
  final VerifyOTPUseCase _verifyOTPUseCase;
  final ResendOTPUseCase _resendOTPUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final UpdatePasswordUseCase _updatePasswordUseCase;

  late StreamSubscription<AuthStatus> _authStatusSubscription;

  AuthBloc({
    required AuthRepository authRepository,
    required LoginUseCase loginUseCase,
    required SignUpUseCase signUpUseCase,
    required VerifyOTPUseCase verifyOTPUseCase,
    required ResendOTPUseCase resendOTPUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required UpdatePasswordUseCase updatePasswordUseCase,
  }) : _authRepository = authRepository,
       _loginUseCase = loginUseCase,
       _signUpUseCase = signUpUseCase,
       _verifyOTPUseCase = verifyOTPUseCase,
       _resendOTPUseCase = resendOTPUseCase,
       _resetPasswordUseCase = resetPasswordUseCase,
       _updatePasswordUseCase = updatePasswordUseCase,
       super(const AuthState.unknown()) {
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthSignUpRequested>(_onAuthSignUpRequested);
    on<AuthOTPVerifyRequested>(_onAuthOTPVerifyRequested);
    on<AuthOTPResendRequested>(_onAuthOTPResendRequested);
    on<AuthDeleteAccountRequested>(_onAuthDeleteAccountRequested);
    on<AuthResetPasswordRequested>(_onAuthResetPasswordRequested);
    on<AuthUpdatePasswordRequested>(_onAuthUpdatePasswordRequested);
    on<AuthUpdateProfileRequested>(_onAuthUpdateProfileRequested);

    _authStatusSubscription = _authRepository.status.listen(
      (status) => add(AuthStatusChanged(status)),
    );
  }

  Future<void> _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(
          state.copyWith(status: AuthStatus.unauthenticated, isLoading: false),
        );
      case AuthStatus.authenticated:
        final user = await _authRepository.getCurrentUser();
        return emit(
          user != null
              ? state.copyWith(
                  status: AuthStatus.authenticated,
                  user: user,
                  isLoading: false,
                )
              : state.copyWith(
                  status: AuthStatus.unauthenticated,
                  isLoading: false,
                ),
        );
      case AuthStatus.unknown:
        return emit(
          state.copyWith(status: AuthStatus.unknown, isLoading: false),
        );
    }
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    final result = await _loginUseCase(
      email: event.email,
      password: event.password,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: failure.message,
          isLoading: false,
        ),
      ),
      (_) => emit(state.copyWith(isLoading: false)),
    );
  }

  Future<void> _onAuthSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    final result = await _signUpUseCase(
      email: event.email,
      password: event.password,
      name: event.name,
      phone: event.phone,
      phoneCode: event.phoneCode,
      countryCode: event.countryCode,
      inspirations: event.inspirations,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: failure.message,
          isLoading: false,
        ),
      ),
      (_) => emit(state.copyWith(isLoading: false)),
    );
  }

  Future<void> _onAuthOTPVerifyRequested(
    AuthOTPVerifyRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    final result = await _verifyOTPUseCase(
      token: event.token,
      email: event.email,
      isEmail: event.isEmail,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: failure.message,
          isLoading: false,
        ),
      ),
      (_) => emit(state.copyWith(isLoading: false)),
    );
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    _authRepository.signOut();
  }

  Future<void> _onAuthDeleteAccountRequested(
    AuthDeleteAccountRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    try {
      await _authRepository.deleteAccount();
      emit(
        state.copyWith(
          isLoading: false,
          successMessage: 'Account deleted successfully',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> _onAuthOTPResendRequested(
    AuthOTPResendRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    final result = await _resendOTPUseCase(
      email: event.email,
      isEmail: event.isEmail,
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(errorMessage: failure.message, isLoading: false)),
      (_) => emit(
        state.copyWith(
          isLoading: false,
          successMessage: 'Verification code resent successfully',
        ),
      ),
    );
  }

  Future<void> _onAuthResetPasswordRequested(
    AuthResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    final result = await _resetPasswordUseCase(email: event.email);
    result.fold(
      (failure) =>
          emit(state.copyWith(errorMessage: failure.message, isLoading: false)),
      (_) => emit(
        state.copyWith(
          isLoading: false,
          successMessage:
              'If an account exists, a reset link has been sent to your email.',
        ),
      ),
    );
  }

  Future<void> _onAuthUpdatePasswordRequested(
    AuthUpdatePasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    final result = await _updatePasswordUseCase(newPassword: event.newPassword);
    result.fold(
      (failure) =>
          emit(state.copyWith(errorMessage: failure.message, isLoading: false)),
      (_) => emit(
        state.copyWith(
          isLoading: false,
          successMessage: 'Password updated successfully!',
        ),
      ),
    );
  }

  Future<void> _onAuthUpdateProfileRequested(
    AuthUpdateProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    try {
      await _authRepository.updateProfile(
        user: event.user,
        imageFile: event.imageFile,
      );

      // Refresh user data after update
      final updatedUser = await _authRepository.getCurrentUser();

      // First emit: Show success
      emit(
        state.copyWith(
          isLoading: false,
          user: updatedUser,
          successMessage: 'Profile updated successfully!',
        ),
      );

      // Second emit: Clear message immediately so it doesn't pop up again
      emit(state.copyWith(clearSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
      // Clear error immediately so it doesn't pop up again
      emit(state.copyWith(clearError: true));
    }
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    return super.close();
  }
}
