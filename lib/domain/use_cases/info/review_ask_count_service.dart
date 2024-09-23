import 'dart:ui';

import 'package:quran_majeed/data/service/local_cache_service.dart';

class ReviewAskCountService {
  ReviewAskCountService(this._cacheService);

  final LocalCacheService _cacheService;

  static const int _numAppOpensToShowReview = 5;

  Future<bool> askForReviewIfAllowed({
    required VoidCallback askForReview,
  }) async {
    final int numAppOpens =
        _cacheService.getData(key: CacheKeys.launchCount) ?? 1;
    final int increasedCount = numAppOpens + 1;
    await _cacheService.saveData<int>(
      key: CacheKeys.launchCount,
      value: increasedCount,
    );

    final bool shouldShow = numAppOpens % _numAppOpensToShowReview == 0;
    if (shouldShow) {
      await _resetNumAppOpens();
      askForReview();
    }

    return shouldShow;
  }

  Future<void> _resetNumAppOpens() async {
    await _cacheService.saveData<int>(key: CacheKeys.launchCount, value: 1);
  }
}
