import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quran_majeed/core/utility/utility.dart';

// Add this enum for sort options
enum SortOptionType {
  aToZ,
  createdDate,
  lastUpdated,
}

class SortOptionEntity extends Equatable {
  const SortOptionEntity({
    required this.type,
    required this.isSelected,
  });

  final SortOptionType type;
  final bool isSelected;

  @override
  List<Object?> get props => [type, isSelected];

  // Update this method to use the new enum
  static List<SortOptionEntity> get options => [
        const SortOptionEntity(type: SortOptionType.aToZ, isSelected: true),
        const SortOptionEntity(
            type: SortOptionType.createdDate, isSelected: false),
        const SortOptionEntity(
            type: SortOptionType.lastUpdated, isSelected: false),
      ];

  // Add this method to get localized name
  String getName(BuildContext context) {
    switch (type) {
      case SortOptionType.aToZ:
        return context.l10n.aToZ;
      case SortOptionType.createdDate:
        return context.l10n.createdDate;
      case SortOptionType.lastUpdated:
        return context.l10n.lastUpdate;
    }
  }
}
