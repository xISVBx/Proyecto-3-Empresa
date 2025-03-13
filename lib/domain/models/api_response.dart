import 'dart:convert';

class ApiResponse<T> {
  final bool success;
  final T? data;
  final List<String> errors;

  ApiResponse({
    required this.success,
    this.data,
    this.errors = const [],
  });

  /// 🔹 **Factory para crear una instancia desde JSON**
  factory ApiResponse.fromJson(
    Map<String, dynamic> json, 
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool,
      data: fromJsonT != null && json['data'] != null ? fromJsonT(json['data']) : null,
      errors: List<String>.from(json['errors'] ?? []),
    );
  }

  /// 🔹 **Convierte la respuesta a JSON**
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data,
      'errors': errors,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
