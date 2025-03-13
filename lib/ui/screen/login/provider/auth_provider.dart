import 'package:col_moda_empresa/application/cities_usecases.dart';
import 'package:col_moda_empresa/application/companies_usecases.dart';
import 'package:col_moda_empresa/application/departments_usecases.dart';
import 'package:col_moda_empresa/application/users_usecases.dart';
import 'package:col_moda_empresa/domain/dtos/city_request.dto.dart';
import 'package:col_moda_empresa/domain/dtos/city_response.dto.dart';
import 'package:col_moda_empresa/domain/dtos/department_request.dto.dart';
import 'package:col_moda_empresa/domain/dtos/department_response.dto.dart';
import 'package:col_moda_empresa/domain/dtos/login_request.dto.dart';
import 'package:col_moda_empresa/domain/dtos/register_company_request.dto.dart';
import 'package:col_moda_empresa/domain/dtos/register_company_response.dto.dart';
import 'package:col_moda_empresa/domain/enums/storage_keys.dart';
import 'package:col_moda_empresa/domain/models/result.dart';
import 'package:col_moda_empresa/shared/utilities/jwt_helper.dart';
import 'package:col_moda_empresa/shared/utilities/key_value_storage.dart';
import 'package:col_moda_empresa/shared/utilities/logger_util.dart';
import 'package:col_moda_empresa/shared/utilities/snack.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum AuthStatus {
  uninitialized, // Estado inicial antes de comprobar autenticación
  authenticated, // Usuario autenticado
  unauthenticated, // Usuario no autenticado
  authenticating, // En proceso de autenticación
  registering, // En proceso de registro
}

class AuthProvider with ChangeNotifier {
  final CitiesUseCases _citiesUseCases = CitiesUseCases();
  final DepartmentsUseCases _departmentsUseCases = DepartmentsUseCases();
  final UsersUseCases _usersUseCases = UsersUseCases();
  final CompaniesUseCases _companiesUseCases = CompaniesUseCases();
  final Map<String, String?> errors = {}; // Almacena los errores

  List<CityResponseDto> _cities = List<CityResponseDto>.empty();
  List<CityResponseDto> get cities => _cities;
  bool _citiesSuccess = true;

  CityResponseDto? _city;
  CityResponseDto? get city => _city;

  List<DepartmentResponseDto> _departments =
      List<DepartmentResponseDto>.empty();
  List<DepartmentResponseDto> get departments => _departments;
  bool _departmentsSuccess = true;

  DepartmentResponseDto? _department;
  DepartmentResponseDto? get department => _department;

  final TextEditingController logEmail = TextEditingController();
  final FocusNode logEmailFocus = FocusNode();
  final TextEditingController logPassword = TextEditingController();
  final FocusNode logPasswordFocus = FocusNode();

  final TextEditingController regName = TextEditingController();
  final FocusNode regNameFocus = FocusNode();
  final TextEditingController regLastName = TextEditingController();
  final FocusNode regLastNameFocus = FocusNode();
  final TextEditingController regCompanyName = TextEditingController();
  final FocusNode regCompanyNameFocus = FocusNode();
  final TextEditingController regAddress = TextEditingController();
  final FocusNode regAddressFocus = FocusNode();
  final TextEditingController regPhone = TextEditingController();
  final FocusNode regPhoneFocus = FocusNode();
  final TextEditingController regEmail = TextEditingController();
  final FocusNode regEmailFocus = FocusNode();
  final TextEditingController regPassword = TextEditingController();
  final FocusNode regPasswordFocus = FocusNode();

  final FocusNode regCityFocus = FocusNode();
  final FocusNode regDepartmentFocus = FocusNode();

  AuthStatus _status = AuthStatus.uninitialized;
  AuthStatus get status => _status;
  set status(AuthStatus newStatus) {
    _status = newStatus;
    notifyListeners(); // Si usas Provider, esto notificará los cambios a la UI
  }

  String? _userToken;
  String? get userToken => _userToken;

  Future<void> tokenLogin() async {
    var token = await KeyValueStorage.getValue<String>(StorageKey.jwtToken.key);
    if (token == null) {
      _status = AuthStatus.authenticating;
      notifyListeners();
      return;
    }
    var user = JwtHelper.getUserData(token);
    if (user == null) {
      _status = AuthStatus.authenticating;
      notifyListeners();
      return;
    }
    if (user.role != "Company") {
      _status = AuthStatus.authenticating;
      notifyListeners();
      return;
    }
    _status = AuthStatus.authenticated;
    Snack.success(text: "Bienvenido ${user.name} ${user.lastName}");
  }

