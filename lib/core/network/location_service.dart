import 'package:dio/dio.dart';
import 'package:kisan_app/core/network/api_client.dart';

class LocationPrediction {
  final String name;
  final String city;
  final String country;
  final String fullAddress;
  final double lat;
  final double lng;

  LocationPrediction({
    required this.name,
    required this.city,
    required this.country,
    required this.fullAddress,
    required this.lat,
    required this.lng,
  });

  factory LocationPrediction.fromJson(Map<String, dynamic> json) {
    final props = json['properties'];
    final geometry = json['geometry'];
    final List coords = geometry['coordinates']; // [lng, lat]

    final name = props['name'] ?? '';
    final city = props['city'] ?? props['state'] ?? '';
    final country = props['country'] ?? '';

    return LocationPrediction(
      name: name,
      city: city,
      country: country,
      fullAddress: [name, city, country].where((e) => e.isNotEmpty).join(', '),
      lng: (coords[0] as num).toDouble(),
      lat: (coords[1] as num).toDouble(),
    );
  }
}

class LocationService {
  final ApiClient _apiClient;
  static const String _baseUrl = 'https://photon.komoot.io/api/';

  LocationService(this._apiClient);

  /// Search for locations based on a query string
  Future<List<LocationPrediction>> getPredictions(String query) async {
    if (query.length < 3) return [];

    try {
      final response = await _apiClient.get(
        _baseUrl,
        queryParameters: {'q': query, 'limit': 5},
        options: Options(
          headers: {'User-Agent': 'kisan_app/1.0.0 (contact@herstay.com)'},
        ),
      );

      if (response.statusCode == 200) {
        final List features = response.data['features'];

        return features
            .map((json) => LocationPrediction.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
