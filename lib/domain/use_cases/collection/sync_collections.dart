import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_folder_entity.dart';
import 'package:quran_majeed/domain/repositories/user_data_repository.dart';


class SyncCollectionUseCase
    extends BaseUseCase<
    // (
      List<BookmarkFolderEntity>
      // , 
    // List<PinEntity>)
    > {
  SyncCollectionUseCase(
    this._userDataRepository,
    super._errorMessageHandler,
  );

  final UserDataRepository _userDataRepository;

  Future<Either<String, 
  // (
    List<BookmarkFolderEntity>
    // , List<PinEntity>)
    >>
      execute() async {
    return mapResultToEither(
      () async => _userDataRepository.syncCollectionsWithRemote(),
    );
  }
}
