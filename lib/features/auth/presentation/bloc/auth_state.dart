part of 'auth_bloc.dart';

class AuthState {
  final AuthStatus status;
  final UserEntity? user;
  final String? errorMessage;
  final String? successMessage;
  final bool isLoading;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.errorMessage,
    this.successMessage,
    this.isLoading = false,
  });

  const AuthState.unknown()
    : this(status: AuthStatus.unknown, isLoading: false);

  const AuthState.authenticated(UserEntity user)
    : this(status: AuthStatus.authenticated, user: user, isLoading: false);

  const AuthState.unauthenticated({String? errorMessage})
    : this(
        status: AuthStatus.unauthenticated,
        errorMessage: errorMessage,
        isLoading: false,
      );

  const AuthState.loading() : this(isLoading: true);

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? errorMessage,
    String? successMessage,
    bool? isLoading,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage:
          clearSuccess ? null : (successMessage ?? this.successMessage),
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
