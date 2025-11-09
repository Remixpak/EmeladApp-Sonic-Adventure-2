import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class Level {
  final String name;
  final int totalHints;
  final int totalResults;
  final String imageAsset; // Guardamos la ruta del asset original
  String? imageLocationPath; // Ruta de la foto tomada
  Image? imageLocation;

  Level({
    required this.name,
    required this.totalHints,
    required this.totalResults,
    required this.imageAsset,
    this.imageLocationPath,
  }) {
    //Si hay ruta guardada, cargamos la imagen
    if (imageLocationPath != null && File(imageLocationPath!).existsSync()) {
      imageLocation = Image.file(File(imageLocationPath!));
    }
  }

  //Convertir a JSON
  Map<String, dynamic> toJson() => {
    'name': name,
    'totalHints': totalHints,
    'totalResults': totalResults,
    'imageAsset': imageAsset,
    'imageLocationPath': imageLocationPath,
  };

  // 🔹 Crear desde JSON
  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      name: json['name'],
      totalHints: json['totalHints'],
      totalResults: json['totalResults'],
      imageAsset: json['imageAsset'],
      imageLocationPath: json['imageLocationPath'],
    );
  }

  // Actualizar imagen de ubicación
  void updateLocationImage(String path) {
    imageLocationPath = path;
    imageLocation = Image.file(File(path));
  }

  //Obtener imagen del asset (para mostrar en KnuckleslevelsScreen)
  Image get image => Image.asset(imageAsset, fit: BoxFit.cover);
}
