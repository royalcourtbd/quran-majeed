import 'package:quran_majeed/domain/entities/memorization/mermoization_entity.dart';

import '../../../../domain/repositories/memorization/memorization_repository.dart';
import '../../../service/local_cache_service.dart';

class MemorizationLocalDataSource extends MemorizationRepository {
  MemorizationLocalDataSource(this._localCacheService);
  final LocalCacheService _localCacheService;

  @override
  Future<List<MemorizationEntity>> saveMemorization(
      MemorizationEntity memorization) async {
    final memorizationCachedDate = await getMemorization();
    memorizationCachedDate.add(memorization);

    _cacheMemorization(memorizationCachedDate);

    return await getMemorization();
  }

  @override
  Future<List<MemorizationEntity>> getMemorization() async {
    final String? memorizationCachedDate =
        _localCacheService.getData(key: CacheKeys.memorization);

    // Parse the cached data into a list of LastReadEntity objects.
    return memorizationCachedDate != null
        ? memorizationEntityFromJson(memorizationCachedDate)
        : [];
  }

  _cacheMemorization(List<MemorizationEntity> memorizations) {
    _localCacheService.saveData(
        key: CacheKeys.memorization,
        value: memorizationEntityToJson(memorizations));
  }

  @override
  Future<List<MemorizationEntity>> deleteMemorization(String id) async {
    final memorization = await getMemorization();

    memorization.removeWhere((element) => element.id == id);
    _cacheMemorization(memorization);

    return await getMemorization();
  }
}
