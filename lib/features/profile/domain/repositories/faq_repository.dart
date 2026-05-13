import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/faq_entity.dart';

abstract class FaqRepository {
  Future<Either<Failure, List<FaqEntity>>> getFaqs();
}
