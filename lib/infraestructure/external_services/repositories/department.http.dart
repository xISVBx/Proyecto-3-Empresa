import 'package:col_moda_empresa/domain/dtos/department_request.dto.dart';
import 'package:col_moda_empresa/domain/dtos/department_response.dto.dart';
import 'package:col_moda_empresa/domain/models/api_response.dart';
import 'package:col_moda_empresa/infraestructure/external_services/configuration/dio.dart';
import 'package:col_moda_empresa/shared/utilities/http_helper.dart';
import 'package:dio/dio.dart';

class DepartmentHttp {
  final Dio _dio = DioConfig().dio;

  /// 🔹 **Obtiene ciudades con un objeto de petición**
  Future<ApiResponse<List<DepartmentResponseDto>>> getDepartments(
      DepartmentRequestDto request) async {
    return await HttpHelper.request<List<DepartmentResponseDto>>(
      requestFunction: () => _dio.get(
        "/v1/departments",
        queryParameters: request.toQueryParams(),
      ),
      fromJsonT: (json) => (json as List)
          .map((item) => DepartmentResponseDto.fromJson(item))
          .toList(), // Convertimos la lista de JSONs a una lista de objetos
    );
  }
}
