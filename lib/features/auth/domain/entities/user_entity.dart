import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String phoneCode;
  final String countryCode;
  final String role;
  final String profileImage;
  final DateTime? dob;
  final int status;
  final double latitude;
  final double longitude;
  final String? address;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isBlocked;
  final int userType;
  final List<String> deviceTokens;
  final String password;
  final String? bio;
  final String? pronouns;
  final String? age;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.phoneCode,
    required this.countryCode,
    required this.role,
    required this.profileImage,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.address,
    this.dob,
    this.createdAt,
    this.updatedAt,
    required this.isBlocked,
    required this.userType,
    required this.deviceTokens,
    required this.password,
    this.bio,
    this.pronouns,
    this.age,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    phoneCode,
    countryCode,
    role,
    profileImage,
    dob,
    status,
    latitude,
    longitude,
    address,
    createdAt,
    updatedAt,
    isBlocked,
    userType,
    deviceTokens,
    password,
    bio,
    pronouns,
    age,
  ];
}
