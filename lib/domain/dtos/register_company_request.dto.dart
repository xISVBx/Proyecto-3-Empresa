class RegisterCompanyRequestDto {
  final String address;
  final int cityId;
  final String companyName;
  final String description;
  final String email;
  final String lastName;
  final String name;
  final String password;
  final String phone;

  RegisterCompanyRequestDto({
    required this.address,
    required this.cityId,
    required this.companyName,
    required this.description,
    required this.email,
    required this.lastName,
    required this.name,
    required this.password,
    required this.phone,
  });

  // Convertir JSON a objeto Dart
  factory RegisterCompanyRequestDto.fromJson(Map<String, dynamic> json) {
    return RegisterCompanyRequestDto(
      address: json["address"],
      cityId: json["city_id"],
      companyName: json["company_name"],
      description: json["description"],
      email: json["email"],
      lastName: json["last_name"],
      name: json["name"],
      password: json["password"],
      phone: json["phone"],
    );
  }

  // Convertir objeto Dart a JSON
  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "city_id": cityId,
      "company_name": companyName,
      "description": description,
      "email": email,
      "last_name": lastName,
      "name": name,
      "password": password,
      "phone": phone,
    };
  }
}
