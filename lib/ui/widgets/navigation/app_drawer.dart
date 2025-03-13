import 'package:col_moda_empresa/domain/enums/storage_keys.dart';
import 'package:col_moda_empresa/shared/utilities/jwt_helper.dart';
import 'package:col_moda_empresa/shared/utilities/key_value_storage.dart';
import 'package:col_moda_empresa/ui/screen/login/auth_screen.dart';
import 'package:col_moda_empresa/ui/screen/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:col_moda_empresa/ui/config/app_colors.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String companyName = "";
  String userName = "";
  String avatarUrl = "";

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    var jwt = await KeyValueStorage.getValue<String>(StorageKey.jwtToken.key);
    if (jwt == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(AuthScreen.link);
      });
      return;
    }
    var response = JwtHelper.getUserData(jwt);
    if (response == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(AuthScreen.link);
      });
      return;
    }
    setState(() {
      companyName = response.companyName;
      userName = "${response.name} ${response.lastName}";
      avatarUrl = ""; // Si tienes avatar
    });
  }

  Future<void> _logout(BuildContext context) async {
    await KeyValueStorage.removeKey(StorageKey.jwtToken.key);
    if (context.mounted) {
      context.go(AuthScreen.link);
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    final String currentRoute = GoRouter.of(context).state.matchedLocation;
    return Drawer(
      backgroundColor: AppColors.primary,
      child: Column(
        children: [
          // ENCABEZADO CON AVATAR, EMPRESA Y USUARIO
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: AppColors.primary),
            ),
            accountName: Text(
              companyName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              userName,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.backgroundColor,
              ),
            ),
          ),

          // LISTA DE OPCIONES
          _buildDrawerItem(
            context,
            icon: Icons.home_rounded,
            text: 'Inicio',
            route: '/home',
            currentRoute: currentRoute,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.home_rounded,
            text: 'Productos',
            route: ProductsScreen.link,
            currentRoute: currentRoute,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.person_rounded,
            text: 'Perfil',
            route: '/profile',
            currentRoute: currentRoute,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.settings_rounded,
            text: 'Configuración',
            route: '/settings',
            currentRoute: currentRoute,
          ),

          Spacer(),

          // CERRAR SESIÓN (AL FINAL)
          _buildDrawerItem(
            context,
            icon: Icons.logout_rounded,
            text: 'Cerrar sesión',
            currentRoute: currentRoute,
            onTap: () => _logout(context), // 🔹 Llama a la función de logout
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    String? route,
    required String currentRoute,
    VoidCallback? onTap, // 🔹 Permite lógica personalizada (como logout)
  }) {
    final bool isSelected = currentRoute == route;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isSelected ? Colors.white : Colors.white24,
        child: Icon(
          icon,
          color: isSelected ? AppColors.primary : Colors.white70,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white70,
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.primary.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onTap: onTap ??
          () {
            if (route != null) context.go(route);
          },
    );
  }
}
