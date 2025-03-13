class LogEntity {
  final int? id;
  final String transactionId;
  final String level; // INFO, WARNING, ERROR
  final String message;
  final String timestamp;
  final String module;
  final String? context; // Se guarda como texto en la BD

  LogEntity({
    this.id,
    required this.transactionId,
    required this.level,
    required this.message,
    required this.timestamp,
    required this.module,
    this.context,
  });

  /// 📌 Crea una copia del objeto con valores opcionales actualizados
  LogEntity copyWith({
    int? id,
    String? transactionId,
    String? level,
    String? message,
    String? timestamp, // 🔄 Corregido para mantener coherencia con la clase
    String? module,
    String? context,
  }) {
    return LogEntity(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      level: level ?? this.level,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp, // 🔄 Mantiene el tipo String
      module: module ?? this.module,
      context: context ?? this.context,
    );
  }

  /// 📌 Convierte un `LogEntity` a un `Map<String, dynamic>` para la BD
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_id': transactionId,
      'level': level,
      'message': message,
      'timestamp': timestamp,
      'module': module,
      'context': context, // Se guarda como String en la BD
    };
  }

  /// 📌 Crea un `LogEntity` a partir de un `Map<String, dynamic>` de la BD
  factory LogEntity.fromMap(Map<String, dynamic> map) {
    return LogEntity(
      id: map['id'],
      transactionId: map['transaction_id'] ?? 'NO_TXN',
      level: map['level'],
      message: map['message'],
      timestamp: map['timestamp'],
      module: map['module'],
      context: map['context'], // Se almacena como String en la BD
    );
  }

  /// 📌 Representación en texto para depuración
  @override
  String toString() {
    return 'LogEntity(id: $id, transactionId: $transactionId, level: $level, message: $message, timestamp: $timestamp, module: $module, context: $context)';
  }
}
