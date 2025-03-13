import 'package:col_moda_empresa/infraestructure/persistence/database/local_database.dart';
import 'package:col_moda_empresa/infraestructure/persistence/repositories/logger.repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:uuid/uuid.dart';

class UnitOfWork {
  static final UnitOfWork _instance = UnitOfWork._internal();

  factory UnitOfWork() => _instance;

  late final LogRepository logRepository;
  Database? _database;
  Transaction? _activeTransaction;
  String? _currentTransactionId; // 🆔 ID de transacción actual
  final Lock _lock = Lock(); // 🔒 Mutex para evitar concurrencia
  final Uuid _uuid = Uuid(); // Generador de UUID

  UnitOfWork._internal() {
    logRepository = LogRepository(this);
  }

  /// 📌 Obtiene la base de datos o la transacción activa
  Future<DatabaseExecutor> get databaseOrTransaction async {
    return _activeTransaction ?? await _getDatabase();
  }

  /// 📌 Obtiene la instancia de la base de datos con bloqueo seguro
  Future<Database> _getDatabase() async {
    return _lock.synchronized(() async {
      _database ??= await LocalDatabase().database;
      return _database!;
    });
  }

  /// 📌 Maneja transacciones con ID opcional
  Future<T> transaction<T>(Future<T> Function(String transactionId) action,
      {String? transactionId}) async {
    final db = await _getDatabase();
    final String txnId =
        transactionId ?? _uuid.v4(); // Genera un nuevo ID si no se pasa

    return await db.transaction<T>((txn) async {
      _activeTransaction = txn;
      _currentTransactionId =
          txnId; // 🆔 Almacena el ID de la transacción actual

      try {
        return await action(txnId);
      } finally {
        _activeTransaction = null;
        _currentTransactionId = null;
      }
    });
  }

  /// 📌 Obtiene el ID de la transacción actual
  String? get currentTransactionId => _currentTransactionId;
}
