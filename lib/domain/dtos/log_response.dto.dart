import 'dart:convert';

import 'package:col_moda_empresa/domain/entities/Log.entitie.dart';
import 'package:flutter/material.dart';

class LogResponseDto {
  final int? id;
  final String transactionId;
  final String level; // INFO, WARNING, ERROR
  final String message;
  final DateTime timestamp; // Se convierte a DateTime
  final String module;
  final Map<String, dynamic>? context; // Se maneja como Map en Flutter

  LogResponseDto({
    this.id,
    required this.transactionId,
    required this.level,
    required this.message,
    required this.timestamp,
    required this.module,
    this.context,
  });

  /// 📌 Crea un `LogResponseDto` a partir de un `LogEntity`
  factory LogResponseDto.fromEntity(LogEntity entity) {
    return LogResponseDto(
      id: entity.id,
      transactionId: entity.transactionId,
      level: entity.level,
      message: entity.message,
      timestamp: DateTime.parse(entity.timestamp), // Se convierte a DateTime
      module: entity.module,
      context: _parseContext(entity.context),
    );
  }

  /// 📌 Convierte un `LogResponseDto` de nuevo a `LogEntity`
  LogEntity toEntity() {
    return LogEntity(
      id: id,
      transactionId: transactionId,
      level: level,
      message: message,
      timestamp: timestamp.toIso8601String(), // Se convierte a String
      module: module,
      context: context != null ? jsonEncode(context) : null,
    );
  }

  /// 📌 Parsea el campo `context` de `String` a `Map<String, dynamic>`
  static Map<String, dynamic>? _parseContext(String? contextString) {
    if (contextString == null) return null;
    try {
      return jsonDecode(contextString);
    } catch (e) {
      debugPrint("❌ [LogResponseDto] Error al parsear contexto: $e");
      return null;
    }
  }

  @override
  String toString() {
    return 'LogResponseDto(id: $id, transactionId: $transactionId, level: $level, message: $message, timestamp: $timestamp, module: $module, context: $context)';
  }
}
