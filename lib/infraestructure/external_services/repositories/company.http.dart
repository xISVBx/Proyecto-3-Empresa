import 'package:col_moda_empresa/domain/dtos/register_company_request.dto.dart';
import 'package:col_moda_empresa/domain/dtos/register_company_response.dto.dart';
import 'package:col_moda_empresa/domain/models/api_response.dart';
import 'package:col_moda_empresa/infraestructure/external_services/configuration/dio.dart';
import 'package:col_moda_empresa/shared/utilities/http_helper.dart';
import 'package:dio/dio.dart'; // Importamos el helper

class CompanyHttp {
  final Dio _dio = DioConfig().dio;

  /// 🔹 **Petición para registrar un usuario**
  Future<ApiResponse<RegisterCompanyResponseDto>> registerCompany(
      RegisterCompanyRequestDto registerRequest) async {
    return await HttpHelper.request<RegisterCompanyResponseDto>(
      requestFunction: () => _dio.post(
        "/v1/companies",
        data: registerRequest
            .toJson(), // Convertimos el objeto a JSON para enviarlo en el body
      ),
      fromJsonT: (json) => RegisterCompanyResponseDto.fromJson(json),
    );
  }
}
