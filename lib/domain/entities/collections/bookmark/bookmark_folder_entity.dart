import 'dart:ui';

import 'package:equatable/equatable.dart';

class BookmarkFolderEntity extends Equatable {
  const BookmarkFolderEntity({
    required this.id,
    required this.name,
    required this.color,
    required this.count,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookmarkFolderEntity.favourites() {
    return BookmarkFolderEntity(
      id: 28938,
      name: "Favourites",
      color: const Color(0xff17B686),
      count: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  factory BookmarkFolderEntity.empty() => BookmarkFolderEntity(
        id: -1,
        name: '',
        count: 0,
        color: const Color(0xFF000000),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  final int id;
  final String name;
  final Color color;
  final int count;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        name,
        color,
        count,
        createdAt,
        updatedAt,
      ];

  BookmarkFolderEntity updatedId(int id) => BookmarkFolderEntity(
        id: id,
        name: name,
        color: color,
        count: count,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  bool get isInvalid => id <= 0 || name.isEmpty;

  BookmarkFolderEntity copyWith({
    int? id,
    String? name,
    Color? color,
    int? count,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookmarkFolderEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      count: count ?? this.count,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
