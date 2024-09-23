import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/domain/entities/memorization/mermoization_entity.dart';
import 'package:quran_majeed/domain/repositories/memorization/memorization_repository.dart';

class MemorizationUseCase {
  Future<List<MemorizationEntity>> save({
    required MemorizationEntity memorization,
  }) async {
    final MemorizationRepository memorizationRepository = locate();
    return await memorizationRepository.saveMemorization(memorization);
  }

  Future<List<MemorizationEntity>> getList() async {
    final MemorizationRepository memorizationRepository = locate();
    return await memorizationRepository.getMemorization();
  }

  Future<List<MemorizationEntity>> delete(String id) async {
    final MemorizationRepository memorizationRepository = locate();
    return await memorizationRepository.deleteMemorization(id);
  }
}
