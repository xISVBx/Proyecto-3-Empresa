import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:col_moda_empresa/ui/config/app_colors.dart';
import 'package:col_moda_empresa/ui/widgets/inputs/custome_textfield.dart';
import 'package:col_moda_empresa/ui/widgets/buttons/loading_button.dart';
import 'package:col_moda_empresa/ui/screen/login/provider/auth_provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Container(
      padding: const EdgeInsets.all(20),
      height: double.infinity,
      color: AppColors.primary,
      child: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                  child: Image.asset('assets/images/logo_Colmoda.png'),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Bienvenidos",
                  style: TextStyle(
                      fontSize: 24,
                      color: AppColors.backgroundColor,
                      fontWeight: FontWeight.bold),
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
                        hintText: "Email",
                        icon: Icons.email,
                        controller: authProvider.logEmail,
                        focusNode: authProvider.logEmailFocus,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(authProvider.logPasswordFocus),
                        hasShadow: false,
                        keyboardType: TextInputType.emailAddress,
                        style: CustomTextFieldStyle.outlined,
                        errorText: authProvider.errors['logEmail'],
                      ),
                      CustomTextField(
                        hintText: "Contraseña",
                        icon: Icons.lock,
                        controller: authProvider.logPassword,
                        focusNode: authProvider.logPasswordFocus,
                        hasShadow: false,
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        style: CustomTextFieldStyle.outlined,
                        errorText: authProvider.errors['logPassword'],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                LoadingButton(
                  onPressed: () async {
                    await authProvider.login();
                  },
                  backgroundColor: AppColors.secondary,
                  text: "Iniciar Sesion",
                ),
                const SizedBox(height: 10),
                const Text(
                  "Olvidaste tu contrasenia?",
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'No tienes una cuenta?',
                      style: TextStyle(
                          color: AppColors.backgroundColor,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        authProvider.status = AuthStatus.registering;
                      },
                      child: const Text(
                        "Registrate",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
