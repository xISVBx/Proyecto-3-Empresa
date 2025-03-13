class RegisterResponse {
  final String id;
  final String name;
  final String lastName;
  final String email;

  RegisterResponse({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
