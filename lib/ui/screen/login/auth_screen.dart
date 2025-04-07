import 'package:col_moda_empresa/ui/screen/login/provider/auth_provider.dart';
import 'package:col_moda_empresa/ui/screen/login/widgets/authenticated_view.dart';
import 'package:col_moda_empresa/ui/screen/login/widgets/login_view.dart';
import 'package:col_moda_empresa/ui/screen/login/widgets/register_view.dart';
import 'package:col_moda_empresa/ui/widgets/views/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const name = "login_screen";
  static const link = "/";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = context.read<AuthProvider>();
      authProvider.tokenLogin();
      authProvider.fetchDepartments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _buildAuthState(authProvider),
    );
  }

  Widget _buildAuthState(AuthProvider authProvider) {
    switch (authProvider.status) {
      case AuthStatus.uninitialized:
        return LoadingView();
      case AuthStatus.authenticating:
        return LoginView();
      case AuthStatus.registering:
        return RegisterView();
      case AuthStatus.unauthenticated:
        return Container();
      case AuthStatus.authenticated:
        return AuthenticatedView();
    }
  }
}
