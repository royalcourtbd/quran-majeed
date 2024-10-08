// Copyright 2019 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

import 'package:quran_majeed/core/external_libs/scrollable_positioned_list/src/item_positions_listener.dart';

/// Internal implementation of [ItemPositionsListener].
class ItemPositionsNotifier implements ItemPositionsListener {
  @override
  final ValueNotifier<Iterable<ItemPosition>> itemPositions = ValueNotifier([]);
}
