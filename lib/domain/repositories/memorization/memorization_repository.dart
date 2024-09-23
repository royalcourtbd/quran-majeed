import 'package:quran_majeed/domain/entities/memorization/mermoization_entity.dart';

abstract class MemorizationRepository {
  Future<List<MemorizationEntity>> saveMemorization(
      MemorizationEntity memorization);

  Future<List<MemorizationEntity>> getMemorization();
  Future<List<MemorizationEntity>> deleteMemorization(String id);
}
