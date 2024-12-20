// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flip_notes/data/providers/notes.dart';
import 'package:flutter/material.dart';

enum NoteFields {
  id,
  title,
  contentFront,
  contentBack,
  color,
  tags,
  createdAt,
  updatedAt,
  deletedAt,
}

class Note {
  String id;
  String title;
  String contentFront;
  String contentBack;
  Color color;
  Set<String> tags;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'contentFront': contentFront,
      'contentBack': contentBack,
      'color': color.value,
      'tags': tags.join(', '),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'deletedAt': deletedAt?.millisecondsSinceEpoch,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as String,
      title: map['title'] as String,
      contentFront: map['contentFront'] as String,
      contentBack: map['contentBack'] as String,
      color: Color(map['color'] as int),
      tags: Set<String>.from((map['tags'] as String).split(', ')),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      deletedAt: map['deletedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['deletedAt'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source) as Map<String, dynamic>);
}
