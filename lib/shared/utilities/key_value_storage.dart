import 'package:col_moda_empresa/shared/utilities/logger_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorage {
  static Future<SharedPreferences> get _prefs async =>
      SharedPreferences.getInstance();

  static Future<T?> getValue<T>(String key) async {
    final prefs = await _prefs;
    final Object? value = prefs.get(key); // Se obtiene como Object?

    if (value is T) {
      return value; // Solo retorna si coincide con el tipo esperado
    } else if (value != null) {
      await LoggerUtil.warningWithSave("KeyValueStorage", "El valor almacenado para '$key' no es del tipo esperado: ${T.toString()}");
      throw Exception(
          "El valor almacenado para '$key' no es del tipo esperado: ${T.toString()}");
    }
    return null; // Retorna null si la clave no existe o el valor es null
  }

  static Future<bool> removeKey(String key) async {
    final prefs = await _prefs;
    return prefs.remove(key);
  }

  static Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await _prefs;

    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      await LoggerUtil.warningWithSave("KeyValueStorage", 'Tipo no soportado: ${T.toString()}');
      throw UnimplementedError('Tipo no soportado: ${T.toString()}');
    }
  }
}
