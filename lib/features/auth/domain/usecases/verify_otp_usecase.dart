import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class VerifyOTPUseCase {
  final AuthRepository repository;

  VerifyOTPUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String token,
    required String email,
    bool isEmail = true,
  }) async {
    try {
      await repository.verifyOTP(
        token: token,
        email: email,
        isEmail: isEmail,
      );
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
