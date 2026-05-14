import 'package:kisan_app/core/constants/app_database_constants.dart';
import '../../domain/entities/tractor_entity.dart';

class TractorModel extends TractorEntity {
  const TractorModel({
    required super.id,
    required super.ownerId,
    required super.ownerName,
    required super.phone,
    required super.model,
    required super.hp,
    required super.services,
    required super.village,
    required super.city,
    required super.district,
    required super.state,
    required super.rating,
    required super.reviews,
    required super.available,
    required super.price,
    required super.image,
    required super.isVerified,
  });

  factory TractorModel.fromJson(Map<String, dynamic> json) {
    // Handling potential nested owner data from Supabase join
    final ownerData = json['users'] as Map<String, dynamic>?;
    
    return TractorModel(
      id: json[AppDatabaseConstants.columnId]?.toString() ?? '',
      ownerId: json[AppDatabaseConstants.columnOwnerId]?.toString() ?? '',
      ownerName: ownerData?[AppDatabaseConstants.columnName] ?? 'Unknown Owner',
      phone: ownerData?[AppDatabaseConstants.columnPhone] ?? '',
      model: json[AppDatabaseConstants.columnTractorModel] ?? '',
      hp: json[AppDatabaseConstants.columnHp] ?? '',
      services: List<String>.from(json[AppDatabaseConstants.columnServices] ?? []),
      village: json[AppDatabaseConstants.columnVillage] ?? '',
      city: json[AppDatabaseConstants.columnCity] ?? '',
      district: json[AppDatabaseConstants.columnDistrict] ?? '',
      state: json[AppDatabaseConstants.columnState] ?? '',
      rating: (json[AppDatabaseConstants.columnRating] ?? 0.0).toDouble(),
      reviews: json[AppDatabaseConstants.columnReviews] ?? 0,
      available: json[AppDatabaseConstants.columnAvailable] ?? true,
      price: json[AppDatabaseConstants.columnPrice] ?? '',
      image: json[AppDatabaseConstants.columnImage] ?? '🚜',
      isVerified: json[AppDatabaseConstants.columnIsVerified] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppDatabaseConstants.columnOwnerId: ownerId,
      AppDatabaseConstants.columnTractorModel: model,
      AppDatabaseConstants.columnHp: hp,
      AppDatabaseConstants.columnServices: services,
      AppDatabaseConstants.columnVillage: village,
      AppDatabaseConstants.columnCity: city,
      AppDatabaseConstants.columnDistrict: district,
      AppDatabaseConstants.columnState: state,
      AppDatabaseConstants.columnRating: rating,
      AppDatabaseConstants.columnReviews: reviews,
      AppDatabaseConstants.columnAvailable: available,
      AppDatabaseConstants.columnPrice: price,
      AppDatabaseConstants.columnImage: image,
      AppDatabaseConstants.columnIsVerified: isVerified,
    };
  }
}
