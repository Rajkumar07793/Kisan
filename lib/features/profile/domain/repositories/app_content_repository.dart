import 'package:dartz/dartz.dart';
import 'package:kisan_app/core/error/failures.dart';

import '../entities/app_content_entity.dart';

abstract class AppContentRepository {
  Future<Either<Failure, AppContentEntity>> getContent(
    String slug, {
    String languageCode = 'en',
  });
}
