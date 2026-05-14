class AppDatabaseConstants {
  // Table Names
  static const String usersTable = 'users';
  static const String contentManagementTable = 'content_management';
  static const String contactUsTable = 'contact_us';
  static const String tractorsTable = 'tractors';
  static const String bookingsTable = 'bookings';

  // Content Management
  static const String columnContentKey = 'content_key';
  static const String columnContent = 'content';

  // Content Management Keys
  static const String privacyPolicy = 'privacyPolicy';
  static const String termsAndConditions = 'termsAndConditions';
  static const String communityGuidelines = 'communityGuidelines';

  // User Table Column Keys
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnEmail = 'email';
  static const String columnPhone = 'phone';
  static const String columnPhoneCode = 'phone_code';
  static const String columnCountryCode = 'country_code';
  static const String columnRole = 'role';
  static const String columnProfileImage = 'profile_image';
  static const String columnDob = 'dob';
  static const String columnStatus = 'status';
  static const String columnLatitude = 'latitude';
  static const String columnLongitude = 'longitude';
  static const String columnAddress = 'address';
  static const String columnIsBlocked = 'is_blocked';
  static const String columnUserType = 'user_type';
  static const String columnDeviceTokens = 'device_tokens';
  static const String columnPassword = 'password';
  static const String columnInspirations = 'inspirations';
  static const String columnBio = 'bio';
  static const String columnPronouns = 'pronouns';
  static const String columnAge = 'age';
  static const String columnUpdatedAt = 'updated_at';
  static const String columnCreatedAt = 'created_at';

  // Tractor Table Column Keys
  static const String columnOwnerId = 'owner_id';
  static const String columnTractorModel = 'model';
  static const String columnHp = 'hp';
  static const String columnServices = 'services';
  static const String columnVillage = 'village';
  static const String columnCity = 'city';
  static const String columnDistrict = 'district';
  static const String columnState = 'state';
  static const String columnRating = 'rating';
  static const String columnReviews = 'reviews';
  static const String columnAvailable = 'available';
  static const String columnPrice = 'price';
  static const String columnImage = 'image';
  static const String columnIsVerified = 'is_verified';

  // Booking Table Column Keys
  static const String columnKisanId = 'kisan_id';
  static const String columnTractorId = 'tractor_id';
  static const String columnBookingDate = 'booking_date';
  static const String columnServiceType = 'service_type';
  static const String columnBookingStatus = 'booking_status';
  static const String columnAcreage = 'acreage';
  static const String columnTotalCost = 'total_cost';

  // Storage Buckets
  static const String avatarsBucket = 'avatars';
}
