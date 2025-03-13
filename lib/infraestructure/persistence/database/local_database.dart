import 'package:col_moda_empresa/shared/utilities/logger_util.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  Database? _database;

  LocalDatabase._internal();

  factory LocalDatabase() {
    return _instance;
  }

  /// ✅ Nueva función para inicializar la base de datos manualmente
  Future<void> initialize() async {
    LoggerUtil.info("LocalDatabase","🔄 [LocalDatabase] Inicializando base de datos...");
    _database = await _initDatabase();
    LoggerUtil.info("LocalDatabase","✅ [LocalDatabase] Base de datos lista");
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    try {
      _database = await _initDatabase();
      return _database!;
    } catch (e) {
      LoggerUtil.error("LogRepository","❌ Error al abrir la base de datos: $e");
      rethrow; // Propaga el error si no se puede recuperar
    }
  }

  Future<Database> _initDatabase() async {
    try {
      final path = join(await getDatabasesPath(), 'app_database.db');
      LoggerUtil.info("LocalDatabase","📌 [_initDatabase] Ruta de la base de datos: $path");

      return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          try {
            LoggerUtil.info("LocalDatabase","🟢 [_initDatabase] Creando tablas...");
            await db.execute('''
              CREATE TABLE logs (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                transaction_id TEXT,
                level TEXT,
                message TEXT,
                timestamp TEXT,
                module TEXT,
                context TEXT -- 👈 Aquí guardamos JSON como TEXT
              )
            ''');
            LoggerUtil.info("LocalDatabase","✅ [_initDatabase] Tablas creadas exitosamente");
          } catch (e) {
            LoggerUtil.error("LocalDatabase","❌ [_initDatabase] Error al crear tablas: $e");
            rethrow;
          }
        },
      );
    } catch (e) {
      LoggerUtil.error("LocalDatabase","❌ [_initDatabase] Error al inicializar la base de datos: $e");
      rethrow;
    }
  }

  /// 🚀 Borra y reinicia la base de datos (Útil en desarrollo)
  Future<void> resetDatabase() async {
    try {
      final path = join(await getDatabasesPath(), 'app_database.db');
      LoggerUtil.warning("LocalDatabase","⚠️ [resetDatabase] Eliminando base de datos en: $path");

      await deleteDatabase(path);
      _database = null; // Se borra la referencia para forzar la re-inicialización

      await initialize(); // Se vuelve a crear la base de datos desde cero

      LoggerUtil.info("LocalDatabase","✅ [resetDatabase] Base de datos reiniciada exitosamente");
    } catch (e) {
      LoggerUtil.error("LocalDatabase","❌ [resetDatabase] Error al resetear la base de datos: $e");
    }
  }
}
