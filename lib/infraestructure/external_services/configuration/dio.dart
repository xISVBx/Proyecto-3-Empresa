import 'package:col_moda_empresa/shared/utilities/logger_util.dart';
import 'package:dio/dio.dart';

class DioConfig {
  static final DioConfig _instance = DioConfig._internal();
  late final Dio _dio;
  String? _baseUrl;

  DioConfig._internal() {
    _dio = Dio();
  }

  factory DioConfig() {
    return _instance;
  }

  /// 🔄 Inicializa la baseUrl desde la BD
  Future<void> initialize() async {
    _baseUrl = "https://api.colmoda.com";
    _updateBaseUrl();
  }

  /// 🔄 Método para actualizar la baseUrl en tiempo real
  Future<void> refreshBaseUrl() async {
    _baseUrl = "http://localhost:3031/api";
    _updateBaseUrl();
  }

  /// Aplica la baseUrl al objeto Dio
  void _updateBaseUrl() {
    if (_baseUrl != null) {
      _dio.options.baseUrl = _baseUrl!;
      LoggerUtil.info("DioConfig","✅ Base URL actualizada: $_baseUrl");
    } else {
      LoggerUtil.warning("DioConfig","⚠️ No hay una Base URL válida.");
    }
  }

  Dio get dio => _dio;
}
