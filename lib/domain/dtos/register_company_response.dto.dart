import 'package:col_moda_empresa/shared/utilities/logger_util.dart';
import 'package:logger/logger.dart';

class RegisterCompanyResponseDto {
  final String companyID;
  final String companyName;
  final String email;
  final String name;
  final String userID;

  RegisterCompanyResponseDto({
    required this.companyID,
    required this.companyName,
    required this.email,
    required this.name,
    required this.userID,
  });

  // Constructor para crear una instancia desde un JSON
  factory RegisterCompanyResponseDto.fromJson(Map<String, dynamic> json) {
    return RegisterCompanyResponseDto(
      companyID: json['company_id'] ?? '',
      companyName: json['company_name'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      userID: json['user_id'] ?? '',
    );
  }

  // Método para convertir la instancia en un JSON
  Map<String, dynamic> toJson() {
    return {
      'companyID': companyID,
      'companyName': companyName,
      'email': email,
      'name': name,
      'userID': userID,
    };
  }

  // toString mejorado para debug
  @override
  String toString() {
    return '''
    📌 RegisterCompanyResponseDto {
      🏢 Company ID   : $companyID
      🏛️ Company Name : $companyName
      📧 Email        : $email
      👤 Name         : $name
      🆔 User ID      : $userID
    }
    ''';
  }
}
