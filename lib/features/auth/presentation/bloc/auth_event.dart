part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthStatusChanged extends AuthEvent {
  final AuthStatus status;
  const AuthStatusChanged(this.status);
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  const AuthLoginRequested({required this.email, required this.password});
}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String phone;
  final String phoneCode;
  final String countryCode;
  // final List<String> inspirations;
  const AuthSignUpRequested({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.phoneCode,
    required this.countryCode,
    // required this.inspirations,
  });
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthDeleteAccountRequested extends AuthEvent {
  const AuthDeleteAccountRequested();
}

class AuthOTPVerifyRequested extends AuthEvent {
  final String token;
  final String email;
  final bool isEmail;
  const AuthOTPVerifyRequested({
    required this.token,
    required this.email,
    this.isEmail = true,
  });
}

class AuthOTPResendRequested extends AuthEvent {
  final String email;
  final bool isEmail;
  const AuthOTPResendRequested({required this.email, this.isEmail = true});
}

class AuthResetPasswordRequested extends AuthEvent {
  final String email;
  const AuthResetPasswordRequested({required this.email});
}

class AuthUpdatePasswordRequested extends AuthEvent {
  final String newPassword;
  const AuthUpdatePasswordRequested({required this.newPassword});
}

class AuthUpdateProfileRequested extends AuthEvent {
  final UserEntity user;
  final XFile? imageFile;
  const AuthUpdateProfileRequested({required this.user, this.imageFile});
}
