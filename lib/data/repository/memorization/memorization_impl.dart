import 'package:quran_majeed/domain/entities/memorization/mermoization_entity.dart';

import '../../../domain/repositories/memorization/memorization_repository.dart';
import '../../data_sources/local_data_source/memorization/memorization_local_data_source.dart';

class MemorizationRepositoryImpl extends MemorizationRepository {
  MemorizationRepositoryImpl(this._userDataLocalDataSource);
  final MemorizationLocalDataSource _userDataLocalDataSource;
  @override
  Future<List<MemorizationEntity>> saveMemorization(
      MemorizationEntity memorization) {
    return _userDataLocalDataSource.saveMemorization(memorization);
  }

  @override
  Future<List<MemorizationEntity>> getMemorization() {
    return _userDataLocalDataSource.getMemorization();
  }

  @override
  Future<List<MemorizationEntity>> deleteMemorization(String id) {
    return _userDataLocalDataSource.deleteMemorization(id);
  }
}
