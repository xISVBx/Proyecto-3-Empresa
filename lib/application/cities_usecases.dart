import 'package:col_moda_empresa/domain/dtos/city_request.dto.dart';
import 'package:col_moda_empresa/domain/dtos/city_response.dto.dart';
import 'package:col_moda_empresa/domain/models/result.dart';
import 'package:col_moda_empresa/infraestructure/external_services/repositories/city.http.dart';
import 'package:col_moda_empresa/shared/utilities/logger_util.dart';

class CitiesUseCases {
  final CityHttp _companyHttp = CityHttp();

  /// 📌 **Registra un usuario y devuelve un `Result`**
  Future<Result<List<CityResponseDto>>> findCitiesByFilters(
      CityRequestDto cityRequest) async {
    var response = await _companyHttp.getCities(cityRequest);

    if (response.success && response.data != null) {
      LoggerUtil.info("CitiesUseCases",
          "Ciudades obtenidas exitosamente: ${response.data}");
      return Success(response.data!);
    } else {
      String errorMessage = response.errors.isNotEmpty
          ? response.errors.join(", ")
          : "Error desconocido en obtener ciudades";

      LoggerUtil.error("CitiesUseCases", errorMessage);
      return Failure(errorMessage);
    }
  }
}
