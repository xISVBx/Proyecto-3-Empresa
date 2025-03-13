import 'package:col_moda_empresa/domain/dtos/city_request.dto.dart';
import 'package:col_moda_empresa/domain/dtos/city_response.dto.dart';
import 'package:col_moda_empresa/domain/models/api_response.dart';
import 'package:col_moda_empresa/infraestructure/external_services/configuration/dio.dart';
import 'package:col_moda_empresa/shared/utilities/http_helper.dart';
import 'package:dio/dio.dart';

class CityHttp {
  final Dio _dio = DioConfig().dio;

  /// 🔹 **Obtiene ciudades con un objeto de petición**
  Future<ApiResponse<List<CityResponseDto>>> getCities(
      CityRequestDto request) async {
    return await HttpHelper.request<List<CityResponseDto>>(
      requestFunction: () => _dio.get(
        "/v1/cities",
        queryParameters:
            request.toQueryParams(), // Convertimos el DTO a parámetros
      ),
      fromJsonT: (json) => (json as List)
          .map((item) => CityResponseDto.fromJson(item))
          .toList(), // No transformamos la respuesta, solo la devolvemos
    );
  }
}
