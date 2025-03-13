import 'package:col_moda_empresa/domain/dtos/department_request.dto.dart';
import 'package:col_moda_empresa/domain/dtos/department_response.dto.dart';
import 'package:col_moda_empresa/domain/models/result.dart';
import 'package:col_moda_empresa/infraestructure/external_services/repositories/department.http.dart';
import 'package:col_moda_empresa/shared/utilities/logger_util.dart';

class DepartmentsUseCases {
  final DepartmentHttp _companyHttp = DepartmentHttp();

  /// 📌 **Registra un usuario y devuelve un `Result`**
  Future<Result<List<DepartmentResponseDto>>> findDepartmentsByFilters(
      DepartmentRequestDto departmentRequest) async {
    var response = await _companyHttp.getDepartments(departmentRequest);

    if (response.success && response.data != null) {
      LoggerUtil.info("DepartmentsUseCases",
          "Departmanetos obtenidos exitosamente: ${response.data}");
      return Success(response.data!);
    } else {
      String errorMessage = response.errors.isNotEmpty
          ? response.errors.join(", ")
          : "Error desconocido en obtener ciudades";

      LoggerUtil.error("DepartmentsUseCases", errorMessage);
      return Failure(errorMessage);
    }
  }
}
