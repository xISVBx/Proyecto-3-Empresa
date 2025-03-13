import 'dart:convert';
import 'package:uuid/uuid.dart';  // 👈 Para generar transactionId único
import 'package:col_moda_empresa/domain/entities/Log.entitie.dart';

class LogRequestDto {
  final String transactionId;
  final String level;
  final String message;
  final DateTime timestamp;
  final String module;
  final Map<String, dynamic>? context;

  /// 🔒 Constructor privado (evita instancias directas)
  LogRequestDto._({
    required this.transactionId,
    required this.level,
    required this.message,
    required this.timestamp,
    required this.module,
    this.context,
  });

  /// ✅ **Factory interno para generar logs**
  static LogRequestDto _create({
    required String level,
    required String module,
    required String message,
    Map<String, dynamic>? context,
  }) {
    return LogRequestDto._(
      transactionId: const Uuid().v4(),
      level: level,
      message: message,
      timestamp: DateTime.now(),
      module: module,
      context: context,
    );
  }

  /// 🔹 **Métodos Factory para cada nivel**
  static LogRequestDto debug(String module, String message, {Map<String, dynamic>? context}) {
    return _create(level: "DEBUG", module: module, message: message, context: context);
  }

  static LogRequestDto info(String module, String message, {Map<String, dynamic>? context}) {
    return _create(level: "INFO", module: module, message: message, context: context);
  }

  static LogRequestDto warning(String module, String message, {Map<String, dynamic>? context}) {
    return _create(level: "WARNING", module: module, message: message, context: context);
  }

  static LogRequestDto error(String module, String message, {Map<String, dynamic>? context}) {
    return _create(level: "ERROR", module: module, message: message, context: context);
  }

  /// 📌 Convierte `LogRequestDto` a `LogEntity`
  LogEntity toEntity() {
    return LogEntity(
      transactionId: transactionId,
      level: level,
      message: message,
      timestamp: timestamp.toIso8601String(),
      module: module,
      context: context != null ? jsonEncode(context) : null,
    );
  }

  @override
  String toString() {
    return 'LogRequestDto(transactionId: $transactionId, level: $level, message: $message, timestamp: $timestamp, module: $module, context: $context)';
  }
}
