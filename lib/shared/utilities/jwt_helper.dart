import 'package:col_moda_empresa/domain/dtos/user_company_response.dto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtHelper {
  static const String _secretKey = 'mysecretkey'; // Reemplázala con la clave real

  /// Decodifica y valida el JWT
  static JWT? _decodeAndValidate(String token) {
    try {
      return JWT.verify(token, SecretKey(_secretKey));
    } catch (e) {
      print('❌ Token inválido o expirado: $e');
      return null;
    }
  }

  /// Obtiene los datos del usuario como `UserCompanyResponseDto`
  static UserCompanyResponseDto? getUserData(String token) {
    final jwt = _decodeAndValidate(token);
    if (jwt == null) return null;

    return UserCompanyResponseDto.fromMap(jwt.payload);
  }
}
