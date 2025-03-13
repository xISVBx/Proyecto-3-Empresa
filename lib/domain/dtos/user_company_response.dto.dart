class UserCompanyResponseDto {
  final String companyId;
  final String companyName;
  final String email;
  final int exp;
  final String id;
  final String lastName;
  final String name;
  final String phone;
  final String role;
  final String roleId;

  UserCompanyResponseDto({
    required this.companyId,
    required this.companyName,
    required this.email,
    required this.exp,
    required this.id,
    required this.lastName,
    required this.name,
    required this.phone,
    required this.role,
    required this.roleId,
  });

  /// Crea una instancia desde un `Map<String, dynamic>`
  factory UserCompanyResponseDto.fromMap(Map<String, dynamic> map) {
    return UserCompanyResponseDto(
      companyId: map["company_id"],
      companyName: map["company_name"],
      email: map["email"],
      exp: map["exp"],
      id: map["id"],
      lastName: map["last_name"],
      name: map["name"],
      phone: map["phone"],
      role: map["role"],
      roleId: map["role_id"],
    );
  }

  /// Convierte la instancia a un `Map<String, dynamic>`
  Map<String, dynamic> toMap() {
    return {
      "company_id": companyId,
      "company_name": companyName,
      "email": email,
      "exp": exp,
      "id": id,
      "last_name": lastName,
      "name": name,
      "phone": phone,
      "role": role,
      "role_id": roleId,
    };
  }
}
