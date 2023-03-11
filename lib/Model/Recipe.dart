import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Recipe {
  final String id;
  final String title;
  final String description;
  final List<dynamic> Ingredients;
  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.Ingredients,
  });

  Recipe copyWith({
    String? id,
    String? title,
    String? description,
    List<dynamic>? Ingredients,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      Ingredients: Ingredients ?? this.Ingredients,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'Ingredients': Ingredients,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        Ingredients: List<dynamic>.from(
          (map['Ingredients'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) =>
      Recipe.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Recipe(id: $id, title: $title, description: $description, Ingredients: $Ingredients)';
  }

  @override
  bool operator ==(covariant Recipe other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        listEquals(other.Ingredients, Ingredients);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        Ingredients.hashCode;
  }
}
