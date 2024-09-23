import 'package:quran_majeed/data/data_sources/local_data_source/audio/audio_local_data_source.dart';
import 'package:quran_majeed/data/data_sources/local_data_source/reciter/reciter_local_data_source.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/domain/repositories/reciter/reciter_repository.dart';

class ReciterRepositoryImpl implements ReciterRepository {
  final ReciterLocalDataSource _reciterLocalDataSource;
  final AudioLocalDataSource _audioLocalDataSource;

  ReciterRepositoryImpl(this._reciterLocalDataSource, this._audioLocalDataSource);

  @override
  Future<List<Reciter>> getReciters() async {
    return await _reciterLocalDataSource.getReciters();
  }

  @override
  Future<List<Reciter>> loadRecitersList() async {
    return await _audioLocalDataSource.loadRecitersList();
  }

  @override
  Future<void> saveReciterWithSurahId(int surahId, Reciter reciter, {bool isDelete = false}) async {
    return await _audioLocalDataSource.saveReciterWithSurahId(surahId, reciter, isDelete: isDelete);
  }

  @override
  Future<List<int>> getSurahIdsForReciter(Reciter reciter) async {
    return await _audioLocalDataSource.getSurahIdsForReciter(reciter);
  }

  @override
  Future<void> saveRecitersList(List<Reciter> reciters) async {
    return await _audioLocalDataSource.saveRecitersList(reciters);
  }
  
  @override
  Future<void> saveSelectedReciter(Reciter reciter) {
    return _audioLocalDataSource.saveSelectedReciter(reciter);
  }
  
  @override
  Future<Reciter> getSelectedReciter() {
    return _audioLocalDataSource.getSelectedReciter();
  }
@override
    Future<void> saveDownloadCount(int reciterId, int count) async {
    return await _audioLocalDataSource.saveDownloadCount(reciterId, count);
  }
}
