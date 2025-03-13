class DepartmentResponseDto {
  final int id;
  final String name;

  DepartmentResponseDto({required this.id, required this.name});

  // Método para convertir un JSON a un objeto Region
  factory DepartmentResponseDto.fromJson(Map<String, dynamic> json) {
    return DepartmentResponseDto(
      id: json['id'],
      name: json['name'],
    );
  }

  // Método para convertir un objeto Region a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() => 'DepartmentResponseDto(id: $id, name: $name)';
}
