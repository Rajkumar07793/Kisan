import 'package:dartz/dartz.dart';
import 'package:kisan_app/core/error/failures.dart';
import 'package:kisan_app/core/utils/app_logs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/faq_entity.dart';
import '../../domain/repositories/faq_repository.dart';
import '../models/faq_model.dart';

class FaqRepositoryImpl implements FaqRepository {
  final SupabaseClient _supabase;

  FaqRepositoryImpl(this._supabase);

  @override
  Future<Either<Failure, List<FaqEntity>>> getFaqs() async {
    try {
      AppLogs.info('Fetching FAQs from Supabase', name: 'FaqRepository');

      final response = await _supabase
          .from('faqs')
          .select()
          .order('display_order', ascending: true);

      AppLogs.success(
        'FAQs received: ${(response as List).length}',
        name: 'FaqRepository',
      );

      final faqs = (response as List)
          .map((json) => FaqModel.fromJson(json))
          .toList();

      return Right(faqs);
    } catch (e) {
      AppLogs.error('Failed to fetch FAQs', error: e, name: 'FaqRepository');
      return Left(ServerFailure(e.toString()));
    }
  }
}
