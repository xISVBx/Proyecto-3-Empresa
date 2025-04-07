import 'package:col_moda_empresa/domain/dtos/login_request.dto.dart';
import 'package:col_moda_empresa/domain/dtos/register_request.dto.dart';
import 'package:col_moda_empresa/domain/dtos/register_response.dart';
import 'package:col_moda_empresa/domain/enums/storage_keys.dart';
import 'package:col_moda_empresa/domain/models/result.dart';
import 'package:col_moda_empresa/infraestructure/external_services/repositories/user.http.dart';
import 'package:col_moda_empresa/shared/utilities/key_value_storage.dart';
import 'package:col_moda_empresa/shared/utilities/logger_util.dart';
import 'package:col_moda_empresa/shared/utilities/snack.dart';

class UsersUseCases {
  final UserHttp _userHttp = UserHttp();

  /// 📌 **Registra un usuario y devuelve un `Result`**
  Future<Result<RegisterResponse>> register(
      RegisterRequest registerRequest) async {
    var response = await _userHttp.register(registerRequest);

    if (response.success && response.data != null) {
      LoggerUtil.info(
          "UsersUseCases", "Usuario registrado exitosamente: ${response.data}");
      return Success(response.data!);
    } else {
      String errorMessage = response.errors.isNotEmpty
          ? response.errors.join(", ")
          : "Error desconocido en el registro";

      LoggerUtil.error("UsersUseCases", errorMessage);
      return Failure(errorMessage);
    }
  }

  Future<Result<String>> login(LoginRequestDto loginRequestDto) async {
    var response = await _userHttp.login(loginRequestDto);
    if (response.success &&
        response.data != null &&
        response.data!.isNotEmpty) {
      LoggerUtil.info("UsersUseCases", "Usuario logueado exitosamente");
      await KeyValueStorage.setKeyValue<String>(
          StorageKey.jwtToken.key, response.data!);
      return Success(response.data!);
    } else {
      String errorMessage = response.errors.isNotEmpty
          ? response.errors.join(", ")
          : "Error desconocido en el registro";

      LoggerUtil.error("UsersUseCases", errorMessage);
      return Failure(errorMessage);
    }
  }
}
