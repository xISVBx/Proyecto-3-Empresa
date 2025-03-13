import 'package:col_moda_empresa/domain/dtos/register_company_request.dto.dart';
import 'package:col_moda_empresa/domain/dtos/register_company_response.dto.dart';
import 'package:col_moda_empresa/domain/models/result.dart';
import 'package:col_moda_empresa/infraestructure/external_services/repositories/company.http.dart';
import 'package:col_moda_empresa/shared/utilities/logger_util.dart';

class CompaniesUseCases {
  final CompanyHttp _companyHttp = CompanyHttp();

  /// 📌 **Registra un usuario y devuelve un `Result`**
  Future<Result<RegisterCompanyResponseDto>> registerCompany(RegisterCompanyRequestDto registerRequest) async {
    var response = await _companyHttp.registerCompany(registerRequest);

    if (response.success && response.data != null) {
      LoggerUtil.info("CompanyUseCases", "Compania registrado exitosamente: ${response.data}");
      return Success(response.data!);
    } else {
      String errorMessage = response.errors.isNotEmpty
          ? response.errors.join(", ")
          : "Error desconocido en el registro";

      LoggerUtil.error("CompanyUseCases", errorMessage);
      return Failure(errorMessage);
    }
  }
}
