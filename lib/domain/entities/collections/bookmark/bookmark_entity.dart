import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BookmarkEntity extends Equatable {
  const BookmarkEntity({
    this.id = -1,
    required this.folderName,
    required this.color,
    required this.surahID,
    required this.ayahID,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookmarkEntity.placeholder({
    required String folderName,
    required Color color,
    required int surahID,
    required int ayahID,
  }) {
    return BookmarkEntity(
      folderName: folderName,
      color: color,
      surahID: surahID,
      ayahID: ayahID,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  final int id;
  final String folderName;
  final int surahID;
  final int ayahID;
  final Color color;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        folderName,
        color,
        surahID,
        ayahID,
        createdAt,
        updatedAt,
      ];

  BookmarkEntity withId(int id) {
    return BookmarkEntity(
      id: id,
      folderName: folderName,
      surahID: surahID,
      ayahID: ayahID,
      color: color,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }

  BookmarkEntity copyWith({
    int? id,
    String? folderName,
    Color? color,
    int? surahID,
    int? ayahID,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookmarkEntity(
      id: id ?? this.id,
      folderName: folderName ?? this.folderName,
      color: color ?? this.color,
      surahID: surahID ?? this.surahID,
      ayahID: ayahID ?? this.ayahID,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isInValid =>
      id <= 0 || folderName.isEmpty || surahID <= 0 || ayahID <= 0;
}
