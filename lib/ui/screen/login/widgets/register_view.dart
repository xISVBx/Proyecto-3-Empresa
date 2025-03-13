import 'package:col_moda_empresa/domain/dtos/city_response.dto.dart';
import 'package:col_moda_empresa/domain/dtos/department_response.dto.dart';
import 'package:col_moda_empresa/ui/config/app_colors.dart';
import 'package:col_moda_empresa/ui/screen/login/provider/auth_provider.dart';
import 'package:col_moda_empresa/ui/widgets/inputs/custome_dropdown.dart';
import 'package:col_moda_empresa/ui/widgets/inputs/custome_textfield.dart';
import 'package:col_moda_empresa/ui/widgets/buttons/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(20),
      color: AppColors.primary,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Registrate",
                style: TextStyle(
                    color: AppColors.backgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: "Nombre",
                      icon: Icons.person_2_rounded,
                      controller: authProvider.regName,
                      focusNode: authProvider.regNameFocus,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(authProvider.regLastNameFocus),
                      hasShadow: false,
                      style: CustomTextFieldStyle.outlined,
                      errorText: authProvider.errors['regName'],
                    ),
                    CustomTextField(
                      hintText: "Apellido",
                      icon: Icons.person_2_rounded,
                      controller: authProvider.regLastName,
                      focusNode: authProvider.regLastNameFocus,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(authProvider.regCompanyNameFocus),
                      hasShadow: false,
                      style: CustomTextFieldStyle.outlined,
                      errorText: authProvider.errors['regLastName'],
                    ),
                    CustomTextField(
                      hintText: "Nombre de la empresa",
                      icon: Icons.business_rounded,
                      controller: authProvider.regCompanyName,
                      focusNode: authProvider.regCompanyNameFocus,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(authProvider.regDepartmentFocus),
                      hasShadow: false,
                      style: CustomTextFieldStyle.outlined,
                      errorText: authProvider.errors['regCompanyName'],
                    ),
                    CustomDropdown(
                      hint: "Selecciona un departamento",
                      icon: Icons.location_city_outlined,
                      focusNode: authProvider.regDepartmentFocus,
                      items: authProvider.departments
                          .map((items) => DropdownItem<DepartmentResponseDto>(
                              label: items.name, value: items))
                          .toList(),
                      hasShadow: false,
                      menuMaxHeight: 400,
                      value: authProvider.department,
                      errorText: authProvider.errors["department"],
                      onTap: authProvider.fetchDepartments,
                      onChanged: (DepartmentResponseDto? department) async {
                        if (department == null) return;
                        await authProvider.selectDepartment(department);
                      },
                    ),
                    CustomDropdown(
                      hint: "Selecciona una ciudad",
                      icon: Icons.location_city_outlined,
                      items: authProvider.cities
                          .map((items) => DropdownItem<CityResponseDto>(
                              label: items.cityName, value: items))
                          .toList(),
                      hasShadow: false,
                      menuMaxHeight: 400,
                      value: authProvider.city,
                      errorText: authProvider.errors['city'],
                      onTap: authProvider.fetchCities,
                      onChanged: (CityResponseDto? city) {
                        if (city == null) return;
                        FocusScope.of(context)
                            .requestFocus(authProvider.regAddressFocus);
                        authProvider.selectCity(city);
                      },
                    ),
                    CustomTextField(
                      hintText: "Dirección",
                      icon: Icons.directions,
                      hasShadow: false,
                      controller: authProvider.regAddress,
                      errorText: authProvider.errors['regAddress'],
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(authProvider.regPhoneFocus),
                      focusNode: authProvider.regAddressFocus,
                      style: CustomTextFieldStyle.outlined,
                    ),
                    CustomTextField(
                      hintText: "Teléfono",
                      icon: Icons.phone_android_rounded,
                      hasShadow: false,
                      controller: authProvider.regPhone,
                      errorText: authProvider.errors['regPhone'],
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(authProvider.regEmailFocus),
                      focusNode: authProvider.regPhoneFocus,
                      style: CustomTextFieldStyle.outlined,
                    ),
                    CustomTextField(
                      hintText: "Email",
                      icon: Icons.email,
                      controller: authProvider.regEmail,
                      errorText: authProvider.errors['regEmail'],
                      focusNode: authProvider.regEmailFocus,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(authProvider.regPasswordFocus),
                      hasShadow: false,
                      keyboardType: TextInputType.emailAddress,
                      style: CustomTextFieldStyle.outlined,
                    ),
                    CustomTextField(
                      hintText: "Contraseña",
                      icon: Icons.lock,
                      controller: authProvider.regPassword,
                      errorText: authProvider.errors['regPassword'],
                      focusNode: authProvider.regPasswordFocus,
                      hasShadow: false,
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      style: CustomTextFieldStyle.outlined,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              LoadingButton(
                onPressed: () async {
                  await authProvider.register();
                },
                backgroundColor: AppColors.secondary,
                text: "Registrarse",
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Ya tienes una cuenta?',
                    style: TextStyle(
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      authProvider.status = AuthStatus.authenticating;
                    },
                    child: const Text(
                      "Inicia Sesión",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
