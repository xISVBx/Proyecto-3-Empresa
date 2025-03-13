class RegisterRequest {
  String address;
  int cityId;
  String email;
  String lastName;
  String name;
  String password;
  String phone;

  RegisterRequest({
    required this.address,
    required this.cityId,
    required this.email,
    required this.lastName,
    required this.name,
    required this.password,
    required this.phone,
  });

  // Constructor para crear una instancia desde un mapa (JSON)
  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      address: json['address'] as String,
      cityId: json['city_id'] as int,
      email: json['email'] as String,
      lastName: json['last_name'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
    );
  }

  // Método para convertir una instancia en un mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city_id': cityId,
      'email': email,
      'last_name': lastName,
      'name': name,
      'password': password,
      'phone': phone,
    };
  }
}
