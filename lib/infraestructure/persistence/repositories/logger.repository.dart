import 'package:col_moda_empresa/domain/entities/Log.entitie.dart';
import 'package:col_moda_empresa/shared/utilities/logger_util.dart';
import 'unit_of_work.dart';

class LogRepository {
  final UnitOfWork _unitOfWork;

  LogRepository(this._unitOfWork);

  /// 🟢 **Inserta un log con ID de transacción automático**
  Future<void> insertLog({required LogEntity logEntity}) async {
    try {
      final db = await _unitOfWork.databaseOrTransaction;
      final String? transactionId = _unitOfWork.currentTransactionId;

      final logWithTxn = logEntity.copyWith(transactionId: transactionId ?? "NO_TXN");

      int result = await db.insert('logs', logWithTxn.toMap());

      LoggerUtil.info("LogRepository","✅ [insertLog] Log insertado correctamente (ID: $result) | TXN: ${transactionId ?? 'NO_TXN'}");
    } catch (e) {
      LoggerUtil.error("LogRepository","❌ [insertLog] Error al insertar log: $e");
    }
  }

  /// 📌 Obtiene todos los logs almacenados en la base de datos
  Future<List<LogEntity>> getLogs() async {
    try {
      final db = await _unitOfWork.databaseOrTransaction;
      final List<Map<String, dynamic>> maps = await db.query('logs');

      LoggerUtil.info("LogRepository","📋 Logs recuperados desde la BD: ${maps.length}");
      return maps.map((map) => LogEntity.fromMap(map)).toList();
    } catch (e) {
      LoggerUtil.error("LogRepository","❌ [getLogs] Error al obtener logs: $e");
      return [];
    }
  }

  /// 📌 Obtiene un log específico por su ID
  Future<LogEntity?> getLogById(int id) async {
    try {
      final db = await _unitOfWork.databaseOrTransaction;
      final List<Map<String, dynamic>> result = await db.query('logs', where: 'id = ?', whereArgs: [id]);

      if (result.isNotEmpty) {
        return LogEntity.fromMap(result.first);
      }
      return null;
    } catch (e) {
      LoggerUtil.error("LogRepository","❌ [getLogById] Error al obtener log con ID $id: $e");
      return null;
    }
  }
}
