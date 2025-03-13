import 'package:col_moda_empresa/ui/screen/login/auth_screen.dart';
import 'package:col_moda_empresa/ui/screen/login/provider/auth_provider.dart';
import 'package:col_moda_empresa/ui/screen/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
    initialLocation: AuthScreen.link,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: AuthScreen.link,
        name: AuthScreen.name,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          child: AuthScreen(),
        ),
      ),
      GoRoute(
        path: ProductsScreen.link,
        name: ProductsScreen.name,
        builder: (context, state) => const ProductsScreen(),
      ),
    ]);
