import 'package:col_moda_empresa/domain/models/api_response.dart';
import 'package:col_moda_empresa/shared/utilities/logger_util.dart';
import 'package:dio/dio.dart';

class HttpHelper {

  /// ✅ **Método genérico para manejar peticiones HTTP**
  static Future<ApiResponse<T>> request<T>({
    required Future<Response> Function() requestFunction,
    required T Function(dynamic) fromJsonT,
  }) async {
    try {
      final response = await requestFunction();
      return _parseResponse<T>(response, fromJsonT);
    } on DioException catch (dioError, stacktrace) {
      return _handleDioError<T>(dioError, stacktrace, fromJsonT);
    } catch (e, stacktrace) {
      return _handleUnexpectedError<T>(e, stacktrace);
    }
  }

  /// ✅ **Parsea la respuesta de la API**
  static ApiResponse<T> _parseResponse<T>(Response response, T Function(dynamic) fromJsonT) {
    return ApiResponse<T>.fromJson(response.data, fromJsonT);
  }

  /// ✅ **Maneja errores de `DioException`**
  static ApiResponse<T> _handleDioError<T>(DioException dioError, StackTrace stacktrace, T Function(dynamic) fromJsonT) {
    if (dioError.response != null && dioError.response?.data != null) {
      try {
        return _parseResponse<T>(dioError.response!, fromJsonT);
      } catch (_) {
        LoggerUtil.error("HttpHelper", "Error parseando ApiResponse desde error HTTP: ${dioError.response!.statusCode}\n$stacktrace");
      }
    }

    LoggerUtil.error("HttpHelper", "HTTP Error: ${dioError.response?.statusCode ?? 'Desconocido'} - ${dioError.message}\n$stacktrace");

    return ApiResponse<T>(
      success: false,
      data: null,
      errors: [
        "Error HTTP: ${dioError.response?.statusCode ?? 'Desconocido'}",
        dioError.message ?? "Error desconocido",
      ],
    );
  }

  /// ✅ **Maneja errores inesperados**
  static ApiResponse<T> _handleUnexpectedError<T>(Object e, StackTrace stacktrace) {
    LoggerUtil.error("HttpHelper", "Error inesperado: $e\n$stacktrace");
    return ApiResponse<T>(
      success: false,
      data: null,
      errors: ["Error desconocido: $e"],
    );
  }
}
