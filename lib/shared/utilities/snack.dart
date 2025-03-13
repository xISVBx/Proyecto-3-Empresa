import 'package:col_moda_empresa/domain/enums/snackbar_type.dart';
import 'package:col_moda_empresa/main.dart';
import 'package:col_moda_empresa/ui/widgets/snacks/snackbar.dart';
import 'package:col_moda_empresa/ui/config/app_router.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Snack {
  static final List<(SnackbarType, String)> colaMensajes =
      List.empty(growable: true);

  static void showSnackBar({required String text, required SnackbarType type}) {
    if (scaffoldMessengerKey.currentState != null &&
        scaffoldMessengerKey.currentContext != null) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        customeSnackBar(
          context: scaffoldMessengerKey.currentContext!,
          type: type,
          text: text,
        ),
      );
    } else {}
  }

  static void _showSnack2({
    required String text,
    required SnackbarType type,
    Toast? duration, // Parámetro opcional
  }) {
    if (navigatorKey.currentState != null &&
        navigatorKey.currentContext != null) {
      Fluttertoast.showToast(
        msg: text,
        toastLength: duration ??
            Toast.LENGTH_SHORT, // Usa el valor por defecto si no se pasa
        gravity: ToastGravity.TOP,
        backgroundColor: switch (type) {
          SnackbarType.success => const Color(0xFF056400),
          SnackbarType.error => const Color(0xFF960500),
          SnackbarType.warning => const Color(0xFFFFC600),
          SnackbarType.info => Colors.indigo,
        },
        timeInSecForIosWeb:
            duration == Toast.LENGTH_LONG ? 5 : 1, // Ajuste para web
        webPosition: "center",
      );
    }
  }

  static void success({required String text, Toast? duration}) {
    _showSnack2(text: text, type: SnackbarType.success, duration: duration);
  }

  static void error({required String text, Toast? duration}) {
    _showSnack2(text: text, type: SnackbarType.error, duration: duration);
  }

  static void warning({required String text, Toast? duration}) {
    _showSnack2(text: text, type: SnackbarType.warning, duration: duration);
  }

  static void info({required String text, Toast? duration}) {
    _showSnack2(text: text, type: SnackbarType.info, duration: duration);
  }
}
