import 'package:col_moda_empresa/application/logs_usecases.dart';
import 'package:logger/logger.dart';
import 'package:col_moda_empresa/domain/dtos/log_request.dto.dart';

class LoggerUtil {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // Oculta stacktrace
      errorMethodCount: 3, // Muestra 3 líneas en errores
      lineLength: 80, // Máximo de caracteres por línea
      colors: true, // Activa colores
      printEmojis: true, // Agrega emojis a los logs
    ),
  );

  static final LogsUseCases _logsUseCases = LogsUseCases(); // Inyectamos el servicio

  // ────────────────────────────────────────────────────────────────
  // 📌 DEBUG (Solo imprime)
  // ────────────────────────────────────────────────────────────────
  static void debug(String module, String message, {Map<String, dynamic>? context}) {
    _logger.d("[$module] $message");
  }

  static Future<void> debugWithSave(String module, String message, {Map<String, dynamic>? context}) async {
    _logger.d("[$module] $message");
    await _logsUseCases.addLog(LogRequestDto.debug(module, message, context: context));
  }

  // ────────────────────────────────────────────────────────────────
  // 📌 INFO (Solo imprime)
  // ────────────────────────────────────────────────────────────────
  static void info(String module, String message, {Map<String, dynamic>? context}) {
    _logger.i("[$module] $message");
  }

  static Future<void> infoWithSave(String module, String message, {Map<String, dynamic>? context}) async {
    _logger.i("[$module] $message");
    await _logsUseCases.addLog(LogRequestDto.info(module, message, context: context));
  }

  // ────────────────────────────────────────────────────────────────
  // ⚠️ WARNING (Imprime y opcionalmente guarda en DB)
  // ────────────────────────────────────────────────────────────────
  static void warning(String module, String message, {Map<String, dynamic>? context}) {
    _logger.w("[$module] $message");
  }

  static Future<void> warningWithSave(String module, String message, {Map<String, dynamic>? context}) async {
    _logger.w("[$module] $message");
    await _logsUseCases.addLog(LogRequestDto.warning(module, message, context: context));
  }

  // ────────────────────────────────────────────────────────────────
  // ❌ ERROR (Imprime y opcionalmente guarda en DB)
  // ────────────────────────────────────────────────────────────────
  static void error(String module, String message, {Map<String, dynamic>? context}) {
    _logger.e("[$module] $message");
  }

  static Future<void> errorWithSave(String module, String message, {Map<String, dynamic>? context}) async {
    _logger.e("[$module] $message");
    await _logsUseCases.addLog(LogRequestDto.error(module, message, context: context));
  }

  // ────────────────────────────────────────────────────────────────
  // 📌 Log múltiple con opción de guardado
  // ────────────────────────────────────────────────────────────────
  static Future<void> multiple(List<LogRequestDto> logs, {bool save = false}) async {
    List<LogRequestDto> logsToSave = [];

    for (var log in logs) {
      _logger.log(
        _getLogLevel(log.level),
        "[${log.module}] ${log.message}",
      );

      // Guardar en DB solo si `save` es true
      if (save) {
        logsToSave.add(log);
      }
    }

    if (save && logsToSave.isNotEmpty) {
      await _logsUseCases.multipleOperations(logsToSave);
    }
  }

  /// 🔹 Convierte string a nivel de log
  static Level _getLogLevel(String level) {
    switch (level.toUpperCase()) {
      case "DEBUG":
        return Level.debug;
      case "INFO":
        return Level.info;
      case "WARNING":
        return Level.warning;
      case "ERROR":
        return Level.error;
      default:
        return Level.info;
    }
  }
}
