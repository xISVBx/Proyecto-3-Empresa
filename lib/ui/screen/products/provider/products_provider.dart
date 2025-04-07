import 'package:flutter/material.dart';

enum ProductsStatus {
  uninitialized, // Estado inicial antes de comprobar autenticación
  authenticated, // Usuario autenticado
  unauthenticated, // Usuario no autenticado
  authenticating, // En proceso de autenticación
  registering, // En proceso de registro
}

class ProductsProvider with ChangeNotifier {
  
}
