import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class ResendOTPUseCase {
  final AuthRepository repository;

  ResendOTPUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String email,
    bool isEmail = true,
  }) async {
    try {
      await repository.resendOTP(email: email, isEmail: isEmail);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
