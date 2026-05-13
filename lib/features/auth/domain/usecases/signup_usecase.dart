import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String phoneCode,
    required String countryCode,
    List<String> inspirations = const [],
  }) async {
    try {
      await repository.signUp(
        email: email,
        password: password,
        name: name,
        phone: phone,
        phoneCode: phoneCode,
        countryCode: countryCode,
        inspirations: inspirations,
      );
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
