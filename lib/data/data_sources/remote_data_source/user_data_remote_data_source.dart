import 'dart:ui';

import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/data/mappers/bookmark/bookmark_mapper.dart';
import 'package:quran_majeed/data/service/backend_as_a_service.dart';
import 'package:quran_majeed/domain/entities/collections/bookmark/bookmark_entity.dart';

class UserDataRemoteDataSource {
  UserDataRemoteDataSource(this._backendAsAService);

  final BackendAsAService _backendAsAService;

  Future<bool> get _authenticated => _backendAsAService.isAuthenticated;

  Future<void> addAyahToBookmarkFolder({required BookmarkEntity bookmark}) async {
    await catchFutureOrVoid(() async {
      final Map<String, Object?> bookmarkMap = await bookmark.toMap();
      await _backendAsAService.addBookmark(bookmark: bookmarkMap);
    });
  }

  Future<void> deleteAyahFromBookmarks({
    required int surahID,
    required int ayahID,
    required String folderName,
  }) async {
    await catchFutureOrVoid(
      () async => _backendAsAService.deleteAyahFromBookmarks(
        surahID: surahID,
        ayahID: ayahID,
      ),
    );
  }



  Future<void> deleteBookmarkFolder({required String folderName}) async {
    await catchFutureOrVoid(() async {
      final bool authenticated = await _authenticated;
      if (!authenticated) return;
      await _backendAsAService.deleteBookmarkFolder(folderName: folderName);
    });
  }

  // Future<void> deletePin({required PinEntity pin}) async {
  //   await catchFutureOrVoid(
  //     () async => _backendAsAService.deletePinByName(pinName: pin.name),
  //   );
  // }

  Future<void> saveBookmarks(List<BookmarkEntity> bookmarks) async {
    await catchFutureOrVoid(() async {
      final List<Map<String, Object?>> bookmarkMaps = await bookmarks.toMapList();
      await _backendAsAService.saveBookmarks(bookmarks: bookmarkMaps);
    });
  }

  // Future<void> savePins(List<PinEntity> pins) async {
  //   await catchFutureOrVoid(() async {
  //     final List<Map<String, Object?>> pinMaps = await convertPinListToMapList(pins: pins);
  //     await _backendAsAService.savePins(pins: pinMaps);
  //   });
  // }

  Future<void> deleteAyahFromBookmark({ required int surahID, required int ayahID
  }) async {
    await catchFutureOrVoid(
      () async => _backendAsAService.deleteAyahFromBookmarks(
        surahID: surahID,
        ayahID: ayahID,
      ),
    );
  }

  Future<void> saveBookmarksToAyah({
   required int surahID, required int ayahID,
    required List<BookmarkEntity> bookmarks,
  }) async {
    await catchFutureOrVoid(() async {
      await deleteAyahFromBookmark(surahID: surahID, ayahID: ayahID);
      if (bookmarks.isEmpty) return;
      final List<Map<String, Object?>> bookmarkMaps = await bookmarks.toMapList();
      await _backendAsAService.saveBookmarks(bookmarks: bookmarkMaps);
    });
  }

  Future<List<BookmarkEntity>> getSavedBookmarks() async {
    final List<BookmarkEntity>? bookmarks = await catchAndReturnFuture(() async {
      final List<Map<String, Object?>> bookmarkDtoMaps = await _backendAsAService.getSavedBookmarks();
      final List<BookmarkEntity> bookmarks = await bookmarkDtoMaps.toBookmarks();
      return bookmarks;
    });

    return bookmarks ?? [];
  }

  // Future<List<PinEntity>> getSavePins() async {
  //   final List<PinEntity>? pins = await catchAndReturnFuture(() async {
  //     final List<Map<String, Object?>> pinMaps = await _backendAsAService.getSavedPins();
  //     final List<PinEntity> pins = await convertMapListToPinList(maps: pinMaps);
  //     return pins;
  //   });
  //   return pins ?? [];
  // }

  // Future<UpdateInfoEntity> getAppUpdateInfo() async {
  //   final Map<String, dynamic> updateInfoJson = await _backendAsAService.getAppUpdateInfo();
  //   final UpdateInfoEntity updateInfo = await convertJsonToUpdateInfo(json: updateInfoJson);
  //   return updateInfo;
  // }

  Future<void> updateBookmarkFolderName({
    required String folderName,
    required String newFolderName,
    required Color color,
  }) async {
    await catchFutureOrVoid(() async {
      final bool authenticated = await _authenticated;
      if (!authenticated) return;

      await _backendAsAService.updateBookmarkFolderName(
        folderName: folderName,
        newFolderName: newFolderName,
        color: color,
      );
    });
  }

  // Future<void> updatePin({
  //   required String pinName,
  //   required String newPinName,
  //   required Color color,
  // }) async {
  //   await catchFutureOrVoid(() async {
  //     final bool authenticated = await _authenticated;
  //     if (!authenticated) return;

  //     await _backendAsAService.updatePin(
  //       pinName: pinName,
  //       newPinName: newPinName,
  //       color: color,
  //     );
  //   });
  // }

  Future<void> deleteAyahFromBookmarkFolder({
    required int surahID,
    required int ayahID,
    required String folderName,
  }) async {
    await catchFutureOrVoid(
      () async => _backendAsAService.deleteAyahFromBookmarkFolder(
        surahID: surahID,
        ayahID: ayahID,
        folderName: folderName,
      ),
    );
  }
}
