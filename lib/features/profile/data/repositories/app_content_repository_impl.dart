import 'package:dartz/dartz.dart';
import 'package:kisan_app/core/constants/app_database_constants.dart';
import 'package:kisan_app/core/error/failures.dart';
import 'package:kisan_app/core/utils/app_logs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/app_content_entity.dart';
import '../../domain/repositories/app_content_repository.dart';

class AppContentRepositoryImpl implements AppContentRepository {
  final SupabaseClient _supabase;

  AppContentRepositoryImpl(this._supabase);

  @override
  Future<Either<Failure, AppContentEntity>> getContent(
    String slug, {
    String languageCode = 'en',
  }) async {
    try {
      AppLogs.info(
        'Fetching app content for slug: $slug ($languageCode)',
        name: 'AppContentRepository',
      );

      final response = await _supabase
          .from(AppDatabaseConstants.contentManagementTable)
          .select()
          .eq(AppDatabaseConstants.columnContentKey, slug)
          .single();

      AppLogs.success(
        'App content received for slug: $slug',
        name: 'AppContentRepository',
      );
      AppLogs.debugPrint('Content response: $response');

      final Map<String, dynamic> contentJson =
          response[AppDatabaseConstants.columnContent] ?? {};

      // Pick content based on selected language, fallback to 'en'
      final String html =
          contentJson[languageCode] ??
          contentJson['en'] ??
          contentJson['description'] ??
          '';

      return Right(
        AppContentEntity(
          slug: response[AppDatabaseConstants.columnContentKey],
          title: contentJson['title'] ?? _formatSlugToTitle(slug),
          contentHtml: html,
        ),
      );
    } catch (e) {
      AppLogs.error(
        'Failed to fetch app content for slug: $slug',
        error: e,
        name: 'AppContentRepository',
      );
      return Left(ServerFailure(e.toString()));
    }
  }

  String _formatSlugToTitle(String slug) {
    if (slug == 'termsAndConditions') return 'Terms and Conditions';
    if (slug == 'privacyPolicy') return 'Privacy Policy';
    if (slug == 'communityGuidelines') return 'Community Guidelines';
    return slug;
  }
}
