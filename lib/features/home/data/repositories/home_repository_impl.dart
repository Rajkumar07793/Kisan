import 'package:kisan_app/core/constants/app_database_constants.dart';
import 'package:kisan_app/core/utils/app_logs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/tractor_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../models/tractor_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final SupabaseClient _supabase;

  HomeRepositoryImpl(this._supabase);

  @override
  Future<List<TractorEntity>> getTractors({String? serviceType}) async {
    try {
      var query = _supabase
          .from(AppDatabaseConstants.tractorsTable)
          .select('*, users(name, phone)');

      if (serviceType != null && serviceType != 'all') {
        query = query.contains(AppDatabaseConstants.columnServices, [serviceType]);
      }

      final response = await query;
      return (response as List).map((json) => TractorModel.fromJson(json)).toList();
    } catch (e) {
      AppLogs.error('Get tractors error', error: e, name: 'HomeRepositoryImpl');
      return [];
    }
  }

  @override
  Future<void> bookTractor({
    required String tractorId,
    required String serviceType,
    required double acreage,
    required DateTime date,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not logged in');

      await _supabase.from(AppDatabaseConstants.bookingsTable).insert({
        AppDatabaseConstants.columnKisanId: userId,
        AppDatabaseConstants.columnTractorId: tractorId,
        AppDatabaseConstants.columnServiceType: serviceType,
        AppDatabaseConstants.columnAcreage: acreage,
        AppDatabaseConstants.columnBookingDate: date.toIso8601String(),
        AppDatabaseConstants.columnBookingStatus: 'pending',
      });
    } catch (e) {
      AppLogs.error('Book tractor error', error: e, name: 'HomeRepositoryImpl');
      rethrow;
    }
  }

  @override
  Future<List<TractorEntity>> getMyTractors() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return [];

      final response = await _supabase
          .from(AppDatabaseConstants.tractorsTable)
          .select('*, users(name, phone)')
          .eq(AppDatabaseConstants.columnOwnerId, userId);

      return (response as List).map((json) => TractorModel.fromJson(json)).toList();
    } catch (e) {
      AppLogs.error('Get my tractors error', error: e, name: 'HomeRepositoryImpl');
      return [];
    }
  }

  @override
  Future<void> addTractor(TractorEntity tractor) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not logged in');

      final model = TractorModel(
        id: '',
        ownerId: userId,
        ownerName: tractor.ownerName,
        phone: tractor.phone,
        model: tractor.model,
        hp: tractor.hp,
        services: tractor.services,
        village: tractor.village,
        city: tractor.city,
        district: tractor.district,
        state: tractor.state,
        rating: tractor.rating,
        reviews: tractor.reviews,
        available: tractor.available,
        price: tractor.price,
        image: tractor.image,
        isVerified: tractor.isVerified,
      );

      await _supabase.from(AppDatabaseConstants.tractorsTable).insert(model.toJson());
    } catch (e) {
      AppLogs.error('Add tractor error', error: e, name: 'HomeRepositoryImpl');
      rethrow;
    }
  }
}
