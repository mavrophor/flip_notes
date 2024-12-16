import 'package:flutter/material.dart';

class Note {
  Note({
    required this.id,
    required this.title,
    required this.contentFront,
    required this.contentBack,
    required this.color,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  String id;
  String title;
  String contentFront;
  String contentBack;
  Color color;
  Set<String> tags;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  Note copyWith(
      {String? title,
      String? contentFront,
      String? contentBack,
      Color? color,
      Set<String>? tags,
      DateTime? createdAt,
      DateTime? updatedAt,
      ValueGetter<DateTime?>? deletedAt}) {
    return Note(
        id: id,
        title: title ?? this.title,
        contentFront: contentFront ?? this.contentFront,
        contentBack: contentBack ?? this.contentBack,
        color: color ?? this.color,
        tags: tags ?? this.tags,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt != null ? deletedAt() : this.deletedAt);
  }

  @override
  String toString() {
    return 'Note{id=$id, title=$title, contentFront=${contentFront.substring(0, 100)}, contentBack=${contentBack.substring(0, 100)}, color=$color, tags=$tags, createdAt=$createdAt, updatedAt=$updatedAt, deletedAt=$deletedAt}';
  }
}
