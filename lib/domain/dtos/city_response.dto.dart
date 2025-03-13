class CityResponseDto {
  final int id;
  final int departmentId;
  final String cityName;

  CityResponseDto(
      {required this.id, required this.cityName, required this.departmentId});

  // Método para convertir un JSON a un objeto Region
  factory CityResponseDto.fromJson(Map<String, dynamic> json) {
    return CityResponseDto(
        id: json['id'],
        cityName: json['city_name'],
        departmentId: json['department_id']);
  }

  // Método para convertir un objeto Region a JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'city_name': cityName, 'department_id': departmentId};
  }

  @override
  String toString() =>
      'DepartmentResponseDto(id: $id, city_name: $cityName, department_id:$departmentId )';
}
