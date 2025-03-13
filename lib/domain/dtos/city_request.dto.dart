class CityRequestDto {
  final int? departmentId;
  final String? cityName;
  final int? cityId;

  CityRequestDto({this.departmentId, this.cityName, this.cityId});

  /// 📌 Convierte el DTO a un `Map<String, dynamic>` sin valores nulos
  Map<String, dynamic> toQueryParams() {
    return {
      if (departmentId != null) 'department_id': departmentId,
      if (cityName != null) 'city_name': cityName,
      if (cityId != null) 'city_id': cityId,
    };
  }
}
