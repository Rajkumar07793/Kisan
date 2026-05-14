import 'package:equatable/equatable.dart';

class TractorEntity extends Equatable {
  final String id;
  final String ownerId;
  final String ownerName;
  final String phone;
  final String model;
  final String hp;
  final List<String> services;
  final String village;
  final String city;
  final String district;
  final String state;
  final double rating;
  final int reviews;
  final bool available;
  final String price;
  final String image;
  final bool isVerified;

  const TractorEntity({
    required this.id,
    required this.ownerId,
    required this.ownerName,
    required this.phone,
    required this.model,
    required this.hp,
    required this.services,
    required this.village,
    required this.city,
    required this.district,
    required this.state,
    required this.rating,
    required this.reviews,
    required this.available,
    required this.price,
    required this.image,
    required this.isVerified,
  });

  @override
  List<Object?> get props => [
        id,
        ownerId,
        ownerName,
        phone,
        model,
        hp,
        services,
        village,
        city,
        district,
        state,
        rating,
        reviews,
        available,
        price,
        image,
        isVerified,
      ];
}