  Future<void> refreshDepartments() async {
    if (_departmentsSuccess) return;
    await fetchDepartments();
  }

  Future<void> refreshCities() async {
    if (_citiesSuccess) return;
    await fetchCities();
  }

  Future<void> fetchDepartments() async {
    var request = DepartmentRequestDto();
    var departments =
        await _departmentsUseCases.findDepartmentsByFilters(request);
    if (departments is Success<List<DepartmentResponseDto>>) {
      _departments = departments.data;
      _departmentsSuccess = true;
    } else {
      _departmentsSuccess = false;
    }
    notifyListeners();
  }

  Future<void> fetchCities() async {
    if (_department == null) {
      Snack.warning(text: "Selecciona un  departamento primero");
      return;
    }
    var requestCity = CityRequestDto(departmentId: _department?.id);

    var cities = await _citiesUseCases.findCitiesByFilters(requestCity);
    if (cities is Success<List<CityResponseDto>>) {
      _cities = cities.data;
      _citiesSuccess = true;
    } else {
      _citiesSuccess = false;
    }
    notifyListeners();
  }

  Future<void> selectDepartment(DepartmentResponseDto department) async {
    _department = department as DepartmentResponseDto?;
    _city = null;
    await fetchCities();
  }

  void selectCity(CityResponseDto cityResponse) {
    _city = cityResponse;
    notifyListeners();
  }

  Future<void> login() async {
    if (!validateLoginFields()) {
      return;
    }
    var loginRequestDto =
        LoginRequestDto(email: logEmail.text, password: logPassword.text);
    var response = await _usersUseCases.login(loginRequestDto);
    if (response is Success<String>) {
      Snack.success(text: "Bienvenido");
      _status = AuthStatus.authenticated;
      notifyListeners();
      return;
    } else if (response is Failure) {
      Snack.warning(text: (response as Failure).message);
      return;
    }
  }

  Future<void> register() async {
    if (!validateRegisterFields()) {
      return;
    }

    var registerRequest = RegisterCompanyRequestDto(
        address: regAddress.text,
        cityId: _city!.id,
        companyName: regCompanyName.text,
        description: '',
        email: regEmail.text,
        lastName: regLastName.text,
        name: regName.text,
        password: regPassword.text,
        phone: regPhone.text);

    var response = await _companiesUseCases.registerCompany(registerRequest);
    if (response is Success<RegisterCompanyResponseDto>) {
      LoggerUtil.info("AuthProvider", response.data.toString());
      Snack.success(
          text:
              "${response.data.name} has registrado con exito la compania ${response.data.companyName}",
          duration: Toast.LENGTH_LONG);
    } else if (response is Failure) {
      Snack.warning(text: (response as Failure).message);
    }
  }

  bool validateLoginFields() {
    errors.clear();

    if (logEmail.text.isEmpty || !logEmail.text.contains('@')) {
      errors['logEmail'] = "Debes colocar un email valido";
    }
    if (logPassword.text.isEmpty || logPassword.text.length < 8) {
      errors['logPassword'] =
          "La contrasenia debe tener almenos unos 8 digitos";
    }
    notifyListeners();
    return errors.isEmpty;
  }

  bool validateRegisterFields() {
    errors.clear(); // Limpiamos errores previos

    if (regName.text.isEmpty) {
      errors['regName'] = "El nombre es obligatorio";
    }
    if (regLastName.text.isEmpty) {
      errors['regLastName'] = "El apellido es obligatorio";
    }
    if (regCompanyName.text.isEmpty) {
      errors['regCompanyName'] = "El nombre de la empresa es obligatorio";
    }
    if (_department == null) {
      errors['department'] = "Debes seleccionar un departamento";
    }
    if (_city == null) {
      errors['city'] = "Debes seleccionar una ciudad";
    }
    if (regAddress.text.isEmpty) {
      errors['regAddress'] = "La dirección es obligatoria";
    }
    if (regPhone.text.isEmpty) {
      errors['regPhone'] = "El teléfono es obligatorio";
    }
    if (regEmail.text.isEmpty || !regEmail.text.contains('@')) {
      errors['regEmail'] = "Correo inválido";
    }
    if (regPassword.text.isEmpty || regPassword.text.length < 6) {
      errors['regPassword'] = "La contraseña debe tener al menos 6 caracteres";
    }

    notifyListeners();
    return errors.isEmpty;
  }
}
