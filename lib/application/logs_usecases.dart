import 'package:col_moda_empresa/domain/dtos/log_request.dto.dart';
import 'package:col_moda_empresa/domain/entities/Log.entitie.dart';
import 'package:col_moda_empresa/infraestructure/persistence/repositories/unit_of_work.dart';
import 'package:flutter/material.dart';

class LogsUseCases {
  final UnitOfWork _unitOfWork = UnitOfWork();

  /// 📌 Agrega un log a la base de datos dentro de una transacción
  Future<void> addLog(LogRequestDto logRequest) async {
    debugPrint("🟡 addLog() llamado con mensaje: ${logRequest.message} | Nivel: ${logRequest.level} | Módulo: ${logRequest.module}");
    
    try {
      await _unitOfWork.transaction((txnId) async {
        debugPrint("🔄 [Transaction: $txnId] Insertando log...");

        // 📌 Aseguramos que el `transactionId` sea consistente
        final logEntity = logRequest.toEntity().copyWith(transactionId: txnId);
        await _unitOfWork.logRepository.insertLog(logEntity: logEntity);

        debugPrint("✅ [Transaction: $txnId] Log insertado dentro de la transacción");
      });

      final logs = await getLogs();
      debugPrint("📝 Logs después de transacción: ${logs.length}");

      debugPrint("🟢 addLog() completado");
    } catch (e) {
      debugPrint("❌ [addLog] Error: $e");
    }
  }

  /// 📌 Agrega múltiples logs en una única transacción
  Future<void> multipleOperations(List<LogRequestDto> logs) async {
    if (logs.isEmpty) {
      debugPrint("⚠️ multipleOperations() recibió una lista vacía de logs. No se realizará ninguna operación.");
      return;
    }

    try {
      await _unitOfWork.transaction((txnId) async {
        debugPrint("🟡 [Transaction: $txnId] Insertando ${logs.length} logs...");

        for (var logRequest in logs) {
          final logEntity = logRequest.toEntity().copyWith(transactionId: txnId);
          await _unitOfWork.logRepository.insertLog(logEntity: logEntity);
          debugPrint("✅ [Transaction: $txnId] Log insertado: ${logRequest.message}");
        }
      });

      debugPrint("🟢 multipleOperations() completado con ${logs.length} logs");
    } catch (e) {
      debugPrint("❌ [multipleOperations] Error: $e");
    }
  }

  /// 📌 Obtiene todos los logs
  Future<List<LogEntity>> getLogs() async {
    try {
      final logs = await _unitOfWork.logRepository.getLogs();
      debugPrint("📜 Total logs en la base de datos: ${logs.length}");
      return logs;
    } catch (e) {
      debugPrint("❌ [getLogs] Error al obtener logs: $e");
      return [];
    }
  }
}
