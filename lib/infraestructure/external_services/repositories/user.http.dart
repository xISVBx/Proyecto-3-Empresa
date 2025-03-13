import 'package:col_moda_empresa/domain/dtos/login_request.dto.dart';
import 'package:col_moda_empresa/domain/dtos/register_request.dto.dart';
import 'package:col_moda_empresa/domain/dtos/register_response.dart';
import 'package:col_moda_empresa/domain/models/api_response.dart';
import 'package:col_moda_empresa/infraestructure/external_services/configuration/dio.dart';
import 'package:col_moda_empresa/shared/utilities/http_helper.dart';
import 'package:dio/dio.dart'; // Importamos el helper

class UserHttp {
  final Dio _dio = DioConfig().dio;

  /// 🔹 **Petición para registrar un usuario**
  Future<ApiResponse<RegisterResponse>> register(
      RegisterRequest registerRequest) async {
    return await HttpHelper.request<RegisterResponse>(
      requestFunction: () => _dio.post(
        "/v1/register",
        data: registerRequest
            .toJson(), // Convertimos el objeto a JSON para enviarlo en el body
      ),
      fromJsonT: (json) => RegisterResponse.fromJson(json),
    );
  }

  Future<ApiResponse<String>> login(LoginRequestDto loginRequestDto) async {
    return await HttpHelper.request(
        requestFunction: () =>
            _dio.post("/v1/login", data: loginRequestDto.toJson()),
        fromJsonT: (json) => json as String);
  }
}
