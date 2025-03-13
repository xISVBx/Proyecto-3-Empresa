class DepartmentRequestDto {
  final int? departmentId;
  final String? departmentName;

  DepartmentRequestDto({this.departmentId, this.departmentName});

  /// 📌 Convierte el DTO a un `Map<String, dynamic>` sin valores nulos
  Map<String, dynamic> toQueryParams() {
    return {
      if (departmentId != null) 'department_id': departmentId,
      if (departmentName != null) 'department_name': departmentName,
    };
  }
}
