// Copyright 2019 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:quran_majeed/core/external_libs/scrollable_positioned_list/src/item_positions_notifier.dart';

abstract class ItemPositionsListener {
  factory ItemPositionsListener.create() => ItemPositionsNotifier();

  ValueListenable<Iterable<ItemPosition>> get itemPositions;
}

class ItemPosition {
  const ItemPosition({
    required this.index,
    required this.itemLeadingEdge,
    required this.itemTrailingEdge,
  });

  final int index;

  final double itemLeadingEdge;

  final double itemTrailingEdge;

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    // ignore: test_types_in_equals
    final ItemPosition? otherPosition = other as ItemPosition?;
    if (otherPosition == null) return false;
    return otherPosition.index == index &&
        otherPosition.itemLeadingEdge == itemLeadingEdge &&
        otherPosition.itemTrailingEdge == itemTrailingEdge;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode =>
      31 * (31 * (7 + index.hashCode) + itemLeadingEdge.hashCode) +
      itemTrailingEdge.hashCode;

  @override
  String toString() =>
      'ItemPosition(index: $index, itemLeadingEdge: $itemLeadingEdge, itemTrailingEdge: $itemTrailingEdge)';
}
