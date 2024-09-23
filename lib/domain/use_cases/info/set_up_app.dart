import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/core/utility/number_utility.dart';
import 'package:quran_majeed/presentation/translation/presenter/translation_presenter.dart';

class SetUpAppUseCase extends BaseUseCase<(double, String)> {
  SetUpAppUseCase(
    super.errorMessageHandler,
    this._translationPresenter,
  );
  final TranslationPresenter _translationPresenter;

  // Future<Either<String, void>> execute() async {
  //   await _translationPresenter.initializeData();

  //   return right(null);
  // }

  Stream<Either<String, (double, String)>> listenable({
    bool warmUpOnly = false,
  }) async* {
    const String kLoadingMessage = "DataBase Loading...";
    yield right(const (12, kLoadingMessage));
    if (!warmUpOnly) await _letAppTakeSomeRest();
    await _translationPresenter.initializeData();
    if (!warmUpOnly) yield right(const (16, kLoadingMessage));
    if (!warmUpOnly) await _letAppTakeSomeRest();

    // await catchFutureOrVoid(
    //   () async => _hadithBookRepository.getAllHadithBooks(),
    // );
    if (!warmUpOnly) yield right(const (18, kLoadingMessage));
    if (!warmUpOnly) await _letAppTakeSomeRest();

    // await catchFutureOrVoid(
    //   () async => _hadithRepository.getHadithSectionsByBookAndChapterId(
    //     hadithBookId: 1,
    //     chapterId: 1,
    //   ),
    // );
    if (!warmUpOnly) yield right(const (28, kLoadingMessage));
    if (!warmUpOnly) await _letAppTakeSomeRest();

    // await catchFutureOrVoid(
    //   () async => _hadithRepository.getHadithSectionPairByGroup(
    //     bookId: 1,
    //     chapterId: 1,
    //   ),
    // );
    if (!warmUpOnly) yield right(const (46, kLoadingMessage));
    if (!warmUpOnly) await _letAppTakeSomeRest();

    // await catchFutureOrVoid(
    //   () async => _userDataRepository.retrieveLegacyData(),
    // );
    if (!warmUpOnly) yield right(const (63, kLoadingMessage));
    if (!warmUpOnly) await _letAppTakeSomeRest();

    // await catchFutureOrVoid(() async => _userDataRepository.getAllBookmarks());
    if (!warmUpOnly) yield right(const (81, kLoadingMessage));
    if (!warmUpOnly) await _letAppTakeSomeRest();

    // await catchFutureOrVoid(
    //   () async => _hadithRepository.getHadithSectionsByBookAndChapterId(
    //     hadithBookId: 1,
    //     chapterId: 1,
    //   ),
    // );
    if (!warmUpOnly) yield right(const (88, kLoadingMessage));
    if (!warmUpOnly) await _letAppTakeSomeRest();

    // await catchFutureOrVoid(() async => _userDataRepository.getLastReads());
    if (!warmUpOnly) yield right(const (91, kLoadingMessage));
    if (!warmUpOnly) await _letAppTakeSomeRest();

    // await catchFutureOrVoid(
    //   () async => _userDataRepository.syncCollectionsWithRemote(),
    // );
    if (!warmUpOnly) yield right(const (97, kLoadingMessage));
    if (!warmUpOnly) await _letAppTakeSomeRest();

    // const TimeOfDay defaultTime = TimeOfDay(hour: 9, minute: 0);
    // unawaited(
    //   _settingsRepository.scheduleNotification(time: defaultTime, turnOn: true),
    // );

    if (!warmUpOnly) await _letAppTakeSomeRest();
    if (!warmUpOnly) await _letAppTakeSomeRest();
    if (!warmUpOnly) yield right(const (100, kLoadingMessage));
  }

  Future<void> _letAppTakeSomeRest() async {
    await Future<void>.delayed(125.inMilliseconds);
  }
}
