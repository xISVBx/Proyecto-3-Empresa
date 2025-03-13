import 'package:col_moda_empresa/ui/config/app_colors.dart';
import 'package:col_moda_empresa/ui/widgets/navigation/app_drawer.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  static const name = "products_screen";
  static const link = "/products";
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu_rounded,
                  color: AppColors.primary,
                  size: 30), // Ícono más grueso
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        child: Center(
          child: Text('Products Screen'),
        ),
      ),
    );
  }
}
