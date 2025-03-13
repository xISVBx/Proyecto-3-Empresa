class LoginRequestDto {
  final String email;
  final String password;

  LoginRequestDto({required this.email, required this.password});

  // Método para convertir un JSON en una instancia de UserCredentials
  factory LoginRequestDto.fromJson(Map<String, dynamic> json) {
    return LoginRequestDto(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  // Método para convertir una instancia de UserCredentials en un JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
