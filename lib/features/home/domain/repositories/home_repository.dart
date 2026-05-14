import '../entities/tractor_entity.dart';

abstract class HomeRepository {
  Future<List<TractorEntity>> getTractors({String? serviceType});
  Future<void> bookTractor({
    required String tractorId,
    required String serviceType,
    required double acreage,
    required DateTime date,
  });
  Future<List<TractorEntity>> getMyTractors();
  Future<void> addTractor(TractorEntity tractor);
}
