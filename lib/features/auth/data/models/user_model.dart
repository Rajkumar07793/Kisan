import '../../../../core/constants/app_database_constants.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.phoneCode,
    required super.countryCode,
    required super.role,
    required super.profileImage,
    required super.status,
    required super.latitude,
    required super.longitude,
    required super.address,
    super.dob,
    super.createdAt,
    super.updatedAt,
    required super.isBlocked,
    required super.userType,
    required super.deviceTokens,
    required super.password,
    super.bio,
    super.pronouns,
    super.age,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[AppDatabaseConstants.columnId] ?? '',
      userType: json[AppDatabaseConstants.columnUserType] ?? 0,
      name: json[AppDatabaseConstants.columnName] ?? '',
      email: json[AppDatabaseConstants.columnEmail] ?? '',
      phone: json[AppDatabaseConstants.columnPhone] ?? '',
      phoneCode: json[AppDatabaseConstants.columnPhoneCode] ?? '',
      countryCode: json[AppDatabaseConstants.columnCountryCode] ?? '',
      role: json[AppDatabaseConstants.columnRole] ?? 'user',
      profileImage: json[AppDatabaseConstants.columnProfileImage] ?? "",
      status: json[AppDatabaseConstants.columnStatus] ?? 0,
      dob: json[AppDatabaseConstants.columnDob] != null
          ? DateTime.tryParse(json[AppDatabaseConstants.columnDob])
          : null,
      createdAt: json[AppDatabaseConstants.columnCreatedAt] != null
          ? DateTime.tryParse(json[AppDatabaseConstants.columnCreatedAt])
          : null,
      updatedAt: json[AppDatabaseConstants.columnUpdatedAt] != null
          ? DateTime.tryParse(json[AppDatabaseConstants.columnUpdatedAt])
          : null,
      latitude: (json[AppDatabaseConstants.columnLatitude] ?? 0.0).toDouble(),
      longitude: (json[AppDatabaseConstants.columnLongitude] ?? 0.0).toDouble(),
      address: json[AppDatabaseConstants.columnAddress] ?? '',
      isBlocked: json[AppDatabaseConstants.columnIsBlocked] ?? false,
      deviceTokens: List<String>.from(
        json[AppDatabaseConstants.columnDeviceTokens] ?? [],
      ),
      password: json[AppDatabaseConstants.columnPassword] ?? '',
      bio: json[AppDatabaseConstants.columnBio],
      pronouns: json[AppDatabaseConstants.columnPronouns],
      age: json[AppDatabaseConstants.columnAge],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppDatabaseConstants.columnId: id,
      AppDatabaseConstants.columnName: name,
      AppDatabaseConstants.columnEmail: email,
      AppDatabaseConstants.columnPhone: phone,
      AppDatabaseConstants.columnPhoneCode: phoneCode,
      AppDatabaseConstants.columnCountryCode: countryCode,
      AppDatabaseConstants.columnRole: role,
      AppDatabaseConstants.columnProfileImage: profileImage,
      AppDatabaseConstants.columnStatus: status,
      AppDatabaseConstants.columnDob: dob?.toIso8601String(),
      AppDatabaseConstants.columnCreatedAt: createdAt?.toIso8601String(),
      AppDatabaseConstants.columnUpdatedAt: updatedAt?.toIso8601String(),
      AppDatabaseConstants.columnIsBlocked: isBlocked,
      AppDatabaseConstants.columnUserType: userType,
      AppDatabaseConstants.columnLatitude: latitude,
      AppDatabaseConstants.columnLongitude: longitude,
      AppDatabaseConstants.columnAddress: address,
      AppDatabaseConstants.columnDeviceTokens: deviceTokens,
      AppDatabaseConstants.columnPassword: password,
      AppDatabaseConstants.columnBio: bio,
      AppDatabaseConstants.columnPronouns: pronouns,
      AppDatabaseConstants.columnAge: age,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? phoneCode,
    String? countryCode,
    String? role,
    String? profileImage,
    int? status,
    int? userType,
    DateTime? dob,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? latitude,
    double? longitude,
    String? address,
    bool? isBlocked,
    List<String>? deviceTokens,
    String? password,
    String? bio,
    String? pronouns,
    String? age,
  }) {
    return UserModel(
      id: id ?? this.id,
      userType: userType ?? this.userType,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      phoneCode: phoneCode ?? this.phoneCode,
      countryCode: countryCode ?? this.countryCode,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
      status: status ?? this.status,
      dob: dob ?? this.dob,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      isBlocked: isBlocked ?? this.isBlocked,
      deviceTokens: deviceTokens ?? this.deviceTokens,
      password: password ?? this.password,
      bio: bio ?? this.bio,
      pronouns: pronouns ?? this.pronouns,
      age: age ?? this.age,
    );
  }
}
