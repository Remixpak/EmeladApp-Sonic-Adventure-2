import 'package:flutter/material.dart';

class Level {
  final String name;
  final int totalHints;
  final int totalResults;
  final Image image;

  Level({
    required this.name,
    required this.totalHints,
    required this.totalResults,
    required this.image,
  });
}
