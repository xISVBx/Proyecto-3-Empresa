import 'package:col_moda_empresa/ui/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final double maxSize =
        MediaQuery.of(context).size.width * 0.6; // 60% del ancho de la pantalla

    return Container(
      color: AppColors.primary,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Pulse(
              duration: const Duration(milliseconds: 2000), // Más rápido
              infinite: true, // Se repite infinitamente
              from: 0.9, // Tamaño inicial reducido
              to: 1,
              child: Image.asset(
                'assets/images/logo_Colmoda.png',
                width: maxSize, // Tamaño dinámico
              ),
            ),
          ],
        ),
      ),
    );
  }
}
