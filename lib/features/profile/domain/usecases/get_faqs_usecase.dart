import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/faq_entity.dart';
import '../repositories/faq_repository.dart';

class GetFaqsUseCase {
  final FaqRepository repository;

  GetFaqsUseCase(this.repository);

  Future<Either<Failure, List<FaqEntity>>> call() async {
    return await repository.getFaqs();
  }
}
