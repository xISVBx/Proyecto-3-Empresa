import 'package:col_moda_empresa/domain/enums/snackbar_type.dart';
import 'package:flutter/material.dart';

SnackBar customeSnackBar({
  required BuildContext context,
  required SnackbarType type,
  required String text,
}) {
  return SnackBar(
    duration: const Duration(milliseconds: 1500),
    backgroundColor: switch (type) {
      SnackbarType.success => const Color(0xFF056400),
      SnackbarType.error => const Color(0xFF960500),
      SnackbarType.warning => const Color(0xFFFFC600),
      SnackbarType.info => Colors.indigo,
    },
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.up,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - 120,
      left: 10,
      right: 10,
    ),
    content: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 60.0, // Maximum height of the SnackBar
          ),
          child: SingleChildScrollView(
            child: Text(
              text,
              style: TextStyle(
                color: switch (type) {
                  SnackbarType.success => Colors.white,
                  SnackbarType.error => Colors.white,
                  SnackbarType.warning => Colors.grey[700],
                  SnackbarType.info => Colors.white,
                },
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget customeSnackBar2({
  required BuildContext context,
  required SnackbarType type,
  required String text,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      color: switch (type) {
        SnackbarType.success => const Color(0xFF056400),
        SnackbarType.error => const Color(0xFF960500),
        SnackbarType.warning => const Color(0xFFFFC600),
        SnackbarType.info => Colors.indigo,
      },
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check),
        SizedBox(
          width: 12.0,
        ),
        Text("This is a Custom Toast"),
      ],
    ),
  );
}